From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] ALSA : pcsp: pcsp_lib: constify snd_pcsp_playback_ops
Date: Fri,  9 Jun 2017 11:39:56 +0530
Message-ID: <0ef4f01bbb4cb6d9bea26845fbbcb087406f6798.1496988452.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

File size before:
   text	   data	    bss	    dec	    hex	filename
   2027	    168	      1	   2196	    894	sound/drivers/pcsp/pcsp_lib.o

File size After:
   text	   data	    bss	    dec	    hex	filename
   2155	     40	      1	   2196	    894	sound/drivers/pcsp/pcsp_lib.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 sound/drivers/pcsp/pcsp_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/drivers/pcsp/pcsp_lib.c b/sound/drivers/pcsp/pcsp_lib.c
index aca2d7d..44b3632 100644
--- a/sound/drivers/pcsp/pcsp_lib.c
+++ b/sound/drivers/pcsp/pcsp_lib.c
@@ -323,7 +323,7 @@ static int snd_pcsp_playback_open(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static struct snd_pcm_ops snd_pcsp_playback_ops = {
+static const struct snd_pcm_ops snd_pcsp_playback_ops = {
 	.open = snd_pcsp_playback_open,
 	.close = snd_pcsp_playback_close,
 	.ioctl = snd_pcm_lib_ioctl,
-- 
1.9.1
