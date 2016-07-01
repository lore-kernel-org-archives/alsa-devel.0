From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs35l33: Fix testing return value of
	devm_gpiod_get_optional" to the asoc tree
Date: Fri, 01 Jul 2016 11:54:45 +0200
Message-ID: <E1bIv9p-0003nS-SK@finisterre>
References: <1467245614.7105.2.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 13B392614FD
 for <alsa-devel@alsa-project.org>; Fri,  1 Jul 2016 11:54:56 +0200 (CEST)
In-Reply-To: <1467245614.7105.2.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Brian Austin <brian.austin@cirrus.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Paul Handrigan <Paul.Handrigan@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs35l33: Fix testing return value of devm_gpiod_get_optional

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

>From 410fe39c6d2116aa5584083cbcbb7b3796e09f5d Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 30 Jun 2016 08:13:34 +0800
Subject: [PATCH] ASoC: cs35l33: Fix testing return value of
 devm_gpiod_get_optional

devm_gpiod_get_optional() returns NULL when the gpio is not assigned.
So the if (PTR_ERR(cs35l33->reset_gpio) == -ENOENT) test is always false.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Paul Handrigan <Paul.Handrigan@cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs35l33.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/soc/codecs/cs35l33.c b/sound/soc/codecs/cs35l33.c
index d8b5fc3fc45d..689c3598bf3d 100644
--- a/sound/soc/codecs/cs35l33.c
+++ b/sound/soc/codecs/cs35l33.c
@@ -1176,11 +1176,7 @@ static int cs35l33_i2c_probe(struct i2c_client *i2c_client,
 	/* We could issue !RST or skip it based on AMP topology */
 	cs35l33->reset_gpio = devm_gpiod_get_optional(&i2c_client->dev,
 			"reset-gpios", GPIOD_OUT_HIGH);
-
-	if (PTR_ERR(cs35l33->reset_gpio) == -ENOENT) {
-		dev_warn(&i2c_client->dev,
-			"%s WARNING: No reset gpio assigned\n", __func__);
-	} else if (IS_ERR(cs35l33->reset_gpio)) {
+	if (IS_ERR(cs35l33->reset_gpio)) {
 		dev_err(&i2c_client->dev, "%s ERROR: Can't get reset GPIO\n",
 			__func__);
 		return PTR_ERR(cs35l33->reset_gpio);
-- 
2.8.1
