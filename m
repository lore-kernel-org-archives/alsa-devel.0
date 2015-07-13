From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/2] ASoC: sti-sas: Staticise local symbols
Date: Mon, 13 Jul 2015 13:26:45 +0800
Message-ID: <1436765205.21490.2.camel@ingics.com>
References: <1436765134.21490.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f182.google.com (mail-pd0-f182.google.com
 [209.85.192.182])
 by alsa0.perex.cz (Postfix) with ESMTP id A1FD0261492
 for <alsa-devel@alsa-project.org>; Mon, 13 Jul 2015 07:26:56 +0200 (CEST)
Received: by pdbqm3 with SMTP id qm3so73874296pdb.0
 for <alsa-devel@alsa-project.org>; Sun, 12 Jul 2015 22:26:52 -0700 (PDT)
In-Reply-To: <1436765134.21490.1.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/sti-sas.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/sti-sas.c b/sound/soc/codecs/sti-sas.c
index 4168b88..6c0bbe8 100644
--- a/sound/soc/codecs/sti-sas.c
+++ b/sound/soc/codecs/sti-sas.c
@@ -238,7 +238,7 @@ static int stih416_dac_probe(struct snd_soc_dai *dai)
 	return 0;
 }
 
-const struct snd_soc_dapm_widget stih416_sas_dapm_widgets[] = {
+static const struct snd_soc_dapm_widget stih416_sas_dapm_widgets[] = {
 	SND_SOC_DAPM_PGA("DAC bandgap", STIH416_AUDIO_DAC_CTRL,
 			 STIH416_DAC_NOT_PNDBG_MASK, 0, NULL, 0),
 	SND_SOC_DAPM_OUT_DRV("DAC standby ana", STIH416_AUDIO_DAC_CTRL,
@@ -248,7 +248,7 @@ const struct snd_soc_dapm_widget stih416_sas_dapm_widgets[] = {
 	SND_SOC_DAPM_OUTPUT("DAC Output"),
 };
 
-const struct snd_soc_dapm_widget stih407_sas_dapm_widgets[] = {
+static const struct snd_soc_dapm_widget stih407_sas_dapm_widgets[] = {
 	SND_SOC_DAPM_OUT_DRV("DAC standby ana", STIH407_AUDIO_DAC_CTRL,
 			     STIH407_DAC_STANDBY_ANA, 1, NULL, 0),
 	SND_SOC_DAPM_DAC("DAC standby",  "dac_p", STIH407_AUDIO_DAC_CTRL,
@@ -256,13 +256,13 @@ const struct snd_soc_dapm_widget stih407_sas_dapm_widgets[] = {
 	SND_SOC_DAPM_OUTPUT("DAC Output"),
 };
 
-const struct snd_soc_dapm_route stih416_sas_route[] = {
+static const struct snd_soc_dapm_route stih416_sas_route[] = {
 	{"DAC Output", NULL, "DAC bandgap"},
 	{"DAC Output", NULL, "DAC standby ana"},
 	{"DAC standby ana", NULL, "DAC standby"},
 };
 
-const struct snd_soc_dapm_route stih407_sas_route[] = {
+static const struct snd_soc_dapm_route stih407_sas_route[] = {
 	{"DAC Output", NULL, "DAC standby ana"},
 	{"DAC standby ana", NULL, "DAC standby"},
 };
@@ -407,21 +407,21 @@ static int sti_sas_prepare(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-const struct snd_soc_dai_ops stih416_dac_ops = {
+static const struct snd_soc_dai_ops stih416_dac_ops = {
 	.set_fmt = sti_sas_dac_set_fmt,
 	.mute_stream = stih416_sas_dac_mute,
 	.prepare = sti_sas_prepare,
 	.set_sysclk = sti_sas_set_sysclk,
 };
 
-const struct snd_soc_dai_ops stih407_dac_ops = {
+static const struct snd_soc_dai_ops stih407_dac_ops = {
 	.set_fmt = sti_sas_dac_set_fmt,
 	.mute_stream = stih407_sas_dac_mute,
 	.prepare = sti_sas_prepare,
 	.set_sysclk = sti_sas_set_sysclk,
 };
 
-const struct regmap_config stih407_sas_regmap = {
+static const struct regmap_config stih407_sas_regmap = {
 	.reg_bits = 32,
 	.val_bits = 32,
 
@@ -434,7 +434,7 @@ const struct regmap_config stih407_sas_regmap = {
 	.reg_write = sti_sas_write_reg,
 };
 
-const struct regmap_config stih416_sas_regmap = {
+static const struct regmap_config stih416_sas_regmap = {
 	.reg_bits = 32,
 	.val_bits = 32,
 
@@ -447,7 +447,7 @@ const struct regmap_config stih416_sas_regmap = {
 	.reg_write = sti_sas_write_reg,
 };
 
-const struct sti_sas_dev_data stih416_data = {
+static const struct sti_sas_dev_data stih416_data = {
 	.chipid = CHIPID_STIH416,
 	.regmap = &stih416_sas_regmap,
 	.dac_ops = &stih416_dac_ops,
@@ -457,7 +457,7 @@ const struct sti_sas_dev_data stih416_data = {
 	.num_dapm_routes = ARRAY_SIZE(stih416_sas_route),
 };
 
-const struct sti_sas_dev_data stih407_data = {
+static const struct sti_sas_dev_data stih407_data = {
 	.chipid = CHIPID_STIH407,
 	.regmap = &stih407_sas_regmap,
 	.dac_ops = &stih407_dac_ops,
-- 
2.1.0
