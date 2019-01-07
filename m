From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5645: remove unused mux define" to
	the asoc tree
Date: Mon,  7 Jan 2019 18:58:26 +0000 (GMT)
Message-ID: <20190107185826.3FE911127491@debutante.sirena.org.uk>
References: <20190105020249.8639-6-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 35F4626742B
 for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2019 19:58:27 +0100 (CET)
In-Reply-To: <20190105020249.8639-6-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard liao <yung-chuan.liao@linux.intel.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, tiwai@suse.de, Takashi Iwai <tiwai@suse.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, open list <linux-kernel@vger.kernel.org>, liam.r.girdwood@linux.intel.com, broonie@kernel.org, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5645: remove unused mux define

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

>From c3db21324442137552041711a878d75358c993ae Mon Sep 17 00:00:00 2001
From: Bard liao <yung-chuan.liao@linux.intel.com>
Date: Fri, 4 Jan 2019 20:02:33 -0600
Subject: [PATCH] ASoC: rt5645: remove unused mux define

rt5645_if3_adc_in_mux, rt5645_inr_mux, and rt5645_inl_mux are not used.
Remove them from the driver.

Signed-off-by: Bard liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5645.c | 36 ------------------------------------
 1 file changed, 36 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index be674688dc40..52ce380c8f3a 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -1288,30 +1288,6 @@ static SOC_ENUM_SINGLE_DECL(
 static const struct snd_kcontrol_new rt5645_dac_r2_mux =
 	SOC_DAPM_ENUM("DAC2 R source", rt5645_dac2r_enum);
 
-
-/* INL/R source */
-static const char * const rt5645_inl_src[] = {
-	"IN2P", "MonoP"
-};
-
-static SOC_ENUM_SINGLE_DECL(
-	rt5645_inl_enum, RT5645_INL1_INR1_VOL,
-	RT5645_INL_SEL_SFT, rt5645_inl_src);
-
-static const struct snd_kcontrol_new rt5645_inl_mux =
-	SOC_DAPM_ENUM("INL source", rt5645_inl_enum);
-
-static const char * const rt5645_inr_src[] = {
-	"IN2N", "MonoN"
-};
-
-static SOC_ENUM_SINGLE_DECL(
-	rt5645_inr_enum, RT5645_INL1_INR1_VOL,
-	RT5645_INR_SEL_SFT, rt5645_inr_src);
-
-static const struct snd_kcontrol_new rt5645_inr_mux =
-	SOC_DAPM_ENUM("INR source", rt5645_inr_enum);
-
 /* Stereo1 ADC source */
 /* MX-27 [12] */
 static const char * const rt5645_stereo_adc1_src[] = {
@@ -1611,18 +1587,6 @@ static SOC_ENUM_SINGLE_DECL(
 static const struct snd_kcontrol_new rt5645_if2_adc_in_mux =
 	SOC_DAPM_ENUM("IF2 ADC IN source", rt5645_if2_adc_in_enum);
 
-/* MX-2F [1:0] */
-static const char * const rt5645_if3_adc_in_src[] = {
-	"IF_ADC1", "IF_ADC2", "VAD_ADC"
-};
-
-static SOC_ENUM_SINGLE_DECL(
-	rt5645_if3_adc_in_enum, RT5645_DIG_INF1_DATA,
-	RT5645_IF3_ADC_IN_SFT, rt5645_if3_adc_in_src);
-
-static const struct snd_kcontrol_new rt5645_if3_adc_in_mux =
-	SOC_DAPM_ENUM("IF3 ADC IN source", rt5645_if3_adc_in_enum);
-
 /* MX-31 [15] [13] [11] [9] */
 static const char * const rt5645_pdm_src[] = {
 	"Mono DAC", "Stereo DAC"
-- 
2.20.1
