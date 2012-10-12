From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v3 3/3] ALSA: hda: support for wallclock
	timestamps
Date: Fri, 12 Oct 2012 12:05:37 -0500
Message-ID: <1350061537-10166-3-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1350061537-10166-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B514265B5E
 for <alsa-devel@alsa-project.org>; Fri, 12 Oct 2012 19:06:19 +0200 (CEST)
In-Reply-To: <1350061537-10166-1-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Reuse code from clocksource to handle wall clock counter.
Since wrapparound occurs, the audio timestamp is reinitialized
to zero on a trigger. Synchronized linked devices will
start counting from same reference to avoid any drift.

Max buffer time is limited to 178 seconds to make sure
wall clock counter does not overflow

Wallclock timestamps are disabled on capture streams
until we figure out how to handle digital inputs.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/pci/hda/hda_intel.c |   95 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 84ff1e8..47205e4 100644
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
@@ -406,6 +410,9 @@ struct azx_dev {
 	 */
 	unsigned int insufficient :1;
 	unsigned int wc_marked:1;
+
+	struct timecounter  azx_tc;
+	struct cyclecounter azx_cc;
 };
 
 /* CORB/RIRB */
@@ -1703,6 +1710,64 @@ static inline void azx_release_device(struct azx_dev *azx_dev)
 	azx_dev->opened = 0;
 }
 
+static cycle_t azx_cc_read(const struct cyclecounter *cc)
+{
+	struct azx_dev *azx_dev = container_of(cc, struct azx_dev, azx_cc);
+	struct snd_pcm_substream *substream = azx_dev->substream;
+	struct azx_pcm *apcm = snd_pcm_substream_chip(substream);
+	struct azx *chip = apcm->chip;
+
+	return azx_readl(chip, WALLCLK);
+}
+
+static void azx_timecounter_init(struct snd_pcm_substream *substream,
+				bool force, cycle_t last)
+{
+	struct azx_dev *azx_dev = get_azx_dev(substream);
+	struct timecounter *tc = &azx_dev->azx_tc;
+	struct cyclecounter *cc = &azx_dev->azx_cc;
+	u64 nsec;
+
+	cc->read = azx_cc_read;
+	cc->mask = CLOCKSOURCE_MASK(32);
+
+	/*
+	 * Converting from 24 MHz to ns means applying a 125/3 factor.
+	 * To avoid any saturation issues in intermediate operations,
+	 * the 125 factor is applied first. The division is applied
+	 * last after reading the timecounter value.
+	 * Applying the 1/3 factor as part of the multiplication
+	 * requires at least 20 bits for a decent precision, however
+	 * overflows occur after about 4 hours or less, not a option.
+	 */
+
+	cc->mult = 125; /* saturation after 195 years */
+	cc->shift = 0;
+
+	nsec = 0; /* audio time is elapsed time since trigger */
+	timecounter_init(tc, cc, nsec);
+	if (force)
+		/*
+		 * force timecounter to use predefined value,
+		 * used for synchronized starts
+		 */
+		tc->cycle_last = last;
+}
+
+static int azx_get_wallclock_tstamp(struct snd_pcm_substream *substream,
+				struct timespec *ts)
+{
+	struct azx_dev *azx_dev = get_azx_dev(substream);
+	u64 nsec;
+
+	nsec = timecounter_read(&azx_dev->azx_tc);
+	nsec = div_u64(nsec, 3); /* can be optimized */
+
+	*ts = ns_to_timespec(nsec);
+
+	return 0;
+}
+
 static struct snd_pcm_hardware azx_pcm_hw = {
 	.info =			(SNDRV_PCM_INFO_MMAP |
 				 SNDRV_PCM_INFO_INTERLEAVED |
@@ -1712,6 +1777,7 @@ static struct snd_pcm_hardware azx_pcm_hw = {
 				 /* SNDRV_PCM_INFO_RESUME |*/
 				 SNDRV_PCM_INFO_PAUSE |
 				 SNDRV_PCM_INFO_SYNC_START |
+				 SNDRV_PCM_INFO_HAS_WALL_CLOCK |
 				 SNDRV_PCM_INFO_NO_PERIOD_WAKEUP),
 	.formats =		SNDRV_PCM_FMTBIT_S16_LE,
 	.rates =		SNDRV_PCM_RATE_48000,
@@ -1751,6 +1817,12 @@ static int azx_pcm_open(struct snd_pcm_substream *substream)
 	runtime->hw.rates = hinfo->rates;
 	snd_pcm_limit_hw_rates(runtime);
 	snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS);
+
+	/* avoid wrap-around with wall-clock */
+	snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_BUFFER_TIME,
+				20,
+				178000000);
+
 	if (chip->align_buffer_size)
 		/* constrain buffer sizes to be multiple of 128
 		   bytes. This is more efficient in terms of memory
@@ -1790,6 +1862,12 @@ static int azx_pcm_open(struct snd_pcm_substream *substream)
 		mutex_unlock(&chip->open_mutex);
 		return -EINVAL;
 	}
+
+	/* disable WALLCLOCK timestamps for capture streams
+	   until we figure out how to handle digital inputs */
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
+		runtime->hw.info &= ~SNDRV_PCM_INFO_HAS_WALL_CLOCK;
+
 	spin_lock_irqsave(&chip->reg_lock, flags);
 	azx_dev->substream = substream;
 	azx_dev->running = 0;
@@ -2024,6 +2102,22 @@ static int azx_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 			azx_readl(chip, OLD_SSYNC) & ~sbits);
 	else
 		azx_writel(chip, SSYNC, azx_readl(chip, SSYNC) & ~sbits);
+	if (start) {
+		azx_timecounter_init(substream, 0, 0);
+		if (nsync > 1) {
+			cycle_t cycle_last;
+
+			/* same start cycle for master and group */
+			azx_dev = get_azx_dev(substream);
+			cycle_last = azx_dev->azx_tc.cycle_last;
+
+			snd_pcm_group_for_each_entry(s, substream) {
+				if (s->pcm->card != substream->pcm->card)
+					continue;
+				azx_timecounter_init(s, 1, cycle_last);
+			}
+		}
+	}
 	spin_unlock(&chip->reg_lock);
 	return 0;
 }
@@ -2260,6 +2354,7 @@ static struct snd_pcm_ops azx_pcm_ops = {
 	.prepare = azx_pcm_prepare,
 	.trigger = azx_pcm_trigger,
 	.pointer = azx_pcm_pointer,
+	.wall_clock =  azx_get_wallclock_tstamp,
 	.mmap = azx_pcm_mmap,
 	.page = snd_pcm_sgbuf_ops_page,
 };
-- 
1.7.9.5
