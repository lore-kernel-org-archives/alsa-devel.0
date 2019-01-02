From: b-ak <anur.bhargav@gmail.com>
Subject: [PATCH] ASoC: tlv320aic32x4: Kernel OOPS while entering DAPM standby
 mode
Date: Wed, 2 Jan 2019 22:36:33 +0530
Message-ID: <20190102170633.GA9724@Ideapad-330S>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

During the bootup of the kernel, as soon as the DAPM framework kicks in
it pushes the codec into standy mode.

The existing TVL320AIC32x4 codec driver doesn't prepare the clock in
the probe function.
This leads to an OOPS when the DAPM tries to put it into standy by calling
clk_disable_unprepare()

This patch fixes that problem.

Signed-off-by: b-ak <anur.bhargav@gmail.com>
---
 sound/soc/codecs/tlv320aic32x4.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index e2b5a11b16d1..7cf363595abd 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -1167,6 +1167,12 @@ int aic32x4_probe(struct device *dev, struct regmap *regmap)
 	if (IS_ERR(aic32x4->mclk)) {
 		dev_err(dev, "Failed getting the mclk. The current implementation does not support the usage of this codec without mclk\n");
 		return PTR_ERR(aic32x4->mclk);
+	} else {
+		ret = clk_prepare_enable(aic32x4->mclk);
+		if (ret != 0) {
+			dev_err(dev, "Failed to enable MCLK: %d\n", ret);
+			return ret;
+		}
 	}
 
 	if (gpio_is_valid(aic32x4->rstn_gpio)) {
-- 
2.19.1
