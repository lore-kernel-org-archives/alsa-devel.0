From: =?UTF-8?q?Jean-Fran=C3=A7ois=20T=C3=AAtu?=
        <jean-francois.tetu@savoirfairelinux.com>
Subject: [RESEND PATCH] ASoC: codecs: msm8916-wcd-digital: fix RX2 MIX1 and RX3 MIX1
Date: Fri,  6 Oct 2017 14:09:51 -0400
Message-ID: <20171006180951.10930-1-jean-francois.tetu@savoirfairelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, =?UTF-8?q?Jean-Fran=C3=A7ois=20T=C3=AAtu?= <jean-francois.tetu@savoirfairelinux.com>
List-Id: alsa-devel@alsa-project.org

The kcontrol for the third input (rxN_mix1_inp3) of both RX2
and RX3 mixers are not using the correct control register. This simple
patch fixes this.

Signed-off-by: Jean-François Têtu <jean-francois.tetu@savoirfairelinux.com>
---
 sound/soc/codecs/msm8916-wcd-digital.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/msm8916-wcd-digital.c b/sound/soc/codecs/msm8916-wcd-digital.c
index 66df8f810f0d..a10a724eb448 100644
--- a/sound/soc/codecs/msm8916-wcd-digital.c
+++ b/sound/soc/codecs/msm8916-wcd-digital.c
@@ -238,7 +238,7 @@ static const struct soc_enum rx_mix2_inp1_chain_enum = SOC_ENUM_SINGLE(
 static const struct soc_enum rx2_mix1_inp_enum[] = {
 	SOC_ENUM_SINGLE(LPASS_CDC_CONN_RX2_B1_CTL, 0, 6, rx_mix1_text),
 	SOC_ENUM_SINGLE(LPASS_CDC_CONN_RX2_B1_CTL, 3, 6, rx_mix1_text),
-	SOC_ENUM_SINGLE(LPASS_CDC_CONN_RX2_B1_CTL, 0, 6, rx_mix1_text),
+	SOC_ENUM_SINGLE(LPASS_CDC_CONN_RX2_B2_CTL, 0, 6, rx_mix1_text),
 };
 
 /* RX2 MIX2 */
@@ -249,7 +249,7 @@ static const struct soc_enum rx2_mix2_inp1_chain_enum = SOC_ENUM_SINGLE(
 static const struct soc_enum rx3_mix1_inp_enum[] = {
 	SOC_ENUM_SINGLE(LPASS_CDC_CONN_RX3_B1_CTL, 0, 6, rx_mix1_text),
 	SOC_ENUM_SINGLE(LPASS_CDC_CONN_RX3_B1_CTL, 3, 6, rx_mix1_text),
-	SOC_ENUM_SINGLE(LPASS_CDC_CONN_RX3_B1_CTL, 0, 6, rx_mix1_text),
+	SOC_ENUM_SINGLE(LPASS_CDC_CONN_RX3_B2_CTL, 0, 6, rx_mix1_text),
 };
 
 /* DEC */
-- 
2.14.2
