From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: mediatek: mt8183: remove unused
	DAPM-related variables" to the asoc tree
Date: Tue, 27 Aug 2019 20:58:10 +0100 (BST)
Message-ID: <20190827195810.7DE44D02CEB@fitzroy.sirena.org.uk>
References: <20190826032642.27324-1-tzungbi@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F0B3EF80678
 for <alsa-devel@alsa-project.org>; Tue, 27 Aug 2019 21:58:13 +0200 (CEST)
In-Reply-To: <20190826032642.27324-1-tzungbi@google.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
Cc: alsa-devel@alsa-project.org, cychiang@google.com, jiaxin.yu@mediatek.com, tzungbi@google.com, Mark Brown <broonie@kernel.org>, dgreid@google.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: mediatek: mt8183: remove unused DAPM-related variables

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

>From 3cdc3c9fd9fa92bcef777512d9f4eef854f9a4ed Mon Sep 17 00:00:00 2001
From: Tzung-Bi Shih <tzungbi@google.com>
Date: Mon, 26 Aug 2019 11:26:42 +0800
Subject: [PATCH] ASoC: mediatek: mt8183: remove unused DAPM-related variables

Remove unused variable mt8183_mt6358_ts3a227_max98357_dapm_widgets and
mt8183_mt6358_ts3a227_max98357_dapm_routes.  They are accidentially
included when rebasing commits.

Fixes: 6191cbde5ff0 ("ASoC: mediatek: mt8183: switch tdm pins gpio function when playback on or off")
Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
Link: https://lore.kernel.org/r/20190826032642.27324-1-tzungbi@google.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c   | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c b/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
index fe8a7461ace5..951706fa75fc 100644
--- a/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
+++ b/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
@@ -46,16 +46,6 @@ static int mt8183_i2s_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 	return 0;
 }
 
-static const struct snd_soc_dapm_widget
-mt8183_mt6358_ts3a227_max98357_dapm_widgets[] = {
-	SND_SOC_DAPM_OUTPUT("IT6505_8CH"),
-};
-
-static const struct snd_soc_dapm_route
-mt8183_mt6358_ts3a227_max98357_dapm_routes[] = {
-	{"IT6505_8CH", NULL, "TDM"},
-};
-
 enum PINCTRL_PIN_STATE {
 	PIN_STATE_DEFAULT = 0,
 	PIN_TDM_OUT_ON,
-- 
2.20.1
