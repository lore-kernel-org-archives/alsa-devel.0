From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH] Allow passing platform_data to devices
	attached to AC97 bus
Date: Tue, 21 Jul 2009 17:41:26 +0200
Message-ID: <200907211741.27174.marek.vasut@gmail.com>
References: <200907211633.14388.marek.vasut@gmail.com>
	<20090721145323.GA8991@rakim.wolfsonmicro.main>
	<s5hd47u2hjc.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_nGeZKvWcICxeFF4"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f226.google.com (mail-bw0-f226.google.com
	[209.85.218.226])
	by alsa0.perex.cz (Postfix) with ESMTP id 620F124388
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Jul 2009 17:41:46 +0200 (CEST)
Received: by bwz26 with SMTP id 26so1822452bwz.32
	for <alsa-devel@alsa-project.org>; Tue, 21 Jul 2009 08:41:46 -0700 (PDT)
In-Reply-To: <s5hd47u2hjc.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Eric Miao <eric.y.miao@gmail.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_nGeZKvWcICxeFF4
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Dne =C3=9At 21. =C4=8Dervence 2009 17:16:07 Takashi Iwai napsal(a):
> At Tue, 21 Jul 2009 15:53:23 +0100,
>
> Mark Brown wrote:
> > On Tue, Jul 21, 2009 at 04:50:26PM +0200, Takashi Iwai wrote:
> > > Marek Vasut wrote:
> > > >  	int ret;
> > > > +	pxa2xx_audio_ops_t *pdata =3D dev->dev.platform_data;
> > >
> > > Use the get function.
> >
> > There's no such function in mainline right now.  However, apropos of
> > something else I submitted a patch adding that to the driver core - it's
> > been merged for 2.6.32 but won't be available in ALSA until after the
> > next merge window.  The function is dev_get_platdata().
>
> Ah, right.  This can be fixed later, then.
>
> > > Also, at the next time, add Russell or linux-arm to Cc so that he
> > > knows at least that a file in arch/arm will be changed.
> >
> > Ideally split things into two separate patches.
>
> Agreed.
>
>
> Takashi

And this patch adds changes to pxa2xx-ac97. Also, I fixed the magic constan=
t.

--Boundary-00=_nGeZKvWcICxeFF4
Content-Type: text/x-patch;
  charset="UTF-8";
  name="0002-Allow-passing-platform_data-for-pxa2xx-ac97.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0002-Allow-passing-platform_data-for-pxa2xx-ac97.patch"

=46rom 97c0a179284cc8ea1419e1cd1857159bb9bc194b Mon Sep 17 00:00:00 2001
=46rom: Marek Vasut <marek.vasut@gmail.com>
Date: Tue, 21 Jul 2009 16:22:29 +0200
Subject: [PATCH 2/2] Allow passing platform_data for pxa2xx-ac97

This patch adds support for passing platform data to ac97 bus devices
from PXA2xx-AC97 driver..

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
=2D--
 arch/arm/mach-pxa/include/mach/audio.h |    3 +++
 include/sound/ac97_codec.h             |    3 +++
 sound/arm/pxa2xx-ac97.c                |    3 +++
 sound/soc/pxa/pxa2xx-ac97.c            |    7 ++++++-
 4 files changed, 15 insertions(+), 1 deletions(-)

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
index aeaa40c..e5c36c9 100644
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
=2D-=20
1.6.3.3


--Boundary-00=_nGeZKvWcICxeFF4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_nGeZKvWcICxeFF4--
