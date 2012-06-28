From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 2/2] ALSA: hda: support for wallclock timestamps
Date: Thu, 28 Jun 2012 16:12:35 -0500
Message-ID: <1340917955-31422-3-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1340917955-31422-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id CE1A724454
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Jun 2012 23:12:44 +0200 (CEST)
In-Reply-To: <1340917955-31422-1-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

reuse code from clocksource to handle wall clock counter.
Since wrapparound occurs, the timestamps are reinitialized with
monotonic time on a trigger.

TODO:
- only re-init timecounter if there was no device active.
- Keep the same timestamp for all devices on same chip.
- make sure no overflow occurs in the 125/3 scaling implementation

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/pci/hda/hda_intel.c |   54 ++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 53 insertions(+), 1 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 86758dd..9bb795b 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -46,6 +46,10 @@
 #include <linux/mutex.h>
 #include <linux/reboot.h>
 #include <linux/io.h>
+
+#include <linux/clocksource.h>
+#include <linux/time.h>
+
 #ifdef CONFIG_X86
 /* for snoop control */
 #include <asm/pgtable.h>
@@ -496,6 +500,10 @@ struct azx {
 
 	/* reboot notifier (for mysterious hangup problem at power-down) */
 	struct notifier_block reboot_notifier;
+
+	struct timecounter  azx_tc;
+	struct cyclecounter azx_cc;
+
 };
 
 /* driver types */
@@ -1700,6 +1708,45 @@ static inline void azx_release_device(struct azx_dev *azx_dev)
 	azx_dev->opened = 0;
 }
 
+static cycle_t azx_cc_read(const struct cyclecounter *cc)
+{
+	struct azx *chip = container_of(cc, struct azx, azx_cc);
+
+	return azx_readl(chip, WALLCLK);
+}
+
+static void azx_timecounter_init(struct azx *chip)
+{
+	struct timecounter *tc = &chip->azx_tc;
+	struct cyclecounter *cc = &chip->azx_cc;
+	struct timespec ts;
+	u64 nsec;
+
+	cc->read = azx_cc_read;
+	cc->mask = CLOCKSOURCE_MASK(32);
+
+#define NBITS_NS 12 /* accuracy issues in cyc2ns with lower number of bits */
+	cc->mult = clocksource_khz2mult(24000, NBITS_NS);
+	cc->shift = NBITS_NS;
+
+	ktime_get_ts(&ts);
+	nsec = timespec_to_ns(&ts);
+	timecounter_init(tc, cc, nsec);
+}
+
+static int azx_get_wallclock_tstamp(struct snd_pcm_substream *substream,
+				struct timespec *ts)
+{
+	struct azx_pcm *apcm = snd_pcm_substream_chip(substream);
+	struct azx *chip = apcm->chip;
+	u64 nsec;
+
+	nsec = timecounter_read(&chip->azx_tc);
+	*ts = ns_to_timespec(nsec);
+
+	return 0;
+}
+
 static struct snd_pcm_hardware azx_pcm_hw = {
 	.info =			(SNDRV_PCM_INFO_MMAP |
 				 SNDRV_PCM_INFO_INTERLEAVED |
@@ -1709,6 +1756,7 @@ static struct snd_pcm_hardware azx_pcm_hw = {
 				 /* SNDRV_PCM_INFO_RESUME |*/
 				 SNDRV_PCM_INFO_PAUSE |
 				 SNDRV_PCM_INFO_SYNC_START |
+				 SNDRV_PCM_INFO_HAS_WALL_CLOCK |
 				 SNDRV_PCM_INFO_NO_PERIOD_WAKEUP),
 	.formats =		SNDRV_PCM_FMTBIT_S16_LE,
 	.rates =		SNDRV_PCM_RATE_48000,
@@ -1982,8 +2030,10 @@ static int azx_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	}
 	spin_unlock(&chip->reg_lock);
 	if (start) {
-		if (nsync == 1)
+		if (nsync == 1) {
+			azx_timecounter_init(chip);
 			return 0;
+		}
 		/* wait until all FIFOs get ready */
 		for (timeout = 5000; timeout; timeout--) {
 			nwait = 0;
@@ -1999,6 +2049,7 @@ static int azx_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 				break;
 			cpu_relax();
 		}
+		azx_timecounter_init(chip);
 	} else {
 		/* wait until all RUN bits are cleared */
 		for (timeout = 5000; timeout; timeout--) {
@@ -2240,6 +2291,7 @@ static struct snd_pcm_ops azx_pcm_ops = {
 	.prepare = azx_pcm_prepare,
 	.trigger = azx_pcm_trigger,
 	.pointer = azx_pcm_pointer,
+	.wall_clock =  azx_get_wallclock_tstamp,
 	.mmap = azx_pcm_mmap,
 	.page = snd_pcm_sgbuf_ops_page,
 };
-- 
1.7.6.5
