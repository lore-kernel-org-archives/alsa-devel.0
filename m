From: =?UTF-8?q?Jean-Fran=C3=A7ois=20T=C3=AAtu?=
        <jean-francois.tetu@savoirfairelinux.com>
Subject: [PATCH RESEND] ASoC: codecs: msm8916-wcd-digital: fix RX2 MIX1 and RX3 MIX1
Date: Fri, 22 Sep 2017 18:18:02 -0400
Message-ID: <1506118682-6746-1-git-send-email-jean-francois.tetu@savoirfairelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, =?UTF-8?q?Jean-Fran=C3=A7ois=20T=C3=AAtu?= <jean-francois.tetu@savoirfairelinux.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 22, 2017 at 17:45:25 -0400, Jean-François Têtu wrote:
>The kcontrol for the third input (rxN_mix1_inp3) of both RX2
>and RX3 mixers are not using the correct control register. This simple
>patch fixes this.
>
>Signed-off-by: Jean-François Têtu <jean-francois.tetu@savoirfairelinux.com>

I'm sorry, I did not send this to the actual alsa-devel ML. This
time I did.

Jean-François Têtu
---
 sound/soc/codecs/msm8916-wcd-digital.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/msm8916-wcd-digital.c b/sound/soc/codecs/msm8916-wcd-digital.c
index 66df8f8..a10a724 100644
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
2.7.4
