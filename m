From: Jean-Francois Moine <moinejf@free.fr>
Subject: [PATCH 3/4] ASoc: kirkwood: merge kirkwood-i2c and kirkwood-dma
Date: Thu, 25 Jul 2013 11:14:28 +0200
Message-ID: <20130725111428.419ee278@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Rob Herring <rob.herring@calxeda.com>, Russell King <rmk+kernel@arm.linux.org.uk>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

To avoid the declaration of a 'kirkwood-pcm-audio' device in the DT,
this patch merges the kirkwood-i2c and kirkwood-dma drivers into one
module.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 arch/arm/mach-kirkwood/common.c      |  6 ------
 sound/soc/kirkwood/Kconfig           |  5 -----
 sound/soc/kirkwood/Makefile          |  4 +---
 sound/soc/kirkwood/kirkwood-dma.c    | 30 +---------------------------=
--
 sound/soc/kirkwood/kirkwood-i2s.c    |  5 +++++
 sound/soc/kirkwood/kirkwood-openrd.c |  2 +-
 sound/soc/kirkwood/kirkwood-t5325.c  |  2 +-
 sound/soc/kirkwood/kirkwood.h        |  1 +
 8 files changed, 10 insertions(+), 45 deletions(-)

diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/c=
ommon.c
index e9238b5..fd02f1b 100644
--- a/arch/arm/mach-kirkwood/common.c
+++ b/arch/arm/mach-kirkwood/common.c
@@ -587,15 +587,9 @@ static struct platform_device kirkwood_i2s_device =
=3D {
 	},
 };
=20
-static struct platform_device kirkwood_pcm_device =3D {
-	.name		=3D "kirkwood-pcm-audio",
-	.id		=3D -1,
-};
-
 void __init kirkwood_audio_init(void)
 {
 	platform_device_register(&kirkwood_i2s_device);
-	platform_device_register(&kirkwood_pcm_device);
 }
