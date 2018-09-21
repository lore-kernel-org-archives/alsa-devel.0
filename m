From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tidyup for_each_card_prelinks()
	dai_link" to the asoc tree
Date: Fri, 21 Sep 2018 17:24:09 +0100 (BST)
Message-ID: <20180921162409.863CB440078@finisterre.ee.mobilebroadband>
References: <87a7ob2tbf.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D50C7267891
 for <alsa-devel@alsa-project.org>; Fri, 21 Sep 2018 18:24:12 +0200 (CEST)
In-Reply-To: <87a7ob2tbf.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tidyup for_each_card_prelinks() dai_link

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

>From 0310820c2738e92003d9dd8cabee77ff958a16dc Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 21 Sep 2018 07:46:28 +0000
Subject: [PATCH] ASoC: tidyup for_each_card_prelinks() dai_link

commit 7fe072b4df5d0 ("ASoC: add for_each_card_prelinks() macro")
added new for_each_card_prelinks() macro, but it had typo.
This patch fixup it

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/mt2701/mt2701-cs42448.c | 8 ++++----
 sound/soc/mediatek/mt2701/mt2701-wm8960.c  | 8 ++++----
 sound/soc/mediatek/mt6797/mt6797-mt6351.c  | 6 +++---
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/sound/soc/mediatek/mt2701/mt2701-cs42448.c b/sound/soc/mediatek/mt2701/mt2701-cs42448.c
index 875f84691535..97f9f38ce6b3 100644
--- a/sound/soc/mediatek/mt2701/mt2701-cs42448.c
+++ b/sound/soc/mediatek/mt2701/mt2701-cs42448.c
@@ -311,9 +311,9 @@ static int mt2701_cs42448_machine_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 	for_each_card_prelinks(card, i, dai_link) {
-		if (dai_links->platform_name)
+		if (dai_link->platform_name)
 			continue;
-		dai_links->platform_of_node = platform_node;
+		dai_link->platform_of_node = platform_node;
 	}
 
 	card->dev = dev;
@@ -326,9 +326,9 @@ static int mt2701_cs42448_machine_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 	for_each_card_prelinks(card, i, dai_link) {
-		if (dai_links->codec_name)
+		if (dai_link->codec_name)
 			continue;
-		dai_links->codec_of_node = codec_node;
+		dai_link->codec_of_node = codec_node;
 	}
 
 	codec_node_bt_mrg = of_parse_phandle(pdev->dev.of_node,
diff --git a/sound/soc/mediatek/mt2701/mt2701-wm8960.c b/sound/soc/mediatek/mt2701/mt2701-wm8960.c
index c67f62935e53..6bc1d3d58e64 100644
--- a/sound/soc/mediatek/mt2701/mt2701-wm8960.c
+++ b/sound/soc/mediatek/mt2701/mt2701-wm8960.c
@@ -107,9 +107,9 @@ static int mt2701_wm8960_machine_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 	for_each_card_prelinks(card, i, dai_link) {
-		if (dai_links->platform_name)
+		if (dai_link->platform_name)
 			continue;
-		dai_links->platform_of_node = platform_node;
+		dai_link->platform_of_node = platform_node;
 	}
 
 	card->dev = &pdev->dev;
@@ -122,9 +122,9 @@ static int mt2701_wm8960_machine_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 	for_each_card_prelinks(card, i, dai_link) {
-		if (dai_links->codec_name)
+		if (dai_link->codec_name)
 			continue;
-		dai_links->codec_of_node = codec_node;
+		dai_link->codec_of_node = codec_node;
 	}
 
 	ret = snd_soc_of_parse_audio_routing(card, "audio-routing");
diff --git a/sound/soc/mediatek/mt6797/mt6797-mt6351.c b/sound/soc/mediatek/mt6797/mt6797-mt6351.c
index ff2e0ca4384e..cc41eb531653 100644
--- a/sound/soc/mediatek/mt6797/mt6797-mt6351.c
+++ b/sound/soc/mediatek/mt6797/mt6797-mt6351.c
@@ -172,7 +172,7 @@ static int mt6797_mt6351_dev_probe(struct platform_device *pdev)
 	for_each_card_prelinks(card, i, dai_link) {
 		if (dai_link->platform_name)
 			continue;
-		dai_links->platform_of_node = platform_node;
+		dai_link->platform_of_node = platform_node;
 	}
 
 	codec_node = of_parse_phandle(pdev->dev.of_node,
@@ -183,9 +183,9 @@ static int mt6797_mt6351_dev_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 	for_each_card_prelinks(card, i, dai_link) {
-		if (dai_links->codec_name)
+		if (dai_link->codec_name)
 			continue;
-		dai_links->codec_of_node = codec_node;
+		dai_link->codec_of_node = codec_node;
 	}
 
 	ret = devm_snd_soc_register_card(&pdev->dev, card);
-- 
2.19.0
