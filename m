From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH] Allow passing platform_data to devices
	attached to AC97 bus
Date: Tue, 21 Jul 2009 23:53:37 +0200
Message-ID: <200907212353.37737.marek.vasut@gmail.com>
References: <200907211633.14388.marek.vasut@gmail.com>
	<200907212224.22131.marek.vasut@gmail.com>
	<s5hvdllvjk8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_hjjZKsN8kPD6kQn"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f226.google.com (mail-fx0-f226.google.com
	[209.85.220.226])
	by alsa0.perex.cz (Postfix) with ESMTP id 4C3F9103826
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Jul 2009 23:53:59 +0200 (CEST)
Received: by fxm26 with SMTP id 26so3126916fxm.32
	for <alsa-devel@alsa-project.org>; Tue, 21 Jul 2009 14:53:58 -0700 (PDT)
In-Reply-To: <s5hvdllvjk8.wl%tiwai@suse.de>
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
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_hjjZKsN8kPD6kQn
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Dne =C3=9At 21. =C4=8Dervence 2009 22:59:35 Takashi Iwai napsal(a):
> At Tue, 21 Jul 2009 22:24:21 +0200,
>
> Marek Vasut wrote:
> > From 082f09b9f3c1bbf3240610dc89baba33d47787b7 Mon Sep 17 00:00:00 2001
> > From: Marek Vasut <marek.vasut@gmail.com>
> > Date: Tue, 21 Jul 2009 16:22:29 +0200
> > Subject: [PATCH 1/5] Allow passing platform_data to devices attached to
> > AC97 bus
> >
> > This patch allows passing platform_data to devices attached to AC97 bus
> > (like touchscreens, battery measurement chips ...).
> >
> > Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> > ---
> >  include/sound/ac97_codec.h |    6 ++++++
> >  include/sound/soc-dai.h    |    1 +
> >  sound/soc/soc-core.c       |    5 ++++-
> >  3 files changed, 11 insertions(+), 1 deletions(-)
> >
> > diff --git a/include/sound/ac97_codec.h b/include/sound/ac97_codec.h
> > index 251fc1c..702f90d 100644
> > --- a/include/sound/ac97_codec.h
> > +++ b/include/sound/ac97_codec.h
> > @@ -642,4 +642,10 @@ int snd_ac97_pcm_double_rate_rules(struct
> > snd_pcm_runtime *runtime); /* ad hoc AC97 device driver access */
> >  extern struct bus_type ac97_bus_type;
> >
> > +/* AC97 platform_data adding function */
> > +static inline void snd_ac97_dev_add_pdata(struct snd_ac97 *ac97, void
> > *data) +{
> > +	ac97->dev.platform_data =3D data;
> > +}
> > +
> >  #endif /* __SOUND_AC97_CODEC_H */
> > diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
> > index 352d7ee..0d65a03 100644
> > --- a/include/sound/soc-dai.h
> > +++ b/include/sound/soc-dai.h
> > @@ -179,6 +179,7 @@ struct snd_soc_dai {
> >  	int ac97_control;
> >
> >  	struct device *dev;
> > +	void *ac97_pdata;	/* platform_data for the ac97 codec */
> >
> >  	/* DAI callbacks */
> >  	int (*probe)(struct platform_device *pdev,
> > diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> > index 1d70829..0b12fe5 100644
> > --- a/sound/soc/soc-core.c
> > +++ b/sound/soc/soc-core.c
> > @@ -1381,8 +1381,11 @@ int snd_soc_init_card(struct snd_soc_device
> > *socdev) continue;
> >  			}
> >  		}
> > -		if (card->dai_link[i].codec_dai->ac97_control)
> > +		if (card->dai_link[i].codec_dai->ac97_control) {
> >  			ac97 =3D 1;
> > +			codec->ac97->dev.platform_data =3D
> > +				card->dai_link[i].cpu_dai->ac97_pdata;
>
> Any reason not to use the newly added snd_ac97_dev_add_pdata()?

hm, that's true, one more iteration then.
>
>
> thanks,
>
> Takashi


--Boundary-00=_hjjZKsN8kPD6kQn
Content-Type: text/x-patch;
  charset="UTF-8";
  name="0001-Allow-passing-platform_data-to-devices-attached-to-A.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-Allow-passing-platform_data-to-devices-attached-to-A.patch"

=46rom 776233642ae196ee1998791ec69bd20d7725ecca Mon Sep 17 00:00:00 2001
=46rom: Marek Vasut <marek.vasut@gmail.com>
Date: Tue, 21 Jul 2009 16:22:29 +0200
Subject: [PATCH 1/4] Allow passing platform_data to devices attached to AC9=
7 bus

This patch allows passing platform_data to devices attached to AC97 bus
(like touchscreens, battery measurement chips ...).

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
=2D--
 include/sound/ac97_codec.h |    6 ++++++
 include/sound/soc-dai.h    |    1 +
 sound/soc/soc-core.c       |    6 +++++-
 3 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/include/sound/ac97_codec.h b/include/sound/ac97_codec.h
index 251fc1c..9b1c098 100644
=2D-- a/include/sound/ac97_codec.h
+++ b/include/sound/ac97_codec.h
@@ -642,4 +642,10 @@ int snd_ac97_pcm_double_rate_rules(struct snd_pcm_runt=
ime *runtime);
 /* ad hoc AC97 device driver access */
 extern struct bus_type ac97_bus_type;
=20
+/* AC97 platform_data adding function */
+static inline void snd_ac97_dev_add_pdata(struct snd_ac97 *ac97, void *dat=
a)
+{
+	ac97->dev.platform_data =3D data;
+}
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
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 1d70829..7cb0917 100644
=2D-- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -28,6 +28,7 @@
 #include <linux/bitops.h>
 #include <linux/debugfs.h>
 #include <linux/platform_device.h>
+#include <sound/ac97_codec.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -1381,8 +1382,11 @@ int snd_soc_init_card(struct snd_soc_device *socdev)
 				continue;
 			}
 		}
=2D		if (card->dai_link[i].codec_dai->ac97_control)
+		if (card->dai_link[i].codec_dai->ac97_control) {
 			ac97 =3D 1;
+			snd_ac97_dev_add_pdata(codec->ac97,
+				card->dai_link[i].cpu_dai->ac97_pdata);
+		}
 	}
 	snprintf(codec->card->shortname, sizeof(codec->card->shortname),
 		 "%s",  card->name);
=2D-=20
1.6.3.3


--Boundary-00=_hjjZKsN8kPD6kQn
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_hjjZKsN8kPD6kQn--
