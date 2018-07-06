From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Subject: [PATCH] sound: stm32: replace "%p" with "%pK"
Date: Fri,  6 Jul 2018 15:07:03 +0200
Message-ID: <20180706130703.22352-1-benjamin.gaignard@st.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, arnaud.pouliquen@st.com
Cc: alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Benjamin Gaignard <benjamin.gaignard@st.com>
List-Id: alsa-devel@alsa-project.org

The format specifier "%p" can leak kernel addresses.
Use "%pK" instead.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 sound/soc/stm/stm32_adfsdm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/stm/stm32_adfsdm.c b/sound/soc/stm/stm32_adfsdm.c
index db73fef3e500..0e9373064032 100644
--- a/sound/soc/stm/stm32_adfsdm.c
+++ b/sound/soc/stm/stm32_adfsdm.c
@@ -149,7 +149,7 @@ static int stm32_afsdm_pcm_cb(const void *data, size_t size, void *private)
 	unsigned int old_pos = priv->pos;
 	unsigned int cur_size = size;
 
-	dev_dbg(rtd->dev, "%s: buff_add :%p, pos = %d, size = %zu\n",
+	dev_dbg(rtd->dev, "%s: buff_add :%pK, pos = %d, size = %zu\n",
 		__func__, &pcm_buff[priv->pos], priv->pos, size);
 
 	if ((priv->pos + size) > buff_size) {
-- 
2.15.0
