From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v4 09/10] ALSA: hda: replace .wallclock by
	.get_time_info
Date: Fri, 30 Jan 2015 17:56:02 -0600
Message-ID: <1422662163-7391-10-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1422662163-7391-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A832260836
 for <alsa-devel@alsa-project.org>; Sat, 31 Jan 2015 00:56:35 +0100 (CET)
In-Reply-To: <1422662163-7391-1-git-send-email-pierre-louis.bossart@linux.intel.com>
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

No real functional change, only take wall clock and system time
in same routine and add accuracy report.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/pci/hda/hda_controller.c | 40 +++++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index 271f86e..7ecda0e 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -732,17 +732,32 @@ static snd_pcm_uframes_t azx_pcm_pointer(struct snd_pcm_substream *substream)
 			       azx_get_position(chip, azx_dev));
 }
 
-static int azx_get_wallclock_tstamp(struct snd_pcm_substream *substream,
-				struct timespec *ts)
+static int azx_get_time_info(struct snd_pcm_substream *substream,
+			struct timespec *system_ts, struct timespec *audio_ts,
+			struct snd_pcm_audio_tstamp_config *audio_tstamp_config,
+			struct snd_pcm_audio_tstamp_report *audio_tstamp_report)
 {
 	struct azx_dev *azx_dev = get_azx_dev(substream);
 	u64 nsec;
 
-	nsec = timecounter_read(&azx_dev->azx_tc);
-	nsec = div_u64(nsec, 3); /* can be optimized */
-	nsec = azx_adjust_codec_delay(substream, nsec);
+	if ((substream->runtime->hw.info & SNDRV_PCM_INFO_HAS_LINK_ATIME) &&
+		(audio_tstamp_config->type_requested == SNDRV_PCM_AUDIO_TSTAMP_TYPE_LINK)) {
 
-	*ts = ns_to_timespec(nsec);
+		snd_pcm_gettime(substream->runtime, system_ts);
+
+		nsec = timecounter_read(&azx_dev->azx_tc);
+		nsec = div_u64(nsec, 3); /* can be optimized */
+		if (audio_tstamp_config->report_delay)
+			nsec = azx_adjust_codec_delay(substream, nsec);
+
+		*audio_ts = ns_to_timespec(nsec);
+
+		audio_tstamp_report->actual_type = SNDRV_PCM_AUDIO_TSTAMP_TYPE_LINK;
+		audio_tstamp_report->accuracy_report = 1; /* rest of structure is valid */
+		audio_tstamp_report->accuracy = 42; /* 24 MHz WallClock == 42ns resolution */
+
+	} else
+		audio_tstamp_report->actual_type = SNDRV_PCM_AUDIO_TSTAMP_TYPE_DEFAULT;
 
 	return 0;
 }
@@ -756,7 +771,8 @@ static struct snd_pcm_hardware azx_pcm_hw = {
 				 /* SNDRV_PCM_INFO_RESUME |*/
 				 SNDRV_PCM_INFO_PAUSE |
 				 SNDRV_PCM_INFO_SYNC_START |
-				 SNDRV_PCM_INFO_HAS_WALL_CLOCK |
+				 SNDRV_PCM_INFO_HAS_WALL_CLOCK | /* legacy */
+				 SNDRV_PCM_INFO_HAS_LINK_ATIME |
 				 SNDRV_PCM_INFO_NO_PERIOD_WAKEUP),
 	.formats =		SNDRV_PCM_FMTBIT_S16_LE,
 	.rates =		SNDRV_PCM_RATE_48000,
@@ -842,10 +858,12 @@ static int azx_pcm_open(struct snd_pcm_substream *substream)
 		return -EINVAL;
 	}
 
-	/* disable WALLCLOCK timestamps for capture streams
+	/* disable LINK_ATIME timestamps for capture streams
 	   until we figure out how to handle digital inputs */
-	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
-		runtime->hw.info &= ~SNDRV_PCM_INFO_HAS_WALL_CLOCK;
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
+		runtime->hw.info &= ~SNDRV_PCM_INFO_HAS_WALL_CLOCK; /* legacy */
+		runtime->hw.info &= ~SNDRV_PCM_INFO_HAS_LINK_ATIME;
+	}
 
 	spin_lock_irqsave(&chip->reg_lock, flags);
 	azx_dev->substream = substream;
@@ -877,7 +895,7 @@ static struct snd_pcm_ops azx_pcm_ops = {
 	.prepare = azx_pcm_prepare,
 	.trigger = azx_pcm_trigger,
 	.pointer = azx_pcm_pointer,
-	.wall_clock =  azx_get_wallclock_tstamp,
+	.get_time_info =  azx_get_time_info,
 	.mmap = azx_pcm_mmap,
 	.page = snd_pcm_sgbuf_ops_page,
 };
-- 
1.9.1
