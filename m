From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sh: rcar: rsrc-card: don't open code
	of_device_get_match_data()" to the asoc tree
Date: Wed, 02 Mar 2016 20:03:52 +0900
Message-ID: <E1ab4ZM-0005lM-MT@finisterre>
References: <1456850381-8621-2-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D7FB26517F
 for <alsa-devel@alsa-project.org>; Wed,  2 Mar 2016 12:04:03 +0100 (CET)
In-Reply-To: <1456850381-8621-2-git-send-email-wsa@the-dreams.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sh: rcar: rsrc-card: don't open code of_device_get_match_data()

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

>From 6a16c1765120abc8f58b2c5f275c95a33bb25572 Mon Sep 17 00:00:00 2001
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date: Tue, 1 Mar 2016 17:39:20 +0100
Subject: [PATCH] ASoC: sh: rcar: rsrc-card: don't open code
 of_device_get_match_data()

This change will also make Coverity happy by avoiding a theoretical NULL
pointer dereference; yet another reason is to use the above helper function
to tighten the code and make it more readable.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/rsrc-card.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sh/rcar/rsrc-card.c b/sound/soc/sh/rcar/rsrc-card.c
index 8a357fdf1077..545e94245e62 100644
--- a/sound/soc/sh/rcar/rsrc-card.c
+++ b/sound/soc/sh/rcar/rsrc-card.c
@@ -71,7 +71,6 @@ struct rsrc_card_priv {
 #define rsrc_priv_to_dev(priv) ((priv)->snd_card.dev)
 #define rsrc_priv_to_link(priv, i) ((priv)->snd_card.dai_link + (i))
 #define rsrc_priv_to_props(priv, i) ((priv)->dai_props + (i))
-#define rsrc_dev_to_of_data(dev) (of_match_device(rsrc_card_of_match, (dev))->data)
 
 static int rsrc_card_startup(struct snd_pcm_substream *substream)
 {
@@ -246,7 +245,7 @@ static int rsrc_card_parse_links(struct device_node *np,
 		struct device *dev = rsrc_priv_to_dev(priv);
 		const struct rsrc_card_of_data *of_data;
 
-		of_data = rsrc_dev_to_of_data(dev);
+		of_data = of_device_get_match_data(dev);
 
 		/* FE is dummy */
 		dai_link->cpu_of_node		= NULL;
@@ -396,7 +395,7 @@ static int rsrc_card_parse_of(struct device_node *node,
 			      struct rsrc_card_priv *priv,
 			      struct device *dev)
 {
-	const struct rsrc_card_of_data *of_data = rsrc_dev_to_of_data(dev);
+	const struct rsrc_card_of_data *of_data = of_device_get_match_data(dev);
 	struct rsrc_card_dai *props;
 	struct snd_soc_dai_link *links;
 	int ret;
-- 
2.7.0
