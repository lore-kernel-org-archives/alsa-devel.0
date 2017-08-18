From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 11/14] ASoC: sunxi: constify snd_soc_dai_ops structures
Date: Fri, 18 Aug 2017 17:36:08 +0530
Message-ID: <1503057971-16033-12-git-send-email-arvind.yadav.cs@gmail.com>
References: <1503057971-16033-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1503057971-16033-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bardliao@realtek.com, oder_chiou@realtek.com, timur@tabi.org, lgirdwood@gmail.com, broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

snd_soc_dai_ops are not supposed to change at runtime. All functions
working with snd_soc_dai_ops provided by <sound/soc-dai.h> work with
const snd_soc_dai_ops. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 sound/soc/sunxi/sun8i-codec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index 5723c34..253ae0b 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -341,7 +341,7 @@ static int sun8i_codec_hw_params(struct snd_pcm_substream *substream,
 	  "AIF1 Slot 0 Right"},
 };
 
-static struct snd_soc_dai_ops sun8i_codec_dai_ops = {
+static const struct snd_soc_dai_ops sun8i_codec_dai_ops = {
 	.hw_params = sun8i_codec_hw_params,
 	.set_fmt = sun8i_set_fmt,
 };
-- 
1.9.1
