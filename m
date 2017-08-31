From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max98927: Changed device property read function" to the asoc tree
Date: Thu, 31 Aug 2017 12:54:29 +0100
Message-ID: <E1dnO3J-0000h2-BV@debutante>
References: <1503708070-7906-9-git-send-email-ryans.lee@maximintegrated.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1503708070-7906-9-git-send-email-ryans.lee@maximintegrated.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, lgirdwood@gmail.combroonie@kernel.org, perex@perex.cz, tiwai@suse.com, ryans.lee@maximintegrated.com, kuninori.morimoto.gx@renesas.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, ryan.lee.maxim@gmail.comalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: max98927: Changed device property read function

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

>From dea110501745734baf7a90dc1e1b50481ade6191 Mon Sep 17 00:00:00 2001
From: Ryan Lee <ryans.lee@maximintegrated.com>
Date: Mon, 28 Aug 2017 16:31:01 -0700
Subject: [PATCH] ASoC: max98927: Changed device property read function

Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98927.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/max98927.c b/sound/soc/codecs/max98927.c
index 4bbf2098f255..926871e36132 100644
--- a/sound/soc/codecs/max98927.c
+++ b/sound/soc/codecs/max98927.c
@@ -759,14 +759,14 @@ static void max98927_slot_config(struct i2c_client *i2c,
 	struct max98927_priv *max98927)
 {
 	int value;
+	struct device *dev = &i2c->dev;
 
-	if (!of_property_read_u32(i2c->dev.of_node,
-		"vmon-slot-no", &value))
+	if (!device_property_read_u32(dev, "vmon-slot-no", &value))
 		max98927->v_l_slot = value & 0xF;
 	else
 		max98927->v_l_slot = 0;
-	if (!of_property_read_u32(i2c->dev.of_node,
-		"imon-slot-no", &value))
+
+	if (!device_property_read_u32(dev, "imon-slot-no", &value))
 		max98927->i_l_slot = value & 0xF;
 	else
 		max98927->i_l_slot = 1;
-- 
2.14.1
