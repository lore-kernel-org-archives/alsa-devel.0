From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: msm8916-wcd-digital: remove few unused
	variables" to the asoc tree
Date: Mon, 14 Jan 2019 23:03:58 +0000 (GMT)
Message-ID: <20190114230358.86DE41127AD1@debutante.sirena.org.uk>
References: <20190114143640.28333-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B3026267333
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2019 00:03:59 +0100 (CET)
In-Reply-To: <20190114143640.28333-1-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: msm8916-wcd-digital: remove few unused variables

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From fecd5c09ddf8711c0b17087cc7a40ac57680f8ed Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Mon, 14 Jan 2019 14:36:40 +0000
Subject: [PATCH] ASoC: msm8916-wcd-digital: remove few unused variables

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
Signed-off-by: Mark Brown <broonie@kernel.org>
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
