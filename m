From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 03/14] ASoC: dwc: constify snd_soc_dai_ops structures
Date: Fri, 18 Aug 2017 17:36:00 +0530
Message-ID: <1503057971-16033-4-git-send-email-arvind.yadav.cs@gmail.com>
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
 sound/soc/dwc/dwc-i2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/dwc/dwc-i2s.c b/sound/soc/dwc/dwc-i2s.c
index 9160676..eebe9d3 100644
--- a/sound/soc/dwc/dwc-i2s.c
+++ b/sound/soc/dwc/dwc-i2s.c
@@ -381,7 +381,7 @@ static int dw_i2s_set_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 	return ret;
 }
 
-static struct snd_soc_dai_ops dw_i2s_dai_ops = {
+static const struct snd_soc_dai_ops dw_i2s_dai_ops = {
 	.startup	= dw_i2s_startup,
 	.shutdown	= dw_i2s_shutdown,
 	.hw_params	= dw_i2s_hw_params,
-- 
1.9.1
