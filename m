From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsrc-card: remove board specific
	compatible" to the asoc tree
Date: Wed, 24 Aug 2016 12:20:29 +0100
Message-ID: <E1bcWEP-00007y-17@debutante>
References: <87d1l0i8dn.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C227267331
 for <alsa-devel@alsa-project.org>; Wed, 24 Aug 2016 13:20:35 +0200 (CEST)
In-Reply-To: <87d1l0i8dn.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsrc-card: remove board specific compatible

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

>From a3235938308150fbd0f8b478e73d1e66e945937a Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 23 Aug 2016 01:33:57 +0000
Subject: [PATCH] ASoC: rsrc-card: remove board specific compatible

rsrc-card has board specific compatible (= lager/koelsh), but these were
created as 1st prototype, and it is used in my test environment only.
Now normal user can use generic compatible (= renesas,rsrc-card).
Removing these board specific compatible doesn't breake compatibility.
This patch remove these.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/renesas,rsrc-card.txt         |  7 ++-----
 sound/soc/sh/rcar/rsrc-card.c                               | 13 -------------
 2 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rsrc-card.txt b/Documentation/devicetree/bindings/sound/renesas,rsrc-card.txt
index 255ece3043ad..f148bf27723b 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rsrc-card.txt
+++ b/Documentation/devicetree/bindings/sound/renesas,rsrc-card.txt
@@ -4,11 +4,8 @@ Renesas Sampling Rate Convert Sound Card specifies audio DAI connections of SoC
 
 Required properties:
 
-- compatible				: "renesas,rsrc-card{,<board>}"
-					  Examples with boards are:
-					    - "renesas,rsrc-card"
-					    - "renesas,rsrc-card,lager"
-					    - "renesas,rsrc-card,koelsch"
+- compatible				: "renesas,rsrc-card"
+
 Optional properties:
 
 - card_name				: User specified audio sound card name, one string
diff --git a/sound/soc/sh/rcar/rsrc-card.c b/sound/soc/sh/rcar/rsrc-card.c
index 16dc13e0bec9..ce9f91143f1f 100644
--- a/sound/soc/sh/rcar/rsrc-card.c
+++ b/sound/soc/sh/rcar/rsrc-card.c
@@ -28,20 +28,7 @@ struct rsrc_card_of_data {
 	int num_routes;
 };
 
-static const struct snd_soc_dapm_route routes_ssi0_ak4642[] = {
-	{"ak4642 Playback", NULL, "DAI0 Playback"},
-	{"DAI0 Capture", NULL, "ak4642 Capture"},
-};
-
-static const struct rsrc_card_of_data routes_of_ssi0_ak4642 = {
-	.prefix		= "ak4642",
-	.routes		= routes_ssi0_ak4642,
-	.num_routes	= ARRAY_SIZE(routes_ssi0_ak4642),
-};
-
 static const struct of_device_id rsrc_card_of_match[] = {
-	{ .compatible = "renesas,rsrc-card,lager",	.data = &routes_of_ssi0_ak4642 },
-	{ .compatible = "renesas,rsrc-card,koelsch",	.data = &routes_of_ssi0_ak4642 },
 	{ .compatible = "renesas,rsrc-card", },
 	{},
 };
-- 
2.8.1
