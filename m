From: Dmitry Lavnikevich <d.lavnikevich@sam-solutions.com>
Subject: [PATCH 5/5] ASoC: tlv320aic3x: fix PLL D configuration
Date: Wed, 10 Sep 2014 16:46:49 +0300
Message-ID: <1410356809-26179-6-git-send-email-d.lavnikevich@sam-solutions.com>
References: <1410356809-26179-1-git-send-email-d.lavnikevich@sam-solutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1410356809-26179-1-git-send-email-d.lavnikevich@sam-solutions.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, shawn.guo@freescale.com, kernel@pengutronix.de, linux@arm.linux.org.uk, perex@perex.cz, tiwai@suse.de, timur@tabi.org, nicoleotsuka@gmail.com, Li.Xiubo@freescale.com, grant.likely@linaro.org
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Dmitry Lavnikevich <d.lavnikevich@sam-solutions.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Current caching implementation during regcache_sync() call bypasses
all register writes of values that are already known as default
(regmap reg_defaults). Same time in TLV320AIC3x codecs register 5
(AIC3X_PLL_PROGC_REG) write should be immediately followed by register
6 write (AIC3X_PLL_PROGD_REG) even if it was not changed. Otherwise
both registers will not be written.

This brings to issue that appears particulary in case of 44.1kHz
playback with 19.2MHz master clock. In this case AIC3X_PLL_PROGC_REG
is 0x6e while AIC3X_PLL_PROGD_REG is 0x0 (same as register
default). Thus AIC3X_PLL_PROGC_REG also remains not written and we get
wrong playback speed.

In this patch snd_soc_read() is used to get cached pll values and
snd_soc_write() (unlike regcache_sync() this function doesn't bypasses
hardware default values) to write them to registers.

Signed-off-by: Dmitry Lavnikevich <d.lavnikevich@sam-solutions.com>
---
 sound/soc/codecs/tlv320aic3x.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 64f179ee9834..5e8626ae612b 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -1121,6 +1121,7 @@ static int aic3x_regulator_event(struct notifier_block *nb,
 static int aic3x_set_power(struct snd_soc_codec *codec, int power)
 {
 	struct aic3x_priv *aic3x = snd_soc_codec_get_drvdata(codec);
+	unsigned int pll_c, pll_d;
 	int ret;
 
 	if (power) {
@@ -1138,6 +1139,18 @@ static int aic3x_set_power(struct snd_soc_codec *codec, int power)
 		/* Sync reg_cache with the hardware */
 		regcache_cache_only(aic3x->regmap, false);
 		regcache_sync(aic3x->regmap);
+
+		/* Rewrite paired PLL D registers in case cached sync skipped
+		 * writing one of them and thus caused other one also not
+		 * being written
+		 */
+		pll_c = snd_soc_read(codec, AIC3X_PLL_PROGC_REG);
+		pll_d = snd_soc_read(codec, AIC3X_PLL_PROGD_REG);
+		if (pll_c == aic3x_reg[AIC3X_PLL_PROGC_REG].def ||
+			pll_d == aic3x_reg[AIC3X_PLL_PROGD_REG].def) {
+			snd_soc_write(codec, AIC3X_PLL_PROGC_REG, pll_c);
+			snd_soc_write(codec, AIC3X_PLL_PROGD_REG, pll_d);
+		}
 	} else {
 		/*
 		 * Do soft reset to this codec instance in order to clear
-- 
2.1.0
