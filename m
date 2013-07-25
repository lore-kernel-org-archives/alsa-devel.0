From: Jean-Francois Moine <moinejf@free.fr>
Subject: [PATCH 1/4] ASoc: kirkwood: change the pcm/dma stream data pointer
Date: Thu, 25 Jul 2013 11:13:14 +0200
Message-ID: <20130725111314.66b811bc@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Rob Herring <rob.herring@calxeda.com>, Russell King <rmk+kernel@arm.linux.org.uk>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

In the kirkwood pcm/dma driver, the private stream related data pointer
was hold in the platform drvdata.
As this pointer may be used by other parts of the audio subsystem,
this patch uses the substream runtime private data pointer instead.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 sound/soc/kirkwood/kirkwood-dma.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/sound/soc/kirkwood/kirkwood-dma.c b/sound/soc/kirkwood/kir=
kwood-dma.c
index a9f1453..cef5277 100644
--- a/sound/soc/kirkwood/kirkwood-dma.c
+++ b/sound/soc/kirkwood/kirkwood-dma.c
@@ -127,10 +127,9 @@ static int kirkwood_dma_open(struct snd_pcm_substr=
eam *substream)
 	int err;
 	struct snd_pcm_runtime *runtime =3D substream->runtime;
 	struct snd_soc_pcm_runtime *soc_runtime =3D substream->private_data;
-	struct snd_soc_platform *platform =3D soc_runtime->platform;
 	struct snd_soc_dai *cpu_dai =3D soc_runtime->cpu_dai;
 	struct kirkwood_dma_data *priv;
-	struct kirkwood_dma_priv *prdata =3D snd_soc_platform_get_drvdata(pla=
tform);
+	struct kirkwood_dma_priv *prdata =3D runtime->private_data;
 	const struct mbus_dram_target_info *dram;
 	unsigned long addr;
=20
@@ -171,7 +170,7 @@ static int kirkwood_dma_open(struct snd_pcm_substre=
am *substream)
 			return -EBUSY;
 		}
=20
-		snd_soc_platform_set_drvdata(platform, prdata);
+		runtime->private_data =3D prdata;
=20
 		/*
 		 * Enable Error interrupts. We're only ack'ing them but
@@ -199,8 +198,7 @@ static int kirkwood_dma_close(struct snd_pcm_substr=
eam *substream)
 {
 	struct snd_soc_pcm_runtime *soc_runtime =3D substream->private_data;
 	struct snd_soc_dai *cpu_dai =3D soc_runtime->cpu_dai;
-	struct snd_soc_platform *platform =3D soc_runtime->platform;
-	struct kirkwood_dma_priv *prdata =3D snd_soc_platform_get_drvdata(pla=
tform);
+	struct kirkwood_dma_priv *prdata =3D substream->runtime->private_data=
;
 	struct kirkwood_dma_data *priv;
=20
 	priv =3D snd_soc_dai_get_dma_data(cpu_dai, substream);
@@ -217,7 +215,7 @@ static int kirkwood_dma_close(struct snd_pcm_substr=
eam *substream)
 		writel(0, priv->io + KIRKWOOD_ERR_MASK);
 		free_irq(priv->irq, prdata);
 		kfree(prdata);
-		snd_soc_platform_set_drvdata(platform, NULL);
+		substream->runtime->private_data =3D NULL;
 	}
=20
 	return 0;
--=20
1.8.3.2



--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
