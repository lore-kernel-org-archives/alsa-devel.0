From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH] Allow passing platform_data to devices
	attached to AC97 bus
Date: Tue, 21 Jul 2009 21:51:05 +0200
Message-ID: <200907212151.05301.marek.vasut@gmail.com>
References: <200907211633.14388.marek.vasut@gmail.com>
	<200907211740.01287.marek.vasut@gmail.com>
	<20090721183056.GB28955@sirena.org.uk>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_pwhZKkh0ueGb1oY"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f226.google.com (mail-bw0-f226.google.com
	[209.85.218.226])
	by alsa0.perex.cz (Postfix) with ESMTP id 394AA1037F1
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Jul 2009 21:51:25 +0200 (CEST)
Received: by bwz26 with SMTP id 26so1977753bwz.32
	for <alsa-devel@alsa-project.org>; Tue, 21 Jul 2009 12:51:24 -0700 (PDT)
In-Reply-To: <20090721183056.GB28955@sirena.org.uk>
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
Cc: Takashi Iwai <tiwai@suse.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_pwhZKkh0ueGb1oY
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Dne =C3=9At 21. =C4=8Dervence 2009 20:30:56 Mark Brown napsal(a):
> On Tue, Jul 21, 2009 at 05:40:01PM +0200, Marek Vasut wrote:
> > Dne ??t 21. ??ervence 2009 17:16:07 Takashi Iwai napsal(a):
> >
> > +/* AC97 platform_data adding function */
> > +inline void snd_ac97_dev_add_pdata(struct snd_ac97 *ac97, void *data);
> > +
>
> I think Takashi asked for this to be done as an inline?  I tend to agree
> with him.

Ok, this one should be better then? Mark, thanks for guiding me :-)

--Boundary-00=_pwhZKkh0ueGb1oY
Content-Type: text/x-patch;
  charset="UTF-8";
  name="0001-Allow-passing-platform_data-to-devices-attached-to-A.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-Allow-passing-platform_data-to-devices-attached-to-A.patch"

=46rom 082f09b9f3c1bbf3240610dc89baba33d47787b7 Mon Sep 17 00:00:00 2001
=46rom: Marek Vasut <marek.vasut@gmail.com>
Date: Tue, 21 Jul 2009 16:22:29 +0200
Subject: [PATCH] Allow passing platform_data to devices attached to AC97 bus

This patch allows passing platform_data to devices attached to AC97 bus
(like touchscreens, battery measurement chips ...).

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
=2D--
 include/sound/ac97_codec.h |    6 ++++++
 include/sound/soc-dai.h    |    1 +
 sound/soc/soc-core.c       |    5 ++++-
 3 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/include/sound/ac97_codec.h b/include/sound/ac97_codec.h
index 251fc1c..702f90d 100644
=2D-- a/include/sound/ac97_codec.h
+++ b/include/sound/ac97_codec.h
@@ -642,4 +642,10 @@ int snd_ac97_pcm_double_rate_rules(struct snd_pcm_runt=
ime *runtime);
 /* ad hoc AC97 device driver access */
 extern struct bus_type ac97_bus_type;
=20
+/* AC97 platform_data adding function */
+inline void snd_ac97_dev_add_pdata(struct snd_ac97 *ac97, void *data)
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


--Boundary-00=_pwhZKkh0ueGb1oY
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_pwhZKkh0ueGb1oY--
