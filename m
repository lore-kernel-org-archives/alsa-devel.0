From: Denis Carikli <denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>
Subject: [PATCHv7][ 1/5] ASoC: eukrea-tlv320: Use dev_err instead of pr_err.
Date: Thu, 24 Oct 2013 14:13:48 +0200
Message-ID: <1382616832-23593-1-git-send-email-denis@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, =?UTF-8?q?Eric=20B=C3=A9nard?= <eric-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Denis Carikli <denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

It also contains a minor style cleanup.

Cc: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Cc: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Eric B=C3=A9nard <eric-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Denis Carikli <denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>
---
ChangeLog v6->v7:
- eukrea-tlv320 cleanups are now moved into that patch.
---
 sound/soc/fsl/eukrea-tlv320.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/sound/soc/fsl/eukrea-tlv320.c b/sound/soc/fsl/eukrea-tlv32=
0.c
index 9a4a0ca..5983740 100644
--- a/sound/soc/fsl/eukrea-tlv320.c
+++ b/sound/soc/fsl/eukrea-tlv320.c
@@ -42,7 +42,8 @@ static int eukrea_tlv320_hw_params(struct snd_pcm_sub=
stream *substream,
 				  SND_SOC_DAIFMT_NB_NF |
 				  SND_SOC_DAIFMT_CBM_CFM);
 	if (ret) {
-		pr_err("%s: failed set cpu dai format\n", __func__);
+		dev_err(cpu_dai->dev,
+			"Failed to set the cpu dai format.\n");
 		return ret;
 	}
=20
@@ -50,14 +51,16 @@ static int eukrea_tlv320_hw_params(struct snd_pcm_s=
ubstream *substream,
 				  SND_SOC_DAIFMT_NB_NF |
 				  SND_SOC_DAIFMT_CBM_CFM);
 	if (ret) {
-		pr_err("%s: failed set codec dai format\n", __func__);
+		dev_err(cpu_dai->dev,
+			"Failed to set the codec format.\n");
 		return ret;
 	}
=20
 	ret =3D snd_soc_dai_set_sysclk(codec_dai, 0,
 				     CODEC_CLOCK, SND_SOC_CLOCK_OUT);
 	if (ret) {
-		pr_err("%s: failed setting codec sysclk\n", __func__);
+		dev_err(cpu_dai->dev,
+			"Failed to set the codec sysclk.\n");
 		return ret;
 	}
 	snd_soc_dai_set_tdm_slot(cpu_dai, 0xffffffc, 0xffffffc, 2, 0);
@@ -65,7 +68,8 @@ static int eukrea_tlv320_hw_params(struct snd_pcm_sub=
stream *substream,
 	ret =3D snd_soc_dai_set_sysclk(cpu_dai, IMX_SSP_SYS_CLK, 0,
 				SND_SOC_CLOCK_IN);
 	if (ret) {
-		pr_err("can't set CPU system clock IMX_SSP_SYS_CLK\n");
+		dev_err(cpu_dai->dev,
+			"Can't set the IMX_SSP_SYS_CLK CPU system clock.\n");
 		return ret;
 	}
=20
@@ -155,7 +159,8 @@ static struct platform_driver eukrea_tlv320_driver =
=3D {
 		.owner =3D THIS_MODULE,
 	},
 	.probe =3D eukrea_tlv320_probe,
-	.remove =3D eukrea_tlv320_remove,};
+	.remove =3D eukrea_tlv320_remove,
+};
=20
 module_platform_driver(eukrea_tlv320_driver);
=20
--=20
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