=20
 /*********************************************************************=
********
diff --git a/sound/soc/kirkwood/Kconfig b/sound/soc/kirkwood/Kconfig
index c62d715..b6917a7 100644
--- a/sound/soc/kirkwood/Kconfig
+++ b/sound/soc/kirkwood/Kconfig
@@ -6,14 +6,10 @@ config SND_KIRKWOOD_SOC
 	  the Kirkwood I2S interface. You will also need to select the
 	  audio interfaces to support below.
=20
-config SND_KIRKWOOD_SOC_I2S
-	tristate
-
 config SND_KIRKWOOD_SOC_OPENRD
 	tristate "SoC Audio support for Kirkwood Openrd Client"
 	depends on SND_KIRKWOOD_SOC && (MACH_OPENRD_CLIENT || MACH_OPENRD_ULT=
IMATE)
 	depends on I2C
-	select SND_KIRKWOOD_SOC_I2S
 	select SND_SOC_CS42L51
 	help
 	  Say Y if you want to add support for SoC audio on
@@ -22,7 +18,6 @@ config SND_KIRKWOOD_SOC_OPENRD
 config SND_KIRKWOOD_SOC_T5325
 	tristate "SoC Audio support for HP t5325"
 	depends on SND_KIRKWOOD_SOC && MACH_T5325 && I2C
-	select SND_KIRKWOOD_SOC_I2S
 	select SND_SOC_ALC5623
 	help
 	  Say Y if you want to add support for SoC audio on
diff --git a/sound/soc/kirkwood/Makefile b/sound/soc/kirkwood/Makefile
index 3e62ae9..cf22ad3 100644
--- a/sound/soc/kirkwood/Makefile
+++ b/sound/soc/kirkwood/Makefile
@@ -1,8 +1,6 @@
-snd-soc-kirkwood-objs :=3D kirkwood-dma.o
-snd-soc-kirkwood-i2s-objs :=3D kirkwood-i2s.o
+snd-soc-kirkwood-objs :=3D kirkwood-i2s.o kirkwood-dma.o
=20
 obj-$(CONFIG_SND_KIRKWOOD_SOC) +=3D snd-soc-kirkwood.o
-obj-$(CONFIG_SND_KIRKWOOD_SOC_I2S) +=3D snd-soc-kirkwood-i2s.o
=20
 snd-soc-openrd-objs :=3D kirkwood-openrd.o
 snd-soc-t5325-objs :=3D kirkwood-t5325.o
diff --git a/sound/soc/kirkwood/kirkwood-dma.c b/sound/soc/kirkwood/kir=
kwood-dma.c
index cef5277..9f4c595 100644
--- a/sound/soc/kirkwood/kirkwood-dma.c
+++ b/sound/soc/kirkwood/kirkwood-dma.c
@@ -364,36 +364,8 @@ static void kirkwood_dma_free_dma_buffers(struct s=
nd_pcm *pcm)
 	}
 }
=20
-static struct snd_soc_platform_driver kirkwood_soc_platform =3D {
+struct snd_soc_platform_driver kirkwood_soc_platform =3D {
 	.ops		=3D &kirkwood_dma_ops,
 	.pcm_new	=3D kirkwood_dma_new,
 	.pcm_free	=3D kirkwood_dma_free_dma_buffers,
 };
-
-static int kirkwood_soc_platform_probe(struct platform_device *pdev)
-{
-	return snd_soc_register_platform(&pdev->dev, &kirkwood_soc_platform);
-}
-
-static int kirkwood_soc_platform_remove(struct platform_device *pdev)
-{
-	snd_soc_unregister_platform(&pdev->dev);
-	return 0;
-}
-
-static struct platform_driver kirkwood_pcm_driver =3D {
-	.driver =3D {
-			.name =3D "kirkwood-pcm-audio",
-			.owner =3D THIS_MODULE,
-	},
-
-	.probe =3D kirkwood_soc_platform_probe,
-	.remove =3D kirkwood_soc_platform_remove,
-};
-
-module_platform_driver(kirkwood_pcm_driver);
-
-MODULE_AUTHOR("Arnaud Patard <arnaud.patard@rtp-net.org>");
-MODULE_DESCRIPTION("Marvell Kirkwood Audio DMA module");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:kirkwood-pcm-audio");
diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kir=
kwood-i2s.c
index d3e50af..3517784 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -459,6 +459,7 @@ static int kirkwood_i2s_dev_remove(struct platform_=
device *pdev)
 {
 	struct kirkwood_dma_data *priv =3D dev_get_drvdata(&pdev->dev);
=20
+	snd_soc_unregister_platform(&pdev->dev);
 	snd_soc_unregister_component(&pdev->dev);
=20
 	if (!IS_ERR(priv->extclk)) {
@@ -544,6 +545,10 @@ static int kirkwood_i2s_dev_probe(struct platform_=
device *pdev)
 		dev_err(&pdev->dev, "snd_soc_register_component failed\n");
 		goto fail;
 	}
+	err =3D snd_soc_register_platform(&pdev->dev, &kirkwood_soc_platform)=
;;
+	if (err) {
+		dev_err(&pdev->dev, "snd_soc_register_platform failed\n");
+		goto fail;
 	return 0;
=20
 fail:
diff --git a/sound/soc/kirkwood/kirkwood-openrd.c b/sound/soc/kirkwood/=
kirkwood-openrd.c
index b979c71..0fa3082 100644
--- a/sound/soc/kirkwood/kirkwood-openrd.c
+++ b/sound/soc/kirkwood/kirkwood-openrd.c
@@ -55,7 +55,7 @@ static struct snd_soc_dai_link openrd_client_dai[] =3D=
 {
 	.name =3D "CS42L51",
 	.stream_name =3D "CS42L51 HiFi",
 	.cpu_dai_name =3D "kirkwood-i2s",
-	.platform_name =3D "kirkwood-pcm-audio",
+	.platform_name =3D "kirkwood-i2s",
 	.codec_dai_name =3D "cs42l51-hifi",
 	.codec_name =3D "cs42l51-codec.0-004a",
 	.dai_fmt =3D SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBS_CFS,
diff --git a/sound/soc/kirkwood/kirkwood-t5325.c b/sound/soc/kirkwood/k=
irkwood-t5325.c
index 1d0ed6f..f48ebda 100644
--- a/sound/soc/kirkwood/kirkwood-t5325.c
+++ b/sound/soc/kirkwood/kirkwood-t5325.c
@@ -71,7 +71,7 @@ static struct snd_soc_dai_link t5325_dai[] =3D {
 	.name =3D "ALC5621",
 	.stream_name =3D "ALC5621 HiFi",
 	.cpu_dai_name =3D "kirkwood-i2s",
-	.platform_name =3D "kirkwood-pcm-audio",
+	.platform_name =3D "kirkwood-i2s",
 	.codec_dai_name =3D "alc5621-hifi",
 	.codec_name =3D "alc562x-codec.0-001a",
 	.dai_fmt =3D SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBS_CFS,
diff --git a/sound/soc/kirkwood/kirkwood.h b/sound/soc/kirkwood/kirkwoo=
d.h
index 4d92637..f3de119 100644
--- a/sound/soc/kirkwood/kirkwood.h
+++ b/sound/soc/kirkwood/kirkwood.h
@@ -133,4 +133,5 @@ struct kirkwood_dma_data {
 	int burst;
 };
=20
+extern struct snd_soc_platform_driver kirkwood_soc_platform;
 #endif
--=20
1.8.3.2



--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
