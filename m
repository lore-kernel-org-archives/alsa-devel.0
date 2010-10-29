From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [RFC_i/iv 2/3] ASoC: Decouple DAPM from CODECs.
 Part codecs (will be squashed)
Date: Fri, 29 Oct 2010 16:45:58 +0300
Message-ID: <20101029164558.fb708d2a.jhnikula@gmail.com>
References: <1288353618-21753-1-git-send-email-jhnikula@gmail.com>
	<1288353618-21753-3-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id DD80824443
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Oct 2010 15:44:42 +0200 (CEST)
Received: by ewy22 with SMTP id 22so1675649ewy.38
	for <alsa-devel@alsa-project.org>; Fri, 29 Oct 2010 06:44:42 -0700 (PDT)
In-Reply-To: <1288353618-21753-3-git-send-email-jhnikula@gmail.com>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, 29 Oct 2010 15:00:17 +0300
Jarkko Nikula <jhnikula@gmail.com> wrote:

> Core implementation:
> Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
> 
> [jhnikula@gmail.com: Fixes and conversions to 88pm860x-codec.c, alc5623,
> max98088.c, twl4060.c, uda1380.c, wm8731.c, wm8741.c, wm8753.c, wm8804,
> wm8904.c, wm8962.c, wm8971.c and wm8985.c.
> Field idle_bias_off removed from struct snd_soc_codec. Affected codecs fixed
> to use dapm->idle_bias_off]
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> ---
Hmm.. have to squash a patch below for cx20442.c, stac9766.c, wm8350.c
and wm8994.c too into next version.


-- 
Jarkko
---
diff --git a/sound/soc/codecs/cx20442.c b/sound/soc/codecs/cx20442.c
index 524a09f..6f121c3 100644
--- a/sound/soc/codecs/cx20442.c
+++ b/sound/soc/codecs/cx20442.c
@@ -263,7 +263,7 @@ static void v253_close(struct tty_struct *tty)
 	/* Prevent the codec driver from further accessing the modem */
 	codec->hw_write = NULL;
 	cx20442->control_data = NULL;
-	codec->pop_time = 0;
+	codec->dapm->pop_time = 0;
 }
 
 /* Line discipline .hangup() */
@@ -291,7 +291,7 @@ static void v253_receive(struct tty_struct *tty,
 		/* Set up codec driver access to modem controls */
 		cx20442->control_data = tty;
 		codec->hw_write = (hw_write_t)tty->ops->write;
-		codec->pop_time = 1;
+		codec->dapm->pop_time = 1;
 	}
 }
 
@@ -348,7 +348,7 @@ static int cx20442_codec_probe(struct snd_soc_codec *codec)
 
 	cx20442->control_data = NULL;
 	codec->hw_write = NULL;
-	codec->pop_time = 0;
+	codec->dapm->pop_time = 0;
 
 	return 0;
 }
diff --git a/sound/soc/codecs/stac9766.c b/sound/soc/codecs/stac9766.c
index 0065789..519999b 100644
--- a/sound/soc/codecs/stac9766.c
+++ b/sound/soc/codecs/stac9766.c
@@ -24,6 +24,7 @@
 #include <sound/initval.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
+#include <sound/soc-dapm.h>
 #include <sound/tlv.h>
 
 #include "stac9766.h"
diff --git a/sound/soc/codecs/wm8350.c b/sound/soc/codecs/wm8350.c
index bb1b470..4c2259e 100644
--- a/sound/soc/codecs/wm8350.c
+++ b/sound/soc/codecs/wm8350.c
@@ -230,8 +230,9 @@ static inline int wm8350_out2_ramp_step(struct snd_soc_codec *codec)
  */
 static void wm8350_pga_work(struct work_struct *work)
 {
-	struct snd_soc_codec *codec =
-	    container_of(work, struct snd_soc_codec, delayed_work.work);
+	struct snd_soc_dapm_context *dapm =
+	    container_of(work, struct snd_soc_dapm_context, delayed_work.work);
+	struct snd_soc_codec *codec = dapm->codec;
 	struct wm8350_data *wm8350_data = snd_soc_codec_get_drvdata(codec);
 	struct wm8350_output *out1 = &wm8350_data->out1,
 	    *out2 = &wm8350_data->out2;
@@ -302,8 +303,8 @@ static int pga_event(struct snd_soc_dapm_widget *w,
 		out->ramp = WM8350_RAMP_UP;
 		out->active = 1;
 
-		if (!delayed_work_pending(&codec->delayed_work))
-			schedule_delayed_work(&codec->delayed_work,
+		if (!delayed_work_pending(&codec->dapm->delayed_work))
+			schedule_delayed_work(&codec->dapm->delayed_work,
 					      msecs_to_jiffies(1));
 		break;
 
@@ -311,8 +312,8 @@ static int pga_event(struct snd_soc_dapm_widget *w,
 		out->ramp = WM8350_RAMP_DOWN;
 		out->active = 0;
 
-		if (!delayed_work_pending(&codec->delayed_work))
-			schedule_delayed_work(&codec->delayed_work,
+		if (!delayed_work_pending(&codec->dapm->delayed_work))
+			schedule_delayed_work(&codec->dapm->delayed_work,
 					      msecs_to_jiffies(1));
 		break;
 	}
@@ -1550,7 +1551,7 @@ static  int wm8350_codec_probe(struct snd_soc_codec *codec)
 	/* Put the codec into reset if it wasn't already */
 	wm8350_clear_bits(wm8350, WM8350_POWER_MGMT_5, WM8350_CODEC_ENA);
 
-	INIT_DELAYED_WORK(&codec->delayed_work, wm8350_pga_work);
+	INIT_DELAYED_WORK(&codec->dapm->delayed_work, wm8350_pga_work);
 
 	/* Enable the codec */
 	wm8350_set_bits(wm8350, WM8350_POWER_MGMT_5, WM8350_CODEC_ENA);
@@ -1635,12 +1636,12 @@ static int  wm8350_codec_remove(struct snd_soc_codec *codec)
 	priv->mic.jack = NULL;
 
 	/* cancel any work waiting to be queued. */
-	ret = cancel_delayed_work(&codec->delayed_work);
+	ret = cancel_delayed_work(&codec->dapm->delayed_work);
 
 	/* if there was any work waiting then we run it now and
 	 * wait for its completion */
 	if (ret) {
-		schedule_delayed_work(&codec->delayed_work, 0);
+		schedule_delayed_work(&codec->dapm->delayed_work, 0);
 		flush_scheduled_work();
 	}
 
diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 57ba0b1..dc4aa89 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -1837,7 +1837,7 @@ static int configure_clock(struct snd_soc_codec *codec)
 
 	snd_soc_update_bits(codec, WM8994_CLOCKING_1, WM8994_SYSCLK_SRC, new);
 
-	snd_soc_dapm_sync(codec);
+	snd_soc_dapm_sync(codec->dapm);
 
 	return 0;
 }
