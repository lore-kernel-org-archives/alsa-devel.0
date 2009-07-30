From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH 2/4] Allow passing platform_data for
	pxa2xx-ac97
Date: Thu, 30 Jul 2009 02:55:01 +0200
Message-ID: <200907300255.01675.marek.vasut@gmail.com>
References: <200907211633.14388.marek.vasut@gmail.com>
	<200907232039.37952.marek.vasut@gmail.com>
	<200907280728.21372.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_l9OcKTj/DE+Dpvf"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f214.google.com (mail-fx0-f214.google.com
	[209.85.220.214])
	by alsa0.perex.cz (Postfix) with ESMTP id 9EA6C10388F
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Jul 2009 02:55:19 +0200 (CEST)
Received: by fxm10 with SMTP id 10so342803fxm.45
	for <alsa-devel@alsa-project.org>; Wed, 29 Jul 2009 17:55:18 -0700 (PDT)
In-Reply-To: <200907280728.21372.marek.vasut@gmail.com>
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
Cc: alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Takashi Iwai <tiwai@suse.de>, Robert Jarzmik <robert.jarzmik@free.fr>, cbou@mail.ru, Eric Miao <eric.y.miao@gmail.com>, avorontsov@ru.mvista.com, dwmw2@infradead.org, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_l9OcKTj/DE+Dpvf
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Dne =C3=9At 28. =C4=8Dervence 2009 07:28:20 Marek Vasut napsal(a):
> Dne =C4=8Ct 23. =C4=8Dervence 2009 20:39:37 Marek Vasut napsal(a):
> > Dne =C4=8Ct 23. =C4=8Dervence 2009 16:16:12 Marek Vasut napsal(a):
> > > Dne =C4=8Ct 23. =C4=8Dervence 2009 12:27:41 Mark Brown napsal(a):
> > > > On Wed, Jul 22, 2009 at 01:02:40PM +0200, Marek Vasut wrote:
> > > > >  	struct snd_ac97_bus *ac97_bus;
> > > > >  	struct snd_ac97_template ac97_template;
> > > > >  	int ret;
> > > > > +	pxa2xx_audio_ops_t *pdata =3D dev->dev.platform_data;
> > > > > +	int id =3D dev->id < 0 ? 0 : dev->id;
> > > >
> > > > dev here is the AC97 controller device - if there's more than one
> > > > AC97 controller in the system they can each have the four child
> > > > devices.  On the other hand, I don't think any of the PXA processors
> > > > have more than one AC97 controller so it'll never actually have any
> > > > impact.
> > > >
> > > > I think the best thing for now is to either warn if anything except
> > > > the primary codec has platform data or change the platform data to
> > > > have a variable something like primary_audio_pdata.  The driver
> > > > doesn't appear to support secondary codecs anyway.
> > >
> > > Ok, here's a fixed patch.
> >
> > Argh, one more iteration here. There was a typo in the previous patch.
> > Sorry.
>
> Hi, well ... any updates ? Eric, is this patch ok with you ?

I made one more revision here as in case the platform_data aren't supplied,=
=20
the kernel obviously crashes.

--Boundary-00=_l9OcKTj/DE+Dpvf
Content-Type: text/x-patch;
  charset="UTF-8";
  name="0001-Allow-passing-platform_data-for-pxa2xx-ac97.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-Allow-passing-platform_data-for-pxa2xx-ac97.patch"

=46rom 207d54244768e94ce0144cba55acf4ae065e6ce0 Mon Sep 17 00:00:00 2001
=46rom: Marek Vasut <marek.vasut@gmail.com>
Date: Tue, 21 Jul 2009 16:22:29 +0200
Subject: [PATCH] Allow passing platform_data for pxa2xx-ac97

This patch adds support for passing platform data to ac97 bus devices
from PXA2xx-AC97 driver..

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
=2D--
 arch/arm/mach-pxa/include/mach/audio.h |    3 +++
 include/sound/ac97_codec.h             |    3 +++
 sound/arm/pxa2xx-ac97.c                |   10 ++++++++++
 sound/soc/pxa/pxa2xx-ac97.c            |   12 +++++++++++-
 4 files changed, 27 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/audio.h b/arch/arm/mach-pxa/inc=
lude/mach/audio.h
index 16eb025..a3449e3 100644
=2D-- a/arch/arm/mach-pxa/include/mach/audio.h
+++ b/arch/arm/mach-pxa/include/mach/audio.h
@@ -3,10 +3,12 @@
=20
 #include <sound/core.h>
 #include <sound/pcm.h>
