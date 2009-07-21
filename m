From: Marek Vasut <marek.vasut@gmail.com>
Subject: [PATCH] Allow passing platform_data to devices
	attached to AC97 bus
Date: Tue, 21 Jul 2009 16:33:14 +0200
Message-ID: <200907211633.14388.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_qGdZKEllDjzV5l9"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f226.google.com (mail-fx0-f226.google.com
	[209.85.220.226])
	by alsa0.perex.cz (Postfix) with ESMTP id E2E9810381E
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Jul 2009 16:33:34 +0200 (CEST)
Received: by fxm26 with SMTP id 26so2854314fxm.32
	for <alsa-devel@alsa-project.org>; Tue, 21 Jul 2009 07:33:33 -0700 (PDT)
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
Cc: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_qGdZKEllDjzV5l9
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I managed to put together this patch with huge help from Mark. It allows 
passing platform_data to devices on ac97 bus and implements this for pxa2xx-
ac97. Please consider applying.

--Boundary-00=_qGdZKEllDjzV5l9
Content-Type: text/x-patch;
  charset="UTF-8";
  name="0001-Allow-passing-platform_data-to-devices-attached-to-A.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-Allow-passing-platform_data-to-devices-attached-to-A.patch"

=46rom dc427c54f0fede86acb6e21b09908597b066f021 Mon Sep 17 00:00:00 2001
=46rom: Marek Vasut <marek.vasut@gmail.com>
Date: Tue, 21 Jul 2009 16:22:29 +0200
Subject: [PATCH] Allow passing platform_data to devices attached to AC97 bus

This patch allows passing platform_data to devices attached to AC97 bus
(like touchscreens, battery measurement chips ...). This patch also adds
this support into PXA2xx-AC97 driver as a reference implementation.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
=2D--
 arch/arm/mach-pxa/include/mach/audio.h |    1 +
 include/sound/ac97_codec.h             |    3 +++
 include/sound/soc-dai.h                |    1 +
 sound/arm/pxa2xx-ac97.c                |    3 +++
 sound/pci/ac97/ac97_codec.c            |    7 +++++++
 sound/soc/pxa/pxa2xx-ac97.c            |    7 ++++++-
 sound/soc/soc-core.c                   |    5 ++++-
 7 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/audio.h b/arch/arm/mach-pxa/inc=
lude/mach/audio.h
index 16eb025..8825b18 100644
=2D-- a/arch/arm/mach-pxa/include/mach/audio.h
+++ b/arch/arm/mach-pxa/include/mach/audio.h
@@ -20,6 +20,7 @@ typedef struct {
 	void (*resume)(void *);
 	void *priv;
 	int reset_gpio;
+	void *codec_pdata[4];
 } pxa2xx_audio_ops_t;
=20
 extern void pxa_set_ac97_info(pxa2xx_audio_ops_t *ops);
diff --git a/include/sound/ac97_codec.h b/include/sound/ac97_codec.h
index 251fc1c..c6b24e2 100644
=2D-- a/include/sound/ac97_codec.h
+++ b/include/sound/ac97_codec.h
@@ -642,4 +642,7 @@ int snd_ac97_pcm_double_rate_rules(struct snd_pcm_runti=
me *runtime);
 /* ad hoc AC97 device driver access */
 extern struct bus_type ac97_bus_type;
=20
+/* AC97 platform_data adding function */
+void snd_ac97_dev_add_pdata(struct snd_ac97 *ac97, void *data);
+
 #endif /* __SOUND_AC97_CODEC_H */
diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 352d7ee..0d65a03 100644
=2D-- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -179,6 +179,7 @@ struct snd_soc_dai {
 	int ac97_control;
=20
 	struct device *dev;
+	void *ac97_pdata;	/* platform_data for the ac97 codec */
=20
 	/* DAI callbacks */
 	int (*probe)(struct platform_device *pdev,
diff --git a/sound/arm/pxa2xx-ac97.c b/sound/arm/pxa2xx-ac97.c
index c570ebd..cfab74e 100644
=2D-- a/sound/arm/pxa2xx-ac97.c
+++ b/sound/arm/pxa2xx-ac97.c
@@ -170,6 +170,8 @@ static int __devinit pxa2xx_ac97_probe(struct platform_=
device *dev)
 	struct snd_ac97_bus *ac97_bus;
 	struct snd_ac97_template ac97_template;
 	int ret;
+	pxa2xx_audio_ops_t *pdata =3D dev->dev.platform_data;
+	int id =3D dev->id < 0 ? 0 : dev->id;
=20
 	ret =3D snd_card_create(SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1,
 			      THIS_MODULE, 0, &card);
@@ -200,6 +202,7 @@ static int __devinit pxa2xx_ac97_probe(struct platform_=
device *dev)
 	snprintf(card->longname, sizeof(card->longname),
 		 "%s (%s)", dev->dev.driver->name, card->mixername);
=20
+	snd_ac97_dev_add_pdata(ac97_bus->codec[id], pdata->codec_pdata[id]);
 	snd_card_set_dev(card, &dev->dev);
 	ret =3D snd_card_register(card);
 	if (ret =3D=3D 0) {
diff --git a/sound/pci/ac97/ac97_codec.c b/sound/pci/ac97/ac97_codec.c
index 78288db..476853a 100644
=2D-- a/sound/pci/ac97/ac97_codec.c
+++ b/sound/pci/ac97/ac97_codec.c
@@ -1922,6 +1922,13 @@ static void ac97_device_release(struct device * dev)
 {
 }
=20
+/* add platform_data to the ac97 device */
+void snd_ac97_dev_add_pdata(struct snd_ac97 *ac97, void *data)
+{
+	ac97->dev.platform_data =3D data;
+}
+EXPORT_SYMBOL_GPL(snd_ac97_dev_add_pdata);
+
 /* register ac97 codec to bus */
 static int snd_ac97_dev_register(struct snd_device *device)
 {
diff --git a/sound/soc/pxa/pxa2xx-ac97.c b/sound/soc/pxa/pxa2xx-ac97.c
index d9c94d7..dea18ee 100644
=2D-- a/sound/soc/pxa/pxa2xx-ac97.c
+++ b/sound/soc/pxa/pxa2xx-ac97.c
@@ -22,6 +22,7 @@
 #include <mach/hardware.h>
 #include <mach/regs-ac97.h>
 #include <mach/dma.h>
+#include <mach/audio.h>
=20
 #include "pxa2xx-pcm.h"
 #include "pxa2xx-ac97.h"
@@ -241,9 +242,13 @@ EXPORT_SYMBOL_GPL(soc_ac97_ops);
 static int __devinit pxa2xx_ac97_dev_probe(struct platform_device *pdev)
 {
 	int i;
+	pxa2xx_audio_ops_t *pdata =3D pdev->dev.platform_data;
=20
=2D	for (i =3D 0; i < ARRAY_SIZE(pxa_ac97_dai); i++)
+	for (i =3D 0; i < ARRAY_SIZE(pxa_ac97_dai); i++) {
 		pxa_ac97_dai[i].dev =3D &pdev->dev;
+		pxa_ac97_dai[i].ac97_pdata =3D pdata->codec_pdata
+					[pdev->id < 0 ? 0 : pdev->id];
+	}
=20
 	/* Punt most of the init to the SoC probe; we may need the machine
 	 * driver to do interesting things with the clocking to get us up
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 1d70829..0b12fe5 100644
=2D-- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1381,8 +1381,11 @@ int snd_soc_init_card(struct snd_soc_device *socdev)
 				continue;
 			}
 		}
=2D		if (card->dai_link[i].codec_dai->ac97_control)
+		if (card->dai_link[i].codec_dai->ac97_control) {
 			ac97 =3D 1;
+			codec->ac97->dev.platform_data =3D
+				card->dai_link[i].cpu_dai->ac97_pdata;
+		}
 	}
 	snprintf(codec->card->shortname, sizeof(codec->card->shortname),
 		 "%s",  card->name);
=2D-=20
1.6.3.3


--Boundary-00=_qGdZKEllDjzV5l9
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_qGdZKEllDjzV5l9--
