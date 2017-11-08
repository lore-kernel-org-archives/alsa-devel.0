From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8994: mark expected switch
	fall-throughs" to the asoc tree
Date: Wed, 08 Nov 2017 21:31:14 +0000
Message-ID: <E1eCXwI-0005Ew-3o@debutante>
References: <94d7abf866dbcc4052a36ca14e53f1ff8aa30e83.1510170034.git.garsilva@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 336EB267694
 for <alsa-devel@alsa-project.org>; Wed,  8 Nov 2017 22:32:08 +0100 (CET)
In-Reply-To: <94d7abf866dbcc4052a36ca14e53f1ff8aa30e83.1510170034.git.garsilva@embeddedor.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, patches@opensource.cirrus.com, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "Gustavo A. R. Silva" <garsilva@embeddedor.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm8994: mark expected switch fall-throughs

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 9d94305a7df4ce6af5070baa92cc784786b748b9 Mon Sep 17 00:00:00 2001
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Date: Wed, 8 Nov 2017 14:04:43 -0600
Subject: [PATCH] ASoC: wm8994: mark expected switch fall-throughs

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 402005
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8994.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 3896523b71e9..f91b49e1ece3 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -860,6 +860,7 @@ static void vmid_reference(struct snd_soc_codec *codec)
 		switch (wm8994->vmid_mode) {
 		default:
 			WARN_ON(NULL == "Invalid VMID mode");
+			/* fall through */
 		case WM8994_VMID_NORMAL:
 			/* Startup bias, VMID ramp & buffer */
 			snd_soc_update_bits(codec, WM8994_ANTIPOP_2,
@@ -2654,6 +2655,7 @@ static int wm8994_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	case SND_SOC_DAIFMT_DSP_B:
 		aif1 |= WM8994_AIF1_LRCLK_INV;
 		lrclk |= WM8958_AIF1_LRCLK_INV;
+		/* fall through */
 	case SND_SOC_DAIFMT_DSP_A:
 		aif1 |= 0x18;
 		break;
-- 
2.15.0
