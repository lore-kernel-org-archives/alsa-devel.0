From: Shine Liu <shinel@foxmail.com>
Subject: [PATCH] ASoC: UDA134X Codec: Fix mute/unmute code
 mistake and add ADC/DAC power control support
Date: Mon, 17 Aug 2009 14:57:20 +0800
Message-ID: <1250492240.5224.68.camel@shinel>
Reply-To: shinel@foxmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpbg76.qq.com (smtpbg76.qq.com [119.147.10.235])
	by alsa0.perex.cz (Postfix) with SMTP id 3F76A245F3
	for <alsa-devel@alsa-project.org>;
	Mon, 17 Aug 2009 08:57:46 +0200 (CEST)
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
List-Id: alsa-devel@alsa-project.org


There is a mistake in current uda134x_mute function: mute_reg has been
changed in line 162 or line 164, so uda134x_write should write
"mute_reg" but not "mute_reg & ~(1<<2)" to 
UDA134X_DATA010.

Besides, because there is no DAPM configuration for uda134x, when system
starts up, snd_soc_int_card calls snd_soc_dapm_new_widgets, and
snd_soc_dapm_new_widgets calls dapm_power_widgets. In function
dapm_power_widgets, codec->dapm_widgets has no list entry, so sys_power
retains it's original value zero. Then
snd_soc_dapm_set_bias_level(socdev, SND_SOC_BIAS_PREPARE) and  
snd_soc_dapm_set_bias_level(socdev, SND_SOC_BIAS_STANDBY) are called
sequentially. Finally, the uda134x codec goes to STANDBY mode, so the
ADC/DAC power control bits of UDA134X_STATUS1 register keeps the 0
value.

UDA134X has no trigger function currently, and the ADC/DAC power control
bits of UDA134X_STATUS1 register are not exported in
uda1341_snd_controls, so there's no way to enable the ADC/DAC power
control bits when you want to use the codec. When playing with aplay or
recording with arecord, there is no sound output or no wave input.

I have added the uda134x_trigger function, which turns on/off the
ADC/DAC power control bits according the substream type and the command.
I also exported the ADC/DAC power control bits to uda1341_snd_controls,
so we can also turn these bits on/off as we need via a mixer tool like
alsamixer.

The patch created against linux-2.6.31-rc3.
Tested on a s3c2440 development board with UDA1341TS codec.


Signed-off-by: Shine Liu <shinel@foxmail.com>  

--- sound/soc/codecs/uda134x.c.orig	2009-07-14 09:18:52.000000000 +0800
+++ sound/soc/codecs/uda134x.c	2009-08-17 13:46:57.000000000 +0800
@@ -163,7 +163,7 @@
 	else
 		mute_reg &= ~(1<<2);
 
-	uda134x_write(codec, UDA134X_DATA010, mute_reg & ~(1<<2));
+	uda134x_write(codec, UDA134X_DATA010, mute_reg);
 
 	return 0;
 }
@@ -339,6 +339,38 @@
 	return 0;
 }
 
+static int uda134x_trigger(struct snd_pcm_substream *substream,
+			   int cmd, struct snd_soc_dai *dai)
+{
+	int stream = substream->stream;
+	struct snd_soc_codec *codec = dai->codec;
+	u8 power_ctrl_reg = uda134x_read_reg_cache(codec, UDA134X_STATUS1);
+
+	pr_debug("%s stream: %d, cmd: %d\n", __func__, stream, cmd);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		if (stream == SNDRV_PCM_STREAM_PLAYBACK)
+			power_ctrl_reg |= (1<<0);
+		else
+			power_ctrl_reg |= (1<<1);
+		break;
+
+	case SNDRV_PCM_TRIGGER_STOP:
+		if (stream == SNDRV_PCM_STREAM_PLAYBACK)
+			power_ctrl_reg &= ~(1<<0);
+		else
+			power_ctrl_reg &= ~(1<<1);
+		break;
+
+	default:
+		return 0;
+	}
+
+	uda134x_write(codec, UDA134X_STATUS1, power_ctrl_reg);
+	return 0;
+}
+
 static int uda134x_set_bias_level(struct snd_soc_codec *codec,
 				  enum snd_soc_bias_level level)
 {
@@ -416,6 +448,8 @@
 SOC_SINGLE("ADC Polarity Switch", UDA134X_STATUS1, 4, 1, 0),
 SOC_SINGLE("DAC Polarity Switch", UDA134X_STATUS1, 3, 1, 0),
 SOC_SINGLE("Double Speed Playback Switch", UDA134X_STATUS1, 2, 1, 0),
+SOC_SINGLE("ADC Power Switch", UDA134X_STATUS1, 1, 1, 0),
+SOC_SINGLE("DAC Power Switch", UDA134X_STATUS1, 0, 1, 0),
 SOC_SINGLE("DC Filter Enable Switch", UDA134X_STATUS0, 0, 1, 0),
 };
 
@@ -438,6 +472,7 @@
 	.digital_mute	= uda134x_mute,
 	.set_sysclk	= uda134x_set_dai_sysclk,
 	.set_fmt	= uda134x_set_dai_fmt,
+	.trigger	= uda134x_trigger,
 };
 
 struct snd_soc_dai uda134x_dai = {
