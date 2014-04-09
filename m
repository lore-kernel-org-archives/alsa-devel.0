From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH] ASoC: core: Fix Sparse incompatible types warning
Date: Wed, 09 Apr 2014 09:21:48 +0200
Message-ID: <1397028108-10976-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: alsa-devel@alsa-project.org

Fix following Sparse warning:
sound/soc/soc-core.c:252:20: error: incompatible types in comparison expression (different type sizes)

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 sound/soc/soc-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 051c006281f5..41f6178249df 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -249,7 +249,7 @@ static ssize_t codec_reg_write_file(struct file *file,
 	struct snd_soc_codec *codec = file->private_data;
 	int ret;
 
-	buf_size = min(count, (sizeof(buf)-1));
+	buf_size = min(count, (size_t)(sizeof(buf)-1));
 	if (copy_from_user(buf, user_buf, buf_size))
 		return -EFAULT;
 	buf[buf_size] = 0;
-- 
1.8.3.2
