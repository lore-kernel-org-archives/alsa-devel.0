From: Dylan Reid <dgreid@chromium.org>
Subject: [PATCH] ALSA: hda - Add codec delay to the capture
	time stamp.
Date: Mon, 15 Apr 2013 11:57:05 -0700
Message-ID: <1366052225-27828-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qe0-f73.google.com (mail-qe0-f73.google.com
 [209.85.128.73])
 by alsa0.perex.cz (Postfix) with ESMTP id E200F265206
 for <alsa-devel@alsa-project.org>; Mon, 15 Apr 2013 20:57:25 +0200 (CEST)
Received: by mail-qe0-f73.google.com with SMTP id 1so496500qee.2
 for <alsa-devel@alsa-project.org>; Mon, 15 Apr 2013 11:57:25 -0700 (PDT)
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
Cc: tiwai@suse.de, Dylan Reid <dgreid@chromium.org>, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

For capture, the delay through the codec contributes to the time stamp
of the sample recorded at the A to D.  Rename the codec time stamp
function appropriately.

Signed-off-by: Dylan Reid <dgreid@chromium.org>
---
 sound/pci/hda/hda_intel.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 63734b5..7b213d5 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1889,7 +1889,7 @@ static void azx_timecounter_init(struct snd_pcm_substream *substream,
 		tc->cycle_last = last;
 }
 
-static u64 azx_subtract_codec_delay(struct snd_pcm_substream *substream,
+static u64 azx_adjust_codec_delay(struct snd_pcm_substream *substream,
 				u64 nsec)
 {
 	struct azx_pcm *apcm = snd_pcm_substream_chip(substream);
@@ -1903,6 +1903,9 @@ static u64 azx_subtract_codec_delay(struct snd_pcm_substream *substream,
 	codec_nsecs = div_u64(codec_frames * 1000000000LL,
 			      substream->runtime->rate);
 
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
+		return nsec + codec_nsecs;
+
 	return (nsec > codec_nsecs) ? nsec - codec_nsecs : 0;
 }
 
@@ -1914,7 +1917,7 @@ static int azx_get_wallclock_tstamp(struct snd_pcm_substream *substream,
 
 	nsec = timecounter_read(&azx_dev->azx_tc);
 	nsec = div_u64(nsec, 3); /* can be optimized */
-	nsec = azx_subtract_codec_delay(substream, nsec);
+	nsec = azx_adjust_codec_delay(substream, nsec);
 
 	*ts = ns_to_timespec(nsec);
 
-- 
1.8.1.3.605.g02339dd
