From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tlv320dac33: fix regression by adding
	back .read/.write" to the asoc tree
Date: Tue, 16 Jan 2018 13:56:51 +0000
Message-ID: <E1ebRjP-0005AW-OE@debutante>
References: <87zi5e8t0k.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F38D26771C
 for <alsa-devel@alsa-project.org>; Tue, 16 Jan 2018 14:56:55 +0100 (CET)
In-Reply-To: <87zi5e8t0k.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tlv320dac33: fix regression by adding back .read/.write

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

>From 3d3dd0d3ac207e8d28f6289896b99c1c0dad2fbe Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 16 Jan 2018 01:59:01 +0000
Subject: [PATCH] ASoC: tlv320dac33: fix regression by adding back .read/.write

commit c4305af43a8 ("ASoC: use internal reg_cache on tlv320dac33")
removed .read/.write from driver, but it might breaks non-regmap
driver, because ALSA SoC framework might call it.

To fix this regression, this patch back .read/.write

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tlv320dac33.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index 675f5b1b90a6..8c71d2f876ff 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -246,6 +246,19 @@ static int dac33_write(struct snd_soc_codec *codec, unsigned int reg,
 	return ret;
 }
 
+static int dac33_write_locked(struct snd_soc_codec *codec, unsigned int reg,
+			      unsigned int value)
+{
+	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
+	int ret;
+
+	mutex_lock(&dac33->mutex);
+	ret = dac33_write(codec, reg, value);
+	mutex_unlock(&dac33->mutex);
+
+	return ret;
+}
+
 #define DAC33_I2C_ADDR_AUTOINC	0x80
 static int dac33_write16(struct snd_soc_codec *codec, unsigned int reg,
 		       unsigned int value)
@@ -1422,6 +1435,8 @@ static int dac33_soc_remove(struct snd_soc_codec *codec)
 }
 
 static const struct snd_soc_codec_driver soc_codec_dev_tlv320dac33 = {
+	.read = dac33_read_reg_cache,
+	.write = dac33_write_locked,
 	.set_bias_level = dac33_set_bias_level,
 	.idle_bias_off = true,
 
-- 
2.15.1
