From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tas571x: implemented digital mute" to
	the asoc tree
Date: Tue, 29 Mar 2016 10:38:39 -0700
Message-ID: <E1akxbD-00024u-8D@finisterre>
References: <1457608960-16913-3-git-send-email-petr@barix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D208D266B4B
 for <alsa-devel@alsa-project.org>; Tue, 29 Mar 2016 19:38:47 +0200 (CEST)
In-Reply-To: <1457608960-16913-3-git-send-email-petr@barix.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Petr Kulhavy <petr@barix.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tas571x: implemented digital mute

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

>From 0400485076e8bb167d5f4b3eb5f6d05e4b4361b7 Mon Sep 17 00:00:00 2001
From: Petr Kulhavy <petr@barix.com>
Date: Tue, 29 Mar 2016 09:39:36 +0200
Subject: [PATCH] ASoC: tas571x: implemented digital mute

The driver did not have a mute function. The amplifier was brought out of
shutdown mode (hard-mute) once for ever in probe(), which was causing
clicks and pops when altering the I2C register configuration later.

This adds the digital_mute() function. The amplifier unmute in probe()
was removed.

Signed-off-by: Petr Kulhavy <petr@barix.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tas571x.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/tas571x.c b/sound/soc/codecs/tas571x.c
index 39307ad41a34..d003c6ce0794 100644
--- a/sound/soc/codecs/tas571x.c
+++ b/sound/soc/codecs/tas571x.c
@@ -167,6 +167,23 @@ static int tas571x_hw_params(struct snd_pcm_substream *substream,
 				  TAS571X_SDI_FMT_MASK, val);
 }
 
+static int tas571x_mute(struct snd_soc_dai *dai, int mute)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	u8 sysctl2;
+	int ret;
+
+	sysctl2 = mute ? TAS571X_SYS_CTRL_2_SDN_MASK : 0;
+
+	ret = snd_soc_update_bits(codec,
+			    TAS571X_SYS_CTRL_2_REG,
+		     TAS571X_SYS_CTRL_2_SDN_MASK,
+		     sysctl2);
+	usleep_range(1000, 2000);
+
+	return ret;
+}
+
 static int tas571x_set_bias_level(struct snd_soc_codec *codec,
 				  enum snd_soc_bias_level level)
 {
@@ -214,6 +231,7 @@ static int tas571x_set_bias_level(struct snd_soc_codec *codec,
 static const struct snd_soc_dai_ops tas571x_dai_ops = {
 	.set_fmt	= tas571x_set_dai_fmt,
 	.hw_params	= tas571x_hw_params,
+	.digital_mute	= tas571x_mute,
 };
 
 static const char *const tas5711_supply_names[] = {
@@ -445,10 +463,6 @@ static int tas571x_i2c_probe(struct i2c_client *client,
 	if (ret)
 		return ret;
 
-	ret = regmap_update_bits(priv->regmap, TAS571X_SYS_CTRL_2_REG,
-				 TAS571X_SYS_CTRL_2_SDN_MASK, 0);
-	if (ret)
-		return ret;
 
 	memcpy(&priv->codec_driver, &tas571x_codec, sizeof(priv->codec_driver));
 	priv->codec_driver.controls = priv->chip->controls;
-- 
2.8.0.rc3
