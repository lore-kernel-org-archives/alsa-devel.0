From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: ASoC: Make ams-delta/cx20442 pair back working for
	multi-component
Date: Wed, 11 Aug 2010 01:29:32 +0200
Message-ID: <201008110129.34662.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from d1.icnet.pl (d1.icnet.pl [212.160.220.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 27F1D24463
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Aug 2010 01:37:48 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

1.
After a static codec pointer removal from the sound/soc/codecs/cx20442.c code, 
both codec and card specific tty line discipline functions lost their access 
to the codec structure data. Arrange for passing the pointer back to the codec 
tty ldisc bits from the card initialization code.

2.
Update incosistent codec device naming in the card code.

3.
Since a new element, control_data, has been added to the cx20442_priv 
structure, it looks like the old snd_soc_codec->control_data may be scheduled 
for removal. To avoid problems in the near future, use the 
cx20442_priv->control_data instead of the snd_soc_codec->control_data 
throughout the cx20442 code. In the ams-delta card code, check for the 
snd_soc_codec->hw_write not NULL instead of the snd_soc_codec->control_data.

Created and tested on Amstrad Delta against 
git://git.kernel.org/pub/scm/linux/kernel/git/lrg/asoc-2.6.git,
commit a212dd5b2e1da045cbf423c70c87f48265531de4.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
---
--- git/sound/soc/codecs/cx20442.c.orig	2010-08-10 17:43:17.000000000 +0200
+++ git/sound/soc/codecs/cx20442.c	2010-08-11 01:08:23.000000000 +0200
@@ -165,6 +165,7 @@ static int cx20442_pm_to_v253_vsp(u8 val
 static int cx20442_write(struct snd_soc_codec *codec, unsigned int reg,
 							unsigned int value)
 {
+	struct cx20442_priv *cx20442 = snd_soc_codec_get_drvdata(codec);
 	u8 *reg_cache = codec->reg_cache;
 	int vls, vsp, old, len;
 	char buf[18];
@@ -174,7 +175,7 @@ static int cx20442_write(struct snd_soc_
 
 	/* hw_write and control_data pointers required for talking to the modem
 	 * are expected to be set by the line discipline initialization code */
-	if (!codec->hw_write || !codec->control_data)
+	if (!codec->hw_write || !cx20442->control_data)
 		return -EIO;
 
 	old = reg_cache[reg];
@@ -203,17 +204,13 @@ static int cx20442_write(struct snd_soc_
 		return -ENOMEM;
 
 	dev_dbg(codec->dev, "%s: %s\n", __func__, buf);
-	if (codec->hw_write(codec->control_data, buf, len) != len)
+	if (codec->hw_write(cx20442->control_data, buf, len) != len)
 		return -EIO;
 
 	return 0;
 }
 
 
-/* Moved up here as line discipline referres it during initialization */
-static struct snd_soc_codec *cx20442_codec;
-
-
 /*
  * Line discpline related code
  *
@@ -229,15 +226,15 @@ static const char *v253_init = "ate0m0q0
 /* Line discipline .open() */
 static int v253_open(struct tty_struct *tty)
 {
-	struct snd_soc_codec *codec = cx20442_codec;
 	int ret, len = strlen(v253_init);
 
 	/* Doesn't make sense without write callback */
 	if (!tty->ops->write)
 		return -EINVAL;
 
-	/* Pass the codec structure address for use by other ldisc callbacks */
-	tty->disc_data = codec;
+	/* Won't work if no codec pointer has been passed by a card driver */
+	if (!tty->disc_data)
+		return -ENODEV;
 
 	if (tty->ops->write(tty, v253_init, len) != len) {
 		ret = -EIO;
@@ -254,15 +251,18 @@ err:
 static void v253_close(struct tty_struct *tty)
 {
 	struct snd_soc_codec *codec = tty->disc_data;
+	struct cx20442_priv *cx20442;
 
 	tty->disc_data = NULL;
 
 	if (!codec)
 		return;
 
+	cx20442 = snd_soc_codec_get_drvdata(codec);
+
 	/* Prevent the codec driver from further accessing the modem */
 	codec->hw_write = NULL;
-	codec->control_data = NULL;
+	cx20442->control_data = NULL;
 	codec->pop_time = 0;
 }
 
@@ -278,15 +278,18 @@ static void v253_receive(struct tty_stru
 				const unsigned char *cp, char *fp, int count)
 {
 	struct snd_soc_codec *codec = tty->disc_data;
+	struct cx20442_priv *cx20442;
 
 	if (!codec)
 		return;
 
-	if (!codec->control_data) {
+	cx20442 = snd_soc_codec_get_drvdata(codec);
+
+	if (!cx20442->control_data) {
 		/* First modem response, complete setup procedure */
 
 		/* Set up codec driver access to modem controls */
-		codec->control_data = tty;
+		cx20442->control_data = tty;
 		codec->hw_write = (hw_write_t)tty->ops->write;
 		codec->pop_time = 1;
 	}
@@ -343,7 +346,7 @@ static int cx20442_codec_probe(struct sn
 
 	cx20442_add_widgets(codec);
 
-	codec->control_data = NULL;
+	cx20442->control_data = NULL;
 	codec->hw_write = NULL;
 	codec->pop_time = 0;
 
@@ -355,8 +358,8 @@ static int cx20442_codec_remove(struct s
 {
 	struct cx20442_priv *cx20442 = snd_soc_codec_get_drvdata(codec);
 
-	if (codec->control_data) {
-			struct tty_struct *tty = codec->control_data;
+	if (cx20442->control_data) {
+			struct tty_struct *tty = cx20442->control_data;
 			tty_hangup(tty);
 	}
 
--- git/sound/soc/omap/ams-delta.c.orig	2010-08-10 17:43:17.000000000 +0200
+++ git/sound/soc/omap/ams-delta.c	2010-08-11 00:58:22.000000000 +0200
@@ -99,7 +99,7 @@ static int ams_delta_set_audio_mode(stru
 	int pin, changed = 0;
 
 	/* Refuse any mode changes if we are not able to control the codec. */
-	if (!codec->control_data)
+	if (!codec->hw_write)
 		return -EUNATCH;
 
 	if (ucontrol->value.enumerated.item[0] >= control->max)
@@ -268,10 +268,32 @@ static void cx81801_timeout(unsigned lon
 		ams_delta_latch2_write(AMS_DELTA_LATCH2_MODEM_CODEC, 0);
 }
 
+/*
+ * Used for passing a codec structure pointer
+ * from the board initialization code to the tty line discipline.
+ */
+static struct snd_soc_codec *cx20442_codec;
+
 /* Line discipline .open() */
 static int cx81801_open(struct tty_struct *tty)
 {
-	return v253_ops.open(tty);
+	int ret;
+
+	if (!cx20442_codec)
+		return -ENODEV;
+
+	/*
+	 * Pass the codec structure pointer for use by other ldisc callbacks,
+	 * both the card and the codec specific parts.
+	 */
+	tty->disc_data = cx20442_codec;
+
+	ret = v253_ops.open(tty);
+
+	if (ret < 0)
+		tty->disc_data = NULL;
+
+	return ret;
 }
 
 /* Line discipline .close() */
@@ -281,11 +303,14 @@ static void cx81801_close(struct tty_str
 
 	del_timer_sync(&cx81801_timer);
 
-	v253_ops.close(tty);
-
 	/* Prevent the hook switch from further changing the DAPM pins */
 	INIT_LIST_HEAD(&ams_delta_hook_switch.pins);
 
+	if (!codec)
+		return;
+
+	v253_ops.close(tty);
+
 	/* Revert back to default audio input/output constellation */
 	snd_soc_dapm_disable_pin(codec, "Mouthpiece");
 	snd_soc_dapm_enable_pin(codec, "Earpiece");
@@ -310,7 +335,10 @@ static void cx81801_receive(struct tty_s
 	const unsigned char *c;
 	int apply, ret;
 
-	if (!codec->control_data) {
+	if (!codec)
+		return;
+
+	if (!codec->hw_write) {
 		/* First modem response, complete setup procedure */
 
 		/* Initialize timer used for config pulse generation */
@@ -469,6 +497,9 @@ static int ams_delta_cx20442_init(struct
 	int ret;
 	/* Codec is ready, now add/activate board specific controls */
 
+	/* Store a pointer to the codec structure for tty ldisc use */
+	cx20442_codec = codec;
+
 	/* Set up digital mute if not provided by the codec */
 	if (!codec_dai->driver->ops) {
 		codec_dai->driver->ops = &ams_delta_dai_ops;
@@ -595,8 +626,8 @@ static int __init ams_delta_module_init(
 	 * Codec platform device could be registered from elsewhere (board?),
 	 * but I do it here as it makes sense only if used with the card.
 	 */
-	cx20442_platform_device = platform_device_register_simple("cx20442",
-								-1, NULL, 0);
+	cx20442_platform_device =
+		platform_device_register_simple("cx20442-codec", -1, NULL, 0);
 	return 0;
 err:
 	platform_device_put(ams_delta_audio_platform_device);
