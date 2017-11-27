From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: don't use codec hw_write on
	cx20442/omap-ams-delta" to the asoc tree
Date: Mon, 27 Nov 2017 18:52:11 +0000
Message-ID: <E1eJOVn-0006tR-R4@debutante>
References: <87d17bm10t.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9E51E26756C
 for <alsa-devel@alsa-project.org>; Mon, 27 Nov 2017 19:52:15 +0100 (CET)
In-Reply-To: <87d17bm10t.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Lars-Peter <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: don't use codec hw_write on cx20442/omap-ams-delta

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

>From fac3f5e20dcecc2aa03272c5d2d36d253883c6ce Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 9 Nov 2017 01:04:09 +0000
Subject: [PATCH] ASoC: don't use codec hw_write on cx20442/omap-ams-delta

cx20442/omap-ams-delta driver is using codec hw_write/control_data,
but it is redundant code. This patch cleanup these

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cx20442.c | 23 ++++++++++-------------
 sound/soc/omap/ams-delta.c |  4 ++--
 2 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/sound/soc/codecs/cx20442.c b/sound/soc/codecs/cx20442.c
index 46b1fbb66eba..2083f7eb9de2 100644
--- a/sound/soc/codecs/cx20442.c
+++ b/sound/soc/codecs/cx20442.c
@@ -26,7 +26,7 @@
 
 
 struct cx20442_priv {
-	void *control_data;
+	struct tty_struct *tty;
 	struct regulator *por;
 };
 
@@ -163,9 +163,9 @@ static int cx20442_write(struct snd_soc_codec *codec, unsigned int reg,
 	if (reg >= codec->driver->reg_cache_size)
 		return -EINVAL;
 
-	/* hw_write and control_data pointers required for talking to the modem
+	/* tty and write pointers required for talking to the modem
 	 * are expected to be set by the line discipline initialization code */
-	if (!codec->hw_write || !cx20442->control_data)
+	if (!cx20442->tty || !cx20442->tty->ops->write)
 		return -EIO;
 
 	old = reg_cache[reg];
@@ -194,7 +194,7 @@ static int cx20442_write(struct snd_soc_codec *codec, unsigned int reg,
 		return -ENOMEM;
 
 	dev_dbg(codec->dev, "%s: %s\n", __func__, buf);
-	if (codec->hw_write(cx20442->control_data, buf, len) != len)
+	if (cx20442->tty->ops->write(cx20442->tty, buf, len) != len)
 		return -EIO;
 
 	return 0;
@@ -252,8 +252,7 @@ static void v253_close(struct tty_struct *tty)
 	cx20442 = snd_soc_codec_get_drvdata(codec);
 
 	/* Prevent the codec driver from further accessing the modem */
-	codec->hw_write = NULL;
-	cx20442->control_data = NULL;
+	cx20442->tty = NULL;
 	codec->component.card->pop_time = 0;
 }
 
@@ -276,12 +275,11 @@ static void v253_receive(struct tty_struct *tty,
 
 	cx20442 = snd_soc_codec_get_drvdata(codec);
 
-	if (!cx20442->control_data) {
+	if (!cx20442->tty) {
 		/* First modem response, complete setup procedure */
 
 		/* Set up codec driver access to modem controls */
-		cx20442->control_data = tty;
-		codec->hw_write = (hw_write_t)tty->ops->write;
+		cx20442->tty = tty;
 		codec->component.card->pop_time = 1;
 	}
 }
@@ -367,10 +365,9 @@ static int cx20442_codec_probe(struct snd_soc_codec *codec)
 	cx20442->por = regulator_get(codec->dev, "POR");
 	if (IS_ERR(cx20442->por))
 		dev_warn(codec->dev, "failed to get the regulator");
-	cx20442->control_data = NULL;
+	cx20442->tty = NULL;
 
 	snd_soc_codec_set_drvdata(codec, cx20442);
-	codec->hw_write = NULL;
 	codec->component.card->pop_time = 0;
 
 	return 0;
@@ -381,8 +378,8 @@ static int cx20442_codec_remove(struct snd_soc_codec *codec)
 {
 	struct cx20442_priv *cx20442 = snd_soc_codec_get_drvdata(codec);
 
-	if (cx20442->control_data) {
-		struct tty_struct *tty = cx20442->control_data;
+	if (cx20442->tty) {
+		struct tty_struct *tty = cx20442->tty;
 		tty_hangup(tty);
 	}
 
diff --git a/sound/soc/omap/ams-delta.c b/sound/soc/omap/ams-delta.c
index d40219678700..cb72c1e57da0 100644
--- a/sound/soc/omap/ams-delta.c
+++ b/sound/soc/omap/ams-delta.c
@@ -105,7 +105,7 @@ static int ams_delta_set_audio_mode(struct snd_kcontrol *kcontrol,
 	int pin, changed = 0;
 
 	/* Refuse any mode changes if we are not able to control the codec. */
-	if (!cx20442_codec->hw_write)
+	if (!cx20442_codec->component.card->pop_time)
 		return -EUNATCH;
 
 	if (ucontrol->value.enumerated.item[0] >= control->items)
@@ -345,7 +345,7 @@ static void cx81801_receive(struct tty_struct *tty,
 	if (!codec)
 		return;
 
-	if (!codec->hw_write) {
+	if (!codec->component.card->pop_time) {
 		/* First modem response, complete setup procedure */
 
 		/* Initialize timer used for config pulse generation */
-- 
2.15.0
