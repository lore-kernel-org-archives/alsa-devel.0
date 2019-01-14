From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] ASoC: msm8916-wcd-digital: remove few unused
	variables
Date: Mon, 14 Jan 2019 14:36:40 +0000
Message-ID: <20190114143640.28333-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67])
 by alsa0.perex.cz (Postfix) with ESMTP id B556F26680F
 for <alsa-devel@alsa-project.org>; Mon, 14 Jan 2019 15:36:46 +0100 (CET)
Received: by mail-wm1-f67.google.com with SMTP id a62so9148581wmh.4
 for <alsa-devel@alsa-project.org>; Mon, 14 Jan 2019 06:36:46 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

This patch removes unused variables which also fixes below warnings:

msm8916-wcd-digital.c:245:30: warning: 'rx2_mix2_inp1_chain_enum'
defined but not used [-Wunused-const-variable=]
static const struct soc_enum rx2_mix2_inp1_chain_enum = SOC_ENUM_SINGLE(
                              ^~~~~~~~~~~~~~~~~~~~~~~~
msm8916-wcd-digital.c:234:30: warning: 'rx_mix2_inp1_chain_enum'
defined but not used [-Wunused-const-variable=]
 static const struct soc_enum rx_mix2_inp1_chain_enum = SOC_ENUM_SINGLE(
                              ^~~~~~~~~~~~~~~~~~~~~~~
msm8916-wcd-digital.c:224:26: warning: 'adc2_mux_text'
defined but not used [-Wunused-const-variable=]
 static const char *const adc2_mux_text[] = { "ZERO", "INP2", "INP3" };
                          ^~~~~~~~~~~~~
msm8916-wcd-digital.c:223:26: warning: 'rx_mix2_text'
defined but not used [-Wunused-const-variable=]

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/msm8916-wcd-digital.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/sound/soc/codecs/msm8916-wcd-digital.c b/sound/soc/codecs/msm8916-wcd-digital.c
index 3063dedd21cf..423bfebabed4 100644
--- a/sound/soc/codecs/msm8916-wcd-digital.c
+++ b/sound/soc/codecs/msm8916-wcd-digital.c
@@ -220,8 +220,6 @@ static const char *const dec_mux_text[] = {
 };
 
 static const char *const cic_mux_text[] = { "AMIC", "DMIC" };
-static const char *const rx_mix2_text[] = { "ZERO", "IIR1", "IIR2" };
-static const char *const adc2_mux_text[] = { "ZERO", "INP2", "INP3" };
 
 /* RX1 MIX1 */
 static const struct soc_enum rx_mix1_inp_enum[] = {
@@ -230,10 +228,6 @@ static const struct soc_enum rx_mix1_inp_enum[] = {
 	SOC_ENUM_SINGLE(LPASS_CDC_CONN_RX1_B2_CTL, 0, 6, rx_mix1_text),
 };
 
-/* RX1 MIX2 */
-static const struct soc_enum rx_mix2_inp1_chain_enum = SOC_ENUM_SINGLE(
-				LPASS_CDC_CONN_RX1_B3_CTL, 0, 3, rx_mix2_text);
-
 /* RX2 MIX1 */
 static const struct soc_enum rx2_mix1_inp_enum[] = {
 	SOC_ENUM_SINGLE(LPASS_CDC_CONN_RX2_B1_CTL, 0, 6, rx_mix1_text),
@@ -241,10 +235,6 @@ static const struct soc_enum rx2_mix1_inp_enum[] = {
 	SOC_ENUM_SINGLE(LPASS_CDC_CONN_RX2_B2_CTL, 0, 6, rx_mix1_text),
 };
 
-/* RX2 MIX2 */
-static const struct soc_enum rx2_mix2_inp1_chain_enum = SOC_ENUM_SINGLE(
-				LPASS_CDC_CONN_RX2_B3_CTL, 0, 3, rx_mix2_text);
-
 /* RX3 MIX1 */
 static const struct soc_enum rx3_mix1_inp_enum[] = {
 	SOC_ENUM_SINGLE(LPASS_CDC_CONN_RX3_B1_CTL, 0, 6, rx_mix1_text),
-- 
2.20.1
