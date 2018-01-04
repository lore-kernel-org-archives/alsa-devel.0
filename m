From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: pcm: Workaround for weird PulseAudio
	behavior on rewind error
Date: Thu,  4 Jan 2018 18:07:43 +0100
Message-ID: <20180104170743.23887-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 3AE3E267900
 for <alsa-devel@alsa-project.org>; Thu,  4 Jan 2018 18:07:45 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id A174AACEC
 for <alsa-devel@alsa-project.org>; Thu,  4 Jan 2018 17:07:45 +0000 (UTC)
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
List-Id: alsa-devel@alsa-project.org

The commit 9027c4639ef1 ("ALSA: pcm: Call ack() whenever appl_ptr is
updated") introduced the possible error code returned from the PCM
rewind ioctl.  Basically the change was for handling the indirect PCM
more correctly, but ironically, it caused rather a side-effect:
PulseAudio gets pissed off when receiving an error from rewind, throws
everything away and stops processing further, resulting in the
silence.

It's clearly a failure in the application side, so the best would be
to fix that bug in PA.  OTOH, PA is mostly the only user of the rewind
feature, so it's not good to slap the sole customer.

This patch tries to mitigate the situation: instead of returning an
error, now the rewind ioctl returns zero when the driver can't rewind.
It indicates that no rewind was performed, so the behavior is
consistent, at least.

Fixes: 9027c4639ef1 ("ALSA: pcm: Call ack() whenever appl_ptr is updated")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_native.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index a4d92e46c459..f08772568c17 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -2580,7 +2580,7 @@ static snd_pcm_sframes_t forward_appl_ptr(struct snd_pcm_substream *substream,
 	return ret < 0 ? ret : frames;
 }
 
-/* decrease the appl_ptr; returns the processed frames or a negative error */
+/* decrease the appl_ptr; returns the processed frames or zero for error */
 static snd_pcm_sframes_t rewind_appl_ptr(struct snd_pcm_substream *substream,
 					 snd_pcm_uframes_t frames,
 					 snd_pcm_sframes_t avail)
@@ -2597,7 +2597,12 @@ static snd_pcm_sframes_t rewind_appl_ptr(struct snd_pcm_substream *substream,
 	if (appl_ptr < 0)
 		appl_ptr += runtime->boundary;
 	ret = pcm_lib_apply_appl_ptr(substream, appl_ptr);
-	return ret < 0 ? ret : frames;
+	/* NOTE: we return zero for errors because PulseAudio gets depressed
+	 * upon receiving an error from rewind ioctl and stops processing
+	 * any longer.  Returning zero means that no rewind is done, so
+	 * it's not absolutely wrong to answer like that.
+	 */
+	return ret < 0 ? 0 : frames;
 }
 
 static snd_pcm_sframes_t snd_pcm_playback_rewind(struct snd_pcm_substream *substream,
-- 
2.15.1
