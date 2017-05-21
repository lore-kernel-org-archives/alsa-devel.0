From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 03/16] ALSA: dummy: Convert to copy_silence ops
Date: Sun, 21 May 2017 22:09:37 +0200
Message-ID: <20170521200950.4592-4-tiwai@suse.de>
References: <20170521200950.4592-1-tiwai@suse.de>
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <20170521200950.4592-1-tiwai@suse.de>
Sender: linux-media-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>, Mark Brown <broonie@kernel.org>, Bluecherry Maintainers <maintainers@bluecherrydvr.com>, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

It's a dummy ops, so just replacing it.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/drivers/dummy.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/sound/drivers/dummy.c b/sound/drivers/dummy.c
index 172dacd925f5..68519689a9ea 100644
--- a/sound/drivers/dummy.c
+++ b/sound/drivers/dummy.c
@@ -645,14 +645,8 @@ static int alloc_fake_buffer(void)
 
 static int dummy_pcm_copy(struct snd_pcm_substream *substream,
 			  int channel, snd_pcm_uframes_t pos,
-			  void __user *dst, snd_pcm_uframes_t count)
-{
-	return 0; /* do nothing */
-}
-
-static int dummy_pcm_silence(struct snd_pcm_substream *substream,
-			     int channel, snd_pcm_uframes_t pos,
-			     snd_pcm_uframes_t count)
+			  void __user *dst, snd_pcm_uframes_t count,
+			  bool in_kernel)
 {
 	return 0; /* do nothing */
 }
@@ -683,8 +677,7 @@ static struct snd_pcm_ops dummy_pcm_ops_no_buf = {
 	.prepare =	dummy_pcm_prepare,
 	.trigger =	dummy_pcm_trigger,
 	.pointer =	dummy_pcm_pointer,
-	.copy =		dummy_pcm_copy,
-	.silence =	dummy_pcm_silence,
+	.copy_silence =	dummy_pcm_copy,
 	.page =		dummy_pcm_page,
 };
 
-- 
2.13.0
