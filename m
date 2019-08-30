From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: mediatek: mt8183: remove forward
	declaration of headset_init" to the asoc tree
Date: Fri, 30 Aug 2019 17:06:08 +0100 (BST)
Message-ID: <20190830160608.3DFB32742CC6@ypsilon.sirena.org.uk>
References: <20190830074240.195166-4-tzungbi@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C7EFAF80362
 for <alsa-devel@alsa-project.org>; Fri, 30 Aug 2019 18:06:09 +0200 (CEST)
In-Reply-To: <20190830074240.195166-4-tzungbi@google.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
Cc: tzungbi@google.com, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, dgreid@google.com, cychiang@google.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: mediatek: mt8183: remove forward declaration of headset_init

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

>From fc347483b87f029c1bc18a8492623ca21dcd7607 Mon Sep 17 00:00:00 2001
From: Tzung-Bi Shih <tzungbi@google.com>
Date: Fri, 30 Aug 2019 15:42:39 +0800
Subject: [PATCH] ASoC: mediatek: mt8183: remove forward declaration of
 headset_init

The forward declaration of mt8183_mt6358_ts3a227_max98357_headset_init
is for cyclic dependency between card, headset_dev, and headset_init.

It used to be:
- card depends on headset_dev
- headset_dev depends on headset_init
- headset_init depends on card

Commit a962a809e5e4 ("ASoC: mediatek: mt8183: make headset codec
optional") removed the cyclic dependency.

Thus, it is safe to remove the forward declaration.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
Link: https://lore.kernel.org/r/20190830074240.195166-4-tzungbi@google.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../mt8183/mt8183-mt6358-ts3a227-max98357.c         | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c b/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
index a7ad41b6e885..30a7735c4af3 100644
--- a/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
+++ b/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
@@ -390,14 +390,6 @@ mt8183_mt6358_ts3a227_max98357_dai_links[] = {
 	},
 };
 
-static int
-mt8183_mt6358_ts3a227_max98357_headset_init(struct snd_soc_component *cpnt);
-
-static struct snd_soc_aux_dev mt8183_mt6358_ts3a227_max98357_headset_dev = {
-	.dlc = COMP_EMPTY(),
-	.init = mt8183_mt6358_ts3a227_max98357_headset_init,
-};
-
 static struct snd_soc_card mt8183_mt6358_ts3a227_max98357_card = {
 	.name = "mt8183_mt6358_ts3a227_max98357",
 	.owner = THIS_MODULE,
@@ -428,6 +420,11 @@ mt8183_mt6358_ts3a227_max98357_headset_init(struct snd_soc_component *component)
 	return ret;
 }
 
+static struct snd_soc_aux_dev mt8183_mt6358_ts3a227_max98357_headset_dev = {
+	.dlc = COMP_EMPTY(),
+	.init = mt8183_mt6358_ts3a227_max98357_headset_init,
+};
+
 static int
 mt8183_mt6358_ts3a227_max98357_dev_probe(struct platform_device *pdev)
 {
-- 
2.20.1
