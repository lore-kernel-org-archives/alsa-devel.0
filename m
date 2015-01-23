From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 10/16] ALSA: line6: Drop voodoo workarounds
Date: Fri, 23 Jan 2015 18:13:17 +0100
Message-ID: <1422033203-23254-11-git-send-email-tiwai@suse.de>
References: <1422033203-23254-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 329542654E0
 for <alsa-devel@alsa-project.org>; Fri, 23 Jan 2015 18:13:40 +0100 (CET)
In-Reply-To: <1422033203-23254-1-git-send-email-tiwai@suse.de>
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Chris Rorvick <chris@rorvick.com>
List-Id: alsa-devel@alsa-project.org

If the problem still really remains, we should fix it instead of
papering over it like this...

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/line6/capture.c  | 12 ------------
 sound/usb/line6/playback.c | 12 ------------
 2 files changed, 24 deletions(-)

diff --git a/sound/usb/line6/capture.c b/sound/usb/line6/capture.c
index 97283e631e45..bad1b5b02786 100644
--- a/sound/usb/line6/capture.c
+++ b/sound/usb/line6/capture.c
@@ -297,18 +297,6 @@ static int snd_line6_capture_hw_params(struct snd_pcm_substream *substream,
 	int ret;
 	struct snd_line6_pcm *line6pcm = snd_pcm_substream_chip(substream);
 
-	/* -- Florian Demski [FD] */
-	/* don't ask me why, but this fixes the bug on my machine */
-	if (line6pcm == NULL) {
-		if (substream->pcm == NULL)
-			return -ENOMEM;
-		if (substream->pcm->private_data == NULL)
-			return -ENOMEM;
-		substream->private_data = substream->pcm->private_data;
-		line6pcm = snd_pcm_substream_chip(substream);
-	}
-	/* -- [FD] end */
-
 	ret = line6_pcm_acquire(line6pcm, LINE6_BIT_PCM_ALSA_CAPTURE_BUFFER);
 
 	if (ret < 0)
diff --git a/sound/usb/line6/playback.c b/sound/usb/line6/playback.c
index ab9a83f0f864..7e031b1761aa 100644
--- a/sound/usb/line6/playback.c
+++ b/sound/usb/line6/playback.c
@@ -445,18 +445,6 @@ static int snd_line6_playback_hw_params(struct snd_pcm_substream *substream,
 	int ret;
 	struct snd_line6_pcm *line6pcm = snd_pcm_substream_chip(substream);
 
-	/* -- Florian Demski [FD] */
-	/* don't ask me why, but this fixes the bug on my machine */
-	if (line6pcm == NULL) {
-		if (substream->pcm == NULL)
-			return -ENOMEM;
-		if (substream->pcm->private_data == NULL)
-			return -ENOMEM;
-		substream->private_data = substream->pcm->private_data;
-		line6pcm = snd_pcm_substream_chip(substream);
-	}
-	/* -- [FD] end */
-
 	ret = line6_pcm_acquire(line6pcm, LINE6_BIT_PCM_ALSA_PLAYBACK_BUFFER);
 
 	if (ret < 0)
-- 
2.2.2
