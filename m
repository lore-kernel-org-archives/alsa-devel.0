From: Dylan Reid <dgreid@chromium.org>
Subject: [PATCH] ALSA: hda - Apply codec delay to wallclock.
Date: Fri,  5 Apr 2013 17:22:04 -0700
Message-ID: <1365207724-6288-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oa0-f74.google.com (mail-oa0-f74.google.com
 [209.85.219.74])
 by alsa0.perex.cz (Postfix) with ESMTP id A4AEE2615E8
 for <alsa-devel@alsa-project.org>; Sat,  6 Apr 2013 02:22:49 +0200 (CEST)
Received: by mail-oa0-f74.google.com with SMTP id k14so1036318oag.1
 for <alsa-devel@alsa-project.org>; Fri, 05 Apr 2013 17:22:48 -0700 (PDT)
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

For playback add the codec-side delay to the timestamp, for capture
subtract it.  This brings the timestamps in line with the time that
was recently added to the delay reporting.

Signed-off-by: Dylan Reid <dgreid@chromium.org>
---
 sound/pci/hda/hda_intel.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 735567e..ec8ac71 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1889,6 +1889,27 @@ static void azx_timecounter_init(struct snd_pcm_substream *substream,
 		tc->cycle_last = last;
 }
 
+static u64 azx_add_codec_delay_nsec(struct snd_pcm_substream *substream,
+				u64 nsec)
+{
+	struct azx_pcm *apcm = snd_pcm_substream_chip(substream);
+	int stream = substream->stream;
+	struct hda_pcm_stream *hinfo = apcm->hinfo[stream];
+	struct hda_codec *codec = apcm->codec;
+	u64 codec_nsec;
+
+	if (hinfo->ops.get_delay) {
+		codec_nsec =
+			hinfo->ops.get_delay(hinfo, codec, substream) * 1000000;
+		if (stream == SNDRV_PCM_STREAM_CAPTURE)
+			nsec = (nsec > codec_nsec) ? nsec - codec_nsec : 0;
+		else if (stream == SNDRV_PCM_STREAM_PLAYBACK)
+			nsec += codec_nsec;
+	}
+
+	return nsec;
+}
+
 static int azx_get_wallclock_tstamp(struct snd_pcm_substream *substream,
 				struct timespec *ts)
 {
@@ -1897,6 +1918,7 @@ static int azx_get_wallclock_tstamp(struct snd_pcm_substream *substream,
 
 	nsec = timecounter_read(&azx_dev->azx_tc);
 	nsec = div_u64(nsec, 3); /* can be optimized */
+	nsec = azx_add_codec_delay_nsec(substream, nsec);
 
 	*ts = ns_to_timespec(nsec);
 
-- 
1.8.1.3.605.g02339dd
