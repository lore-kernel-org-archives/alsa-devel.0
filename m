From: Shakil A Khan <shakilk1729@gmail.com>
Subject: [PATCH] Removed unused variable i from sound/soc/soc-pcm.c Signed-off-by: Shakil A Khan <shakilk1729@gmail.com>
Date: Thu,  1 Jan 2015 09:01:21 -0800
Message-ID: <1420131681-74211-1-git-send-email-shakilk1729@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tiwai@suse.de
Cc: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Shakil A Khan <shakilk1729@gmail.com>
List-Id: alsa-devel@alsa-project.org

---
 sound/soc/soc-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index d6e8d6b..6b0136e 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -304,7 +304,7 @@ static bool soc_pcm_has_symmetry(struct snd_pcm_substream *substream)
 static void soc_pcm_set_msb(struct snd_pcm_substream *substream, int bits)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	int ret, i;
+	int ret;
 
 	if (!bits)
 		return;
-- 
1.9.1
