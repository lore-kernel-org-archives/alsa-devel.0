From: Jean-Francois Moine <moinejf@free.fr>
Subject: [PATCH] ARM: kirkwood: enable S/PDIF
Date: Tue, 23 Jul 2013 10:23:20 +0200
Message-ID: <20130723102320.56bc4555@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Rob Herring <rob.herring@calxeda.com>, Russell King <rmk+kernel@arm.linux.org.uk>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

This patch enables S/PDIF.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 sound/soc/kirkwood/kirkwood-i2s.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kir=
kwood-i2s.c
index 4c9dad3..ad94c50 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -159,6 +159,7 @@ static int kirkwood_i2s_hw_params(struct snd_pcm_su=
bstream *substream,
 	case SNDRV_PCM_FORMAT_S16_LE:
 		i2s_value |=3D KIRKWOOD_I2S_CTL_SIZE_16;
 		ctl_play =3D KIRKWOOD_PLAYCTL_SIZE_16_C |
+			   KIRKWOOD_PLAYCTL_SPDIF_EN |
 			   KIRKWOOD_PLAYCTL_I2S_EN;
 		ctl_rec =3D KIRKWOOD_RECCTL_SIZE_16_C |
 			  KIRKWOOD_RECCTL_I2S_EN;
@@ -169,6 +170,7 @@ static int kirkwood_i2s_hw_params(struct snd_pcm_su=
bstream *substream,
 	case SNDRV_PCM_FORMAT_S20_3LE:
 		i2s_value |=3D KIRKWOOD_I2S_CTL_SIZE_20;
 		ctl_play =3D KIRKWOOD_PLAYCTL_SIZE_20 |
+			   KIRKWOOD_PLAYCTL_SPDIF_EN |
 			   KIRKWOOD_PLAYCTL_I2S_EN;
 		ctl_rec =3D KIRKWOOD_RECCTL_SIZE_20 |
 			  KIRKWOOD_RECCTL_I2S_EN;
@@ -177,6 +179,7 @@ static int kirkwood_i2s_hw_params(struct snd_pcm_su=
bstream *substream,
 	case SNDRV_PCM_FORMAT_S24_LE:
 		i2s_value |=3D KIRKWOOD_I2S_CTL_SIZE_24;
 		ctl_play =3D KIRKWOOD_PLAYCTL_SIZE_24 |
+			   KIRKWOOD_PLAYCTL_SPDIF_EN |
 			   KIRKWOOD_PLAYCTL_I2S_EN;
 		ctl_rec =3D KIRKWOOD_RECCTL_SIZE_24 |
 			  KIRKWOOD_RECCTL_I2S_EN;

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
