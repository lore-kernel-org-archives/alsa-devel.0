From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sun4i-codec: Remove the routing
	property" to the asoc tree
Date: Wed, 07 Oct 2015 12:18:47 +0100
Message-ID: <E1ZjmkB-0006RW-1X@finisterre>
References: <1444215598-13543-1-git-send-email-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 60B0B266198
 for <alsa-devel@alsa-project.org>; Wed,  7 Oct 2015 13:19:24 +0200 (CEST)
In-Reply-To: <1444215598-13543-1-git-send-email-maxime.ripard@free-electrons.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Priit Laes <plaes@plaes.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sun4i-codec: Remove the routing property

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

>From c570b82c5e6ac78be35b4e72594c0f1b1888fce1 Mon Sep 17 00:00:00 2001
From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Wed, 7 Oct 2015 11:59:58 +0100
Subject: [PATCH] ASoC: sun4i-codec: Remove the routing property

Most of the boards have their headphone jack directly connected to the
matching pins of the SoCs. Since most of the time we will have the same
routing path, it makes no sense to put that in the DTS, since it will only
be some useless duplication there.

It also fixes the following warning messages that were seen so far, on
boards where we were using the bindings in the documentation example.

sun4i-codec 1c22c00.codec: ASoC: no sink widget found for Headphone Jack
sun4i-codec 1c22c00.codec: ASoC: Failed to add route HP Left -> direct -> Headphone Jack
sun4i-codec 1c22c00.codec: ASoC: no sink widget found for Headphone Jack
sun4i-codec 1c22c00.codec: ASoC: Failed to add route HP Right -> direct -> Headphone Jack

Reported-by: Priit Laes <plaes@plaes.org>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/sun4i-codec.txt | 6 ------
 sound/soc/sunxi/sun4i-codec.c                           | 7 -------
 2 files changed, 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/sun4i-codec.txt b/Documentation/devicetree/bindings/sound/sun4i-codec.txt
index 680144b..c92966b 100644
--- a/Documentation/devicetree/bindings/sound/sun4i-codec.txt
+++ b/Documentation/devicetree/bindings/sound/sun4i-codec.txt
@@ -13,10 +13,6 @@ Required properties:
 - clock-names: should contain followings:
    - "apb": the parent APB clock for this controller
    - "codec": the parent module clock
-- routing : A list of the connections between audio components.  Each
-  entry is a pair of strings, the first being the connection's sink,
-  the second being the connection's source.
-
 
 Example:
 codec: codec@01c22c00 {
@@ -28,6 +24,4 @@ codec: codec@01c22c00 {
 	clock-names = "apb", "codec";
 	dmas = <&dma 0 19>, <&dma 0 19>;
 	dma-names = "rx", "tx";
-	routing = "Headphone Jack", "HP Right",
-		  "Headphone Jack", "HP Left";
 };
diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 4778055..bcbf4da 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -571,7 +571,6 @@ static struct snd_soc_dai_link *sun4i_codec_create_link(struct device *dev,
 static struct snd_soc_card *sun4i_codec_create_card(struct device *dev)
 {
 	struct snd_soc_card *card;
-	int ret;
 
 	card = devm_kzalloc(dev, sizeof(*card), GFP_KERNEL);
 	if (!card)
@@ -584,12 +583,6 @@ static struct snd_soc_card *sun4i_codec_create_card(struct device *dev)
 	card->dev		= dev;
 	card->name		= "sun4i-codec";
 
-	ret = snd_soc_of_parse_audio_routing(card, "routing");
-	if (ret) {
-		dev_err(dev, "Failed to create our audio routing\n");
-		return NULL;
-	}
-
 	return card;
 };
 
-- 
2.5.0
