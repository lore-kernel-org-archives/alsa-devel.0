From: Dylan Reid <dgreid@chromium.org>
Subject: [PATCH v2] ALSA: hda - Apply codec delay to wallclock.
Date: Mon,  8 Apr 2013 18:20:30 -0700
Message-ID: <1365470430-22292-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f202.google.com (mail-ob0-f202.google.com
 [209.85.214.202])
 by alsa0.perex.cz (Postfix) with ESMTP id E0198265D3B
 for <alsa-devel@alsa-project.org>; Tue,  9 Apr 2013 03:20:34 +0200 (CEST)
Received: by mail-ob0-f202.google.com with SMTP id va7so509154obc.5
 for <alsa-devel@alsa-project.org>; Mon, 08 Apr 2013 18:20:33 -0700 (PDT)
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
Changes since v1:
Calculate nsec from frames, subtract delay for playback as well as
capture.

 sound/pci/hda/hda_intel.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 735567e..3e6f2c6 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1889,6 +1889,23 @@ static void azx_timecounter_init(struct snd_pcm_substream *substream,
 		tc->cycle_last = last;
 }
 
+static u64 azx_subtract_codec_delay(struct snd_pcm_substream *substream,
+				u64 nsec)
+{
+	struct azx_pcm *apcm = snd_pcm_substream_chip(substream);
+	struct hda_pcm_stream *hinfo = apcm->hinfo[substream->stream];
+	u64 codec_frames, codec_nsecs;
+
+	if (!hinfo->ops.get_delay)
+		return nsec;
+
+	codec_frames = hinfo->ops.get_delay(hinfo, apcm->codec, substream);
+	codec_nsecs = div_u64(codec_frames * 1000000000LL,
+			      substream->runtime->rate);
+
+	return (nsec > codec_nsecs) ? nsec - codec_nsecs : 0;
+}
+
 static int azx_get_wallclock_tstamp(struct snd_pcm_substream *substream,
 				struct timespec *ts)
 {
@@ -1897,6 +1914,7 @@ static int azx_get_wallclock_tstamp(struct snd_pcm_substream *substream,
 
 	nsec = timecounter_read(&azx_dev->azx_tc);
 	nsec = div_u64(nsec, 3); /* can be optimized */
+	nsec = azx_subtract_codec_delay(substream, nsec);
 
 	*ts = ns_to_timespec(nsec);
 
-- 
1.8.1.3.605.g02339dd
