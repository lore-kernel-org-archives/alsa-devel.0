From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: mediatek: Remove AIF widgets for
	backend DAIs" to the asoc tree
Date: Mon, 17 Aug 2015 13:06:56 -0700
Message-ID: <E1ZRQgK-0006En-Lb@finisterre>
References: <1439810211-45518-1-git-send-email-koro.chen@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from p2012.superclick.com (unknown [216.4.250.2])
 by alsa0.perex.cz (Postfix) with ESMTP id DD9D926042F
 for <alsa-devel@alsa-project.org>; Mon, 17 Aug 2015 22:06:58 +0200 (CEST)
In-Reply-To: <1439810211-45518-1-git-send-email-koro.chen@mediatek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Koro Chen <koro.chen@mediatek.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: mediatek: Remove AIF widgets for backend DAIs

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 0643558f85e740019e0632072c55e8b2f79a8d7d Mon Sep 17 00:00:00 2001
From: Koro Chen <koro.chen@mediatek.com>
Date: Mon, 17 Aug 2015 19:16:51 +0800
Subject: [PATCH] ASoC: mediatek: Remove AIF widgets for backend DAIs

DAPM core already creates widgets for DAIs. It is not necessary
to declare them by SND_SOC_DAPM_AIF_IN/SND_SOC_DAPM_AIF_OUT.
Furthermore, original codes use backend DAI's stream name to be the AIF
widget name. It causes the same widget to be created twice, and after
commit 92fa12426741 ("ASoC: dapm: Add new widgets to the end of the
widget list") the first created widget (by snd_soc_dapm_new_controls)
is used, not the 2nd created one (by snd_soc_dapm_new_dai_widgets),
so audio path is broken.

Signed-off-by: Koro Chen <koro.chen@mediatek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/mtk-afe-pcm.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/sound/soc/mediatek/mtk-afe-pcm.c b/sound/soc/mediatek/mtk-afe-pcm.c
index cc228db..e3e6331 100644
--- a/sound/soc/mediatek/mtk-afe-pcm.c
+++ b/sound/soc/mediatek/mtk-afe-pcm.c
@@ -820,10 +820,6 @@ static const struct snd_kcontrol_new mtk_afe_o10_mix[] = {
 };
 
 static const struct snd_soc_dapm_widget mtk_afe_pcm_widgets[] = {
-	/* Backend DAIs  */
-	SND_SOC_DAPM_AIF_IN("I2S Capture", NULL, 0, SND_SOC_NOPM, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("I2S Playback", NULL, 0, SND_SOC_NOPM, 0, 0),
-
 	/* inter-connections */
 	SND_SOC_DAPM_MIXER("I05", SND_SOC_NOPM, 0, 0, NULL, 0),
 	SND_SOC_DAPM_MIXER("I06", SND_SOC_NOPM, 0, 0, NULL, 0),
@@ -855,11 +851,6 @@ static const struct snd_soc_dapm_route mtk_afe_pcm_routes[] = {
 	{ "O10", "I18 Switch", "I18" },
 };
 
-static const struct snd_soc_dapm_widget mtk_afe_hdmi_widgets[] = {
-	/* Backend DAIs  */
-	SND_SOC_DAPM_AIF_OUT("HDMIO Playback", NULL, 0, SND_SOC_NOPM, 0, 0),
-};
-
 static const struct snd_soc_dapm_route mtk_afe_hdmi_routes[] = {
 	{"HDMIO Playback", NULL, "HDMI"},
 };
@@ -874,8 +865,6 @@ static const struct snd_soc_component_driver mtk_afe_pcm_dai_component = {
 
 static const struct snd_soc_component_driver mtk_afe_hdmi_dai_component = {
 	.name = "mtk-afe-hdmi-dai",
-	.dapm_widgets = mtk_afe_hdmi_widgets,
-	.num_dapm_widgets = ARRAY_SIZE(mtk_afe_hdmi_widgets),
 	.dapm_routes = mtk_afe_hdmi_routes,
 	.num_dapm_routes = ARRAY_SIZE(mtk_afe_hdmi_routes),
 };
-- 
2.5.0
