From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5/6] ALSA: pcm: Use common PCM_RUNTIME_CHECK()
	for sanity checks
Date: Tue, 13 Jun 2017 16:18:11 +0200
Message-ID: <20170613141812.21220-6-tiwai@suse.de>
References: <20170613141812.21220-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 371BE266F07
 for <alsa-devel@alsa-project.org>; Tue, 13 Jun 2017 16:18:16 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 5C38DAE88
 for <alsa-devel@alsa-project.org>; Tue, 13 Jun 2017 14:18:14 +0000 (UTC)
In-Reply-To: <20170613141812.21220-1-tiwai@suse.de>
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

Just a code cleanup.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_native.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 0941b9c92b3f..05858c91c0ea 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -2869,7 +2869,7 @@ static int snd_pcm_playback_ioctl1(struct file *file,
 				   struct snd_pcm_substream *substream,
 				   unsigned int cmd, void __user *arg)
 {
-	if (snd_BUG_ON(!substream))
+	if (PCM_RUNTIME_CHECK(substream))
 		return -ENXIO;
 	if (snd_BUG_ON(substream->stream != SNDRV_PCM_STREAM_PLAYBACK))
 		return -EINVAL;
@@ -2949,7 +2949,7 @@ static int snd_pcm_capture_ioctl1(struct file *file,
 				  struct snd_pcm_substream *substream,
 				  unsigned int cmd, void __user *arg)
 {
-	if (snd_BUG_ON(!substream))
+	if (PCM_RUNTIME_CHECK(substream))
 		return -ENXIO;
 	if (snd_BUG_ON(substream->stream != SNDRV_PCM_STREAM_CAPTURE))
 		return -EINVAL;
-- 
2.13.1