+#include <sound/ac97_codec.h>
=20
 /*
  * @reset_gpio: AC97 reset gpio (normally gpio113 or gpio95)
  *              a -1 value means no gpio will be used for reset
+ * @codec_pdata: AC97 codec platform_data
=20
  * reset_gpio should only be specified for pxa27x CPUs where a silicon
  * bug prevents correct operation of the reset line. If not specified,
@@ -20,6 +22,7 @@ typedef struct {
 	void (*resume)(void *);
 	void *priv;
 	int reset_gpio;
+	void *codec_pdata[AC97_BUS_MAX_DEVICES];
 } pxa2xx_audio_ops_t;
=20
 extern void pxa_set_ac97_info(pxa2xx_audio_ops_t *ops);
diff --git a/include/sound/ac97_codec.h b/include/sound/ac97_codec.h
index 9b1c098..3dae3f7 100644
=2D-- a/include/sound/ac97_codec.h
+++ b/include/sound/ac97_codec.h
@@ -32,6 +32,9 @@
 #include "control.h"
 #include "info.h"
=20
+/* maximum number of devices on the AC97 bus */
+#define	AC97_BUS_MAX_DEVICES	4
+
 /*
  *  AC'97 codec registers
  */
diff --git a/sound/arm/pxa2xx-ac97.c b/sound/arm/pxa2xx-ac97.c
index c570ebd..6c00ea4 100644
=2D-- a/sound/arm/pxa2xx-ac97.c
+++ b/sound/arm/pxa2xx-ac97.c
@@ -170,6 +170,13 @@ static int __devinit pxa2xx_ac97_probe(struct platform=
_device *dev)
 	struct snd_ac97_bus *ac97_bus;
 	struct snd_ac97_template ac97_template;
 	int ret;
+	pxa2xx_audio_ops_t *pdata =3D dev->dev.platform_data;
+
+	if (dev->id >=3D 0) {
+		dev_err(&dev->dev, "PXA2xx has only one AC97 port.\n");
+		ret =3D -ENXIO;
+		goto err_dev;
+	}
=20
 	ret =3D snd_card_create(SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1,
 			      THIS_MODULE, 0, &card);
@@ -200,6 +207,8 @@ static int __devinit pxa2xx_ac97_probe(struct platform_=
device *dev)
 	snprintf(card->longname, sizeof(card->longname),
 		 "%s (%s)", dev->dev.driver->name, card->mixername);
=20
+	if (pdata && pdata->codec_data)
+		snd_ac97_dev_add_pdata(ac97_bus->codec[0], pdata->codec_pdata);
 	snd_card_set_dev(card, &dev->dev);
 	ret =3D snd_card_register(card);
 	if (ret =3D=3D 0) {
@@ -212,6 +221,7 @@ err_remove:
 err:
 	if (card)
 		snd_card_free(card);
+err_dev:
 	return ret;
 }
=20
diff --git a/sound/soc/pxa/pxa2xx-ac97.c b/sound/soc/pxa/pxa2xx-ac97.c
index d9c94d7..7330e5c 100644
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
@@ -241,9 +242,18 @@ EXPORT_SYMBOL_GPL(soc_ac97_ops);
 static int __devinit pxa2xx_ac97_dev_probe(struct platform_device *pdev)
 {
 	int i;
+	pxa2xx_audio_ops_t *pdata =3D pdev->dev.platform_data;
=20
=2D	for (i =3D 0; i < ARRAY_SIZE(pxa_ac97_dai); i++)
+	if (pdev->id >=3D 0) {
+		dev_err(&pdev->dev, "PXA2xx has only one AC97 port.\n");
+		return -ENXIO;
+	}
+
+	for (i =3D 0; i < ARRAY_SIZE(pxa_ac97_dai); i++) {
 		pxa_ac97_dai[i].dev =3D &pdev->dev;
+		if (pdata && pdata->codec_pdata)
+			pxa_ac97_dai[i].ac97_pdata =3D pdata->codec_pdata;
+	}
=20
 	/* Punt most of the init to the SoC probe; we may need the machine
 	 * driver to do interesting things with the clocking to get us up
=2D-=20
1.6.3.3


--Boundary-00=_l9OcKTj/DE+Dpvf
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_l9OcKTj/DE+Dpvf--
