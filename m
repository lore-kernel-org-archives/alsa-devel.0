From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs4349: Constify cs4349_regmap" to the
	asoc tree
Date: Mon, 20 Jul 2015 18:52:27 +0100
Message-ID: <E1ZHFEp-0002wl-5Y@debutante>
References: <1437147782.1229.4.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 540BE261583
 for <alsa-devel@alsa-project.org>; Mon, 20 Jul 2015 19:52:35 +0200 (CEST)
In-Reply-To: <1437147782.1229.4.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Tim Howe <tim.howe@cirrus.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs4349: Constify cs4349_regmap

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

>From b08b338253e917be45ee19924b58dd0b1265473f Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Fri, 17 Jul 2015 23:43:02 +0800
Subject: [PATCH] ASoC: cs4349: Constify cs4349_regmap

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Tim Howe <tim.howe@cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs4349.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs4349.c b/sound/soc/codecs/cs4349.c
index 9273b06e918b..f4fccc621ceb 100644
--- a/sound/soc/codecs/cs4349.c
+++ b/sound/soc/codecs/cs4349.c
@@ -264,7 +264,7 @@ static struct snd_soc_codec_driver soc_codec_dev_cs4349 = {
 	.num_dapm_routes	= ARRAY_SIZE(cs4349_routes),
 };
 
-static struct regmap_config cs4349_regmap = {
+static const struct regmap_config cs4349_regmap = {
 	.reg_bits		= 8,
 	.val_bits		= 8,
 
-- 
2.1.4
