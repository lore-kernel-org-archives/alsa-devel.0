From: Marek Vasut <marek.vasut@gmail.com>
Subject: [PATCH 1/4] Allow passing platform_data to devices
	attached to AC97 bus
Date: Wed, 22 Jul 2009 12:59:13 +0200
Message-ID: <200907221259.13644.marek.vasut@gmail.com>
References: <200907211633.14388.marek.vasut@gmail.com>
	<200907212151.05301.marek.vasut@gmail.com>
	<20090722104029.GC21171@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_BEvZKna0/PLXW7C"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f226.google.com (mail-bw0-f226.google.com
	[209.85.218.226])
	by alsa0.perex.cz (Postfix) with ESMTP id CF95E10389F
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Jul 2009 12:59:32 +0200 (CEST)
Received: by bwz26 with SMTP id 26so109615bwz.32
	for <alsa-devel@alsa-project.org>; Wed, 22 Jul 2009 03:59:32 -0700 (PDT)
In-Reply-To: <20090722104029.GC21171@rakim.wolfsonmicro.main>
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

--Boundary-00=_BEvZKna0/PLXW7C
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Dne St 22. =C4=8Dervence 2009 12:40:29 Mark Brown napsal(a):
> On Tue, Jul 21, 2009 at 09:51:05PM +0200, Marek Vasut wrote:
> > Ok, this one should be better then? Mark, thanks for guiding me :-)
>
> There's so many patches flying around here that I've completely lost
> track of what the current state of play is.  Could you please repost as
> a new patch series, ideally as a normal submission with meaningful per
> patch subject headers.


--Boundary-00=_BEvZKna0/PLXW7C
Content-Type: text/x-patch;
  charset="UTF-8";
  name="0001-Allow-passing-platform_data-to-devices-attached-to-A.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-Allow-passing-platform_data-to-devices-attached-to-A.patch"

=46rom 5ed7859b282c23c2f98167ef3f821625ee8907aa Mon Sep 17 00:00:00 2001
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


--Boundary-00=_BEvZKna0/PLXW7C
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_BEvZKna0/PLXW7C--
