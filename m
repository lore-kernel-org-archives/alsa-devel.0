From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [RFC] [PATCH] ASoC: CX20442: push down machine
	independent line discipline bits
Date: Tue, 28 Jul 2009 21:55:28 +0200
Message-ID: <200907282155.29761.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from d1.icnet.pl (d1.icnet.pl [212.160.220.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 3A7C22475C
	for <alsa-devel@alsa-project.org>;
	Tue, 28 Jul 2009 21:55:55 +0200 (CEST)
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
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This patch adds machine independent line discipline code, prevoiusly exsiting
inside my Amstrad Delta ASoC machine dirver, to the Conexant CX20442 codec
driver. The code can be used as a standalone line discipline, or as a set of
codec specific functions called from machine's line discipline callbacks.
Anyway, the line discipline itself must be registered by a machine driver.

Suggested by ASoC manintainer Mark Brown <broonie@opensource.wolfsonmicro.com>

(Hardly understood, imperfectly implemented and)
Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
---
Mark, does it follow your idea closely enough?

--- linux-2.6.31-rc3/sound/soc/codecs/cx20442.h.orig	2009-07-22 
04:56:45.000000000 +0200
+++ linux-2.6.31-rc3/sound/soc/codecs/cx20442.h	2009-07-28 21:23:17.000000000 
+0200
@@ -15,5 +15,6 @@
 
 extern struct snd_soc_dai cx20442_dai;
 extern struct snd_soc_codec_device cx20442_codec_dev;
+extern struct tty_ldisc_ops v253_ops;
 
 #endif
--- linux-2.6.31-rc3/sound/soc/codecs/cx20442.c.orig	2009-07-28 
20:26:18.000000000 +0200
+++ linux-2.6.31-rc3/sound/soc/codecs/cx20442.c	2009-07-28 21:19:43.000000000 
+0200
@@ -13,6 +13,8 @@
  *  option) any later version.
  */
 
+#include <linux/tty.h>
+
 #include <sound/core.h>
 #include <sound/initval.h>
 #include <sound/soc-dapm.h>
@@ -172,8 +174,7 @@ static int cx20442_write(struct snd_soc_
 		return -EINVAL;
 
 	/* hw_write and control_data pointers required for talking to the modem
-	 * are expected to be set by the machine driver's line discipline
-	 * initialization code */
+	 * are expected to be set by a line discipline initialization code */
 	if (!codec->hw_write || !codec->control_data)
 		return -EIO;
 
@@ -208,6 +209,111 @@ static int cx20442_write(struct snd_soc_
 	return 0;
 }
 
+
+/* Moved up here as line discipline referres it during initialization */
+static struct snd_soc_codec *cx20442_codec;
+
+
+/*
+ * Line discpline related code
+ *
+ * Any of the callback functions below can be used in two ways:
+ * 1) registerd by a machine driver as one of line discipline operations,
+ * 2) called from inside a machine specific line discipline callback function
+ *    in case when extra machine specific code must be run as well.
+ */
+
+/* Modem init: echo off, digital speaker off, quiet off, voice mode */
+static const char *v253_init = "ate0m0q0+fclass=8\r";
+
+/* Line discipline .open() */
+static int v253_open(struct tty_struct *tty)
+{
+	struct snd_soc_codec *codec = cx20442_codec;
+	int ret, len = strlen(v253_init);
+
+	/* Doesn't make sense without write callback */
+	if (!tty->ops->write)
+		return -EINVAL;
+
+	/* Pass the codec structure address for use by other ldisc callbacks */
+	tty->disc_data = codec;
+
+	if (tty->ops->write(tty, v253_init, len) != len) {
+		ret = -EIO;
+		goto err;
+	}
+	/* Actual setup will be performed after the modem responds. */
+	return 0;
+err:
+	tty->disc_data = NULL;
+	return ret;
+}
+
+/* Line discipline .close() */
+static void v253_close(struct tty_struct *tty)
+{
+	struct snd_soc_codec *codec = tty->disc_data;
+
+	tty->disc_data = NULL;
+
+	if (!codec)
+		return;
+
+	/* Prevent the codec driver from further accessing the modem */
+	codec->hw_write = NULL;
+	codec->control_data = NULL;
+	codec->pop_time = 0;
+}
+
+/* Line discipline .hangup() */
+static int v253_hangup(struct tty_struct *tty)
+{
+	v253_close(tty);
+	return 0;
+}
+
+/* Line discipline .receive_buf() */
+static void v253_receive(struct tty_struct *tty,
+				const unsigned char *cp, char *fp, int count)
+{
+	struct snd_soc_codec *codec = tty->disc_data;
+
+	if (!codec)
+		return;
+
+	if (!codec->control_data) {
+		/* First modem response, complete setup procedure */
+
+		/* Set up codec driver access to modem controls */
+		codec->control_data = tty;
+		codec->hw_write = (hw_write_t)tty->ops->write;
+		codec->pop_time = 1;
+	}
+}
+
+/* Line discipline .write_wakeup() */
+static void v253_wakeup(struct tty_struct *tty)
+{
+}
+
+static struct tty_ldisc_ops v253_ops = {
+	.magic = TTY_LDISC_MAGIC,
+	.name = "cx20442",
+	.owner = THIS_MODULE,
+	.open = v253_open,
+	.close = v253_close,
+	.hangup = v253_hangup,
+	.receive_buf = v253_receive,
+	.write_wakeup = v253_wakeup,
+};
+EXPORT_SYMBOL_GPL(v253_ops);
+
+
+/*
+ * Codec DAI
+ */
+
 struct snd_soc_dai cx20442_dai = {
 	.name = "CX20442",
 	.playback = {
@@ -227,8 +333,6 @@ struct snd_soc_dai cx20442_dai = {
 };
 EXPORT_SYMBOL_GPL(cx20442_dai);
 
-static struct snd_soc_codec *cx20442_codec;
-
 static int cx20442_codec_probe(struct platform_device *pdev)
 {
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
