From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pcm3060: Add soft reset on probe" to the asoc tree
Date: Tue, 12 Feb 2019 14:22:04 +0000 (GMT)
Message-ID: <20190212142204.7A93A1128113@debutante.sirena.org.uk>
References: <20190211060839.21417-1-kmarinushkin@birdec.tech>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190211060839.21417-1-kmarinushkin@birdec.tech>
Sender: linux-kernel-owner@vger.kernel.org
To: Kirill Marinushkin <kmarinushkin@birdec.tech>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: pcm3060: Add soft reset on probe

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

>From a3daee085905e97ba20e6b9e72e6639fa518209c Mon Sep 17 00:00:00 2001
From: Kirill Marinushkin <kmarinushkin@birdec.tech>
Date: Mon, 11 Feb 2019 07:08:38 +0100
Subject: [PATCH] ASoC: pcm3060: Add soft reset on probe

Softly reset registers values on module probe

Signed-off-by: Kirill Marinushkin <kmarinushkin@birdec.tech>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/pcm3060.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/codecs/pcm3060.c b/sound/soc/codecs/pcm3060.c
index 6714aa8d9026..543cb86fd764 100644
--- a/sound/soc/codecs/pcm3060.c
+++ b/sound/soc/codecs/pcm3060.c
@@ -287,6 +287,14 @@ int pcm3060_probe(struct device *dev)
 	int rc;
 	struct pcm3060_priv *priv = dev_get_drvdata(dev);
 
+	/* soft reset */
+	rc = regmap_update_bits(priv->regmap, PCM3060_REG64,
+				PCM3060_REG_MRST, 0);
+	if (rc) {
+		dev_err(dev, "failed to reset component, rc=%d\n", rc);
+		return rc;
+	}
+
 	if (dev->of_node)
 		pcm3060_parse_dt(dev->of_node, priv);
 
-- 
2.20.1
