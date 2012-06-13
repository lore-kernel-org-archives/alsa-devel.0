From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 2/2] ALSA: hda: support for wallclock timestamps
Date: Wed, 13 Jun 2012 15:26:32 -0500
Message-ID: <1339619192-2733-3-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1339619192-2733-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 50D4E104543
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Jun 2012 22:26:46 +0200 (CEST)
In-Reply-To: <1339619192-2733-1-git-send-email-pierre-louis.bossart@linux.intel.com>
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

reuse code from clocksource to handle wall clock counter,
translate cycles to timespec. The code wasn't reused as
is as the HDA wall clock is based on 24MHz ticks. To avoid
compounding rounding errors, the counters track cycles
and will convert elapsed cycles to ns, instead of delta cycles
as done in the cyclecounter code.
Since wrapparound occurs, the timestamps are reinitialized with
monotonic time on a trigger.

TODO:
- only re-init timecounter if there was no device active.
- Keep the same timestamp for all devices on same chip.
- make sure no overflow occurs in the 125/3 scaling implementation

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/pci/hda/hda_intel.c |  106 ++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 105 insertions(+), 1 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 2b6392b..f9b9bc1 100644
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
@@ -426,6 +430,15 @@ struct azx_pcm {
 	struct list_head list;
 };
 
+struct azx_timecounter {
+	cycle_t cycle_last;
+	cycle_t mask;
+	cycle_t elapsed_cycles;
+	u64     initial_time_nsec;
+	u32     mult;
+	u32     shift;
+};
+
 struct azx {
 	struct snd_card *card;
 	struct pci_dev *pci;
@@ -496,6 +509,9 @@ struct azx {
 
 	/* reboot notifier (for mysterious hangup problem at power-down) */
 	struct notifier_block reboot_notifier;
+
+	/* Wall clock counter */
+	struct azx_timecounter tc;
 };
 
 /* driver types */
@@ -1699,6 +1715,89 @@ static inline void azx_release_device(struct azx_dev *azx_dev)
 	azx_dev->opened = 0;
 }
 
+static void azx_timecounter_init(struct azx *chip)
+{
+	struct azx_timecounter *tc = &chip->tc;
+	struct timespec ts;
+
+	tc->cycle_last = azx_readl(chip, WALLCLK);
+	tc->elapsed_cycles = 0;
+	tc->mask = CLOCKSOURCE_MASK(32);
+	/*
+	 * conversion from 24MHz to nsec requires fractional operation,
+	 * approximate 125/3 ratio
+	 */
+#define NBITS_NS 16
+	tc->mult = (u32)(1<<NBITS_NS)*125L/3L;
+	tc->shift = NBITS_NS;
+
+	/* save initial time */
+	ktime_get_ts(&ts);
+	tc->initial_time_nsec = timespec_to_ns(&ts);
+}
+
+/**
+ * azx_timecounter_read_delta - get nanoseconds since last call of this function
+ * @tc:         Pointer to time counter
+ *
+ * When the underlying cycle counter runs over, this will be handled
+ * correctly as long as it does not run over more than once between
+ * calls.
+ *
+ * The first call to this function for a new time counter initializes
+ * the time tracking and returns an undefined result.
+ */
+static u64 azx_timecounter_read_delta(struct azx_timecounter *tc,
+				cycle_t cycle_now)
+{
+	cycle_t cycle_delta;
+	u64 nsec;
+
+	/* calculate the delta since the last timecounter_read_delta(): */
+	cycle_delta = (cycle_now - tc->cycle_last) & tc->mask;
+
+	tc->elapsed_cycles += cycle_delta;
+
+	/* convert to nanoseconds: */
+	nsec = (u64)tc->elapsed_cycles;
+	nsec = (nsec * tc->mult) >> tc->shift;
+
+	/* update time stamp of azx_timecounter_read_delta() call: */
+	tc->cycle_last = cycle_now;
+
+	return nsec;
+}
+
+u64 azx_timecounter_read(struct azx *chip)
+{
+	u64 nsec;
+	struct azx_timecounter *tc = &chip->tc;
+	cycle_t cycle_now;
+
+	/* read cycle counter: */
+	cycle_now = azx_readl(chip, WALLCLK);
+
+	/* increment time by nanoseconds since last call */
+	nsec = azx_timecounter_read_delta(tc, cycle_now);
+	nsec += tc->initial_time_nsec;
+
+	return nsec;
+}
+
+
+static int azx_get_wallclock_tstamp(struct snd_pcm_substream *substream,
+				struct timespec *ts)
+{
+	struct azx_pcm *apcm = snd_pcm_substream_chip(substream);
+	struct azx *chip = apcm->chip;
+	u64 nsec;
+
+	nsec = azx_timecounter_read(chip);
+	*ts = ns_to_timespec(nsec);
+
+	return 0;
+}
+
 static struct snd_pcm_hardware azx_pcm_hw = {
 	.info =			(SNDRV_PCM_INFO_MMAP |
 				 SNDRV_PCM_INFO_INTERLEAVED |
@@ -1708,6 +1807,7 @@ static struct snd_pcm_hardware azx_pcm_hw = {
 				 /* SNDRV_PCM_INFO_RESUME |*/
 				 SNDRV_PCM_INFO_PAUSE |
 				 SNDRV_PCM_INFO_SYNC_START |
+				 SNDRV_PCM_INFO_HAS_WALL_CLOCK |
 				 SNDRV_PCM_INFO_NO_PERIOD_WAKEUP),
 	.formats =		SNDRV_PCM_FMTBIT_S16_LE,
 	.rates =		SNDRV_PCM_RATE_48000,
@@ -1981,8 +2081,10 @@ static int azx_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
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
@@ -1998,6 +2100,7 @@ static int azx_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 				break;
 			cpu_relax();
 		}
+		azx_timecounter_init(chip);
 	} else {
 		/* wait until all RUN bits are cleared */
 		for (timeout = 5000; timeout; timeout--) {
@@ -2239,6 +2342,7 @@ static struct snd_pcm_ops azx_pcm_ops = {
 	.prepare = azx_pcm_prepare,
 	.trigger = azx_pcm_trigger,
 	.pointer = azx_pcm_pointer,
+	.wall_clock =  azx_get_wallclock_tstamp,
 	.mmap = azx_pcm_mmap,
 	.page = snd_pcm_sgbuf_ops_page,
 };
-- 
1.7.6.5
