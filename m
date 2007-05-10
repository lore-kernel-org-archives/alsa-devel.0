From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC AC97 device reg bugfix
Date: Thu, 10 May 2007 17:28:33 +0100
Message-ID: <1178814513.10518.127.camel@a10072.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-hsmSlK4U1sbGo/Pmckx6"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (unknown [80.75.67.54])
	by alsa0.perex.cz (Postfix) with ESMTP id 9E5CC243CD
	for <alsa-devel@alsa-project.org>;
	Thu, 10 May 2007 18:28:34 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Manuel Lauss <mano@roarinelk.homelinux.net>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--=-hsmSlK4U1sbGo/Pmckx6
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch fixes a bug whereby AC97 bus device data was being clobbered
when AC97 codecs using the generic ac97_codec.c driver were being
registered. Codecs that didn't use the generic driver were unaffected
(e.g. WM9712, WM9713).

Changes:-

 o Add new AC97 codec class for custom (or need bus dev registration)
AC97 codecs.
 o Only register/deregister this custom codec device with the AC97 bus.
The generic AC97 driver already does this for generic codec devices.

This may be related to bug #3038 :-
 
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3038

Manuel, can you try this on SH & Au1x00.

Thanks

Liam

--=-hsmSlK4U1sbGo/Pmckx6
Content-Disposition: attachment; filename=ac97-dev-bug.patch
Content-Type: text/x-patch; name=ac97-dev-bug.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r 68ea931654df include/soc.h
--- a/include/soc.h	Thu May 10 17:12:31 2007 +0200
+++ b/include/soc.h	Thu May 10 17:12:52 2007 +0100
@@ -22,7 +22,7 @@
 #include <sound/control.h>
 #include <sound/ac97_codec.h>
 
-#define SND_SOC_VERSION "0.13.0"
+#define SND_SOC_VERSION "0.13.1"
 
 /*
  * Convenience kcontrol builders
@@ -83,6 +83,7 @@
 #define SND_SOC_DAI_AC97	0x1
 #define SND_SOC_DAI_I2S		0x2
 #define SND_SOC_DAI_PCM		0x4
+#define SND_SOC_DAI_AC97_BUS	0x8	/* for custom i.e. non ac97_codec.c */
 
 /*
  * DAI hardware audio formats
@@ -278,6 +279,7 @@ struct snd_soc_codec_dai {
 struct snd_soc_codec_dai {
 	char *name;
 	int id;
+	unsigned char type;
 
 	/* DAI capabilities */
 	struct snd_soc_pcm_stream playback;
diff -r 68ea931654df soc/codecs/ac97.c
--- a/soc/codecs/ac97.c	Thu May 10 17:12:31 2007 +0200
+++ b/soc/codecs/ac97.c	Thu May 10 17:06:07 2007 +0100
@@ -45,6 +45,7 @@ static int ac97_prepare(struct snd_pcm_s
 
 struct snd_soc_codec_dai ac97_dai = {
 	.name = "AC97 HiFi",
+	.type = SND_SOC_DAI_AC97,
 	.playback = {
 		.stream_name = "AC97 Playback",
 		.channels_min = 1,
diff -r 68ea931654df soc/codecs/wm9712.c
--- a/soc/codecs/wm9712.c	Thu May 10 17:12:31 2007 +0200
+++ b/soc/codecs/wm9712.c	Thu May 10 17:06:22 2007 +0100
@@ -544,6 +544,7 @@ struct snd_soc_codec_dai wm9712_dai[] = 
 struct snd_soc_codec_dai wm9712_dai[] = {
 {
 	.name = "AC97 HiFi",
+	.type = SND_SOC_DAI_AC97_BUS,
 	.playback = {
 		.stream_name = "HiFi Playback",
 		.channels_min = 1,
diff -r 68ea931654df soc/soc-core.c
--- a/soc/soc-core.c	Thu May 10 17:12:31 2007 +0200
+++ b/soc/soc-core.c	Thu May 10 17:10:46 2007 +0100
@@ -116,6 +116,7 @@ static inline const char* get_dai_name(i
 static inline const char* get_dai_name(int type)
 {
 	switch(type) {
+	case SND_SOC_DAI_AC97_BUS:
 	case SND_SOC_DAI_AC97:
 		return "AC97";
 	case SND_SOC_DAI_I2S:
@@ -1099,7 +1100,8 @@ int snd_soc_register_card(struct snd_soc
 				continue;
 			}
 		}
-		if (socdev->machine->dai_link[i].cpu_dai->type == SND_SOC_DAI_AC97)
+		if (socdev->machine->dai_link[i].codec_dai->type == 
+			SND_SOC_DAI_AC97_BUS)
 			ac97 = 1;
 	}
 	snprintf(codec->card->shortname, sizeof(codec->card->shortname),
@@ -1148,11 +1150,21 @@ void snd_soc_free_pcms(struct snd_soc_de
 void snd_soc_free_pcms(struct snd_soc_device *socdev)
 {
 	struct snd_soc_codec *codec = socdev->codec;
+#ifdef CONFIG_SND_SOC_AC97_BUS
+	struct snd_soc_codec_dai *codec_dai;
+	int i;
+#endif
 
 	mutex_lock(&codec->mutex);
 #ifdef CONFIG_SND_SOC_AC97_BUS
-	if (codec->ac97)
-		soc_ac97_dev_unregister(codec);
+	for(i = 0; i < codec->num_dai; i++) {
+		codec_dai = &codec->dai[i];
+		if (codec_dai->type == SND_SOC_DAI_AC97_BUS && codec->ac97) {
+			soc_ac97_dev_unregister(codec);
+			goto free_card;
+		}
+	}
+free_card:
 #endif
 
 	if (codec->card)

--=-hsmSlK4U1sbGo/Pmckx6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-hsmSlK4U1sbGo/Pmckx6--
