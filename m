From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8753: mark expected switch
	fall-throughs" to the asoc tree
Date: Wed, 08 Nov 2017 21:31:22 +0000
Message-ID: <E1eCXwQ-0005H2-4h@debutante>
References: <2a3113ceca1b3f70258486038ed93cfbed70741c.1510170034.git.garsilva@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 50AF526767F
 for <alsa-devel@alsa-project.org>; Wed,  8 Nov 2017 22:31:44 +0100 (CET)
In-Reply-To: <2a3113ceca1b3f70258486038ed93cfbed70741c.1510170034.git.garsilva@embeddedor.com>
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

   ASoC: wm8753: mark expected switch fall-throughs

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

>From b0e92b515e2cbcad923ee1211f59c4b62e94ee37 Mon Sep 17 00:00:00 2001
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Date: Wed, 8 Nov 2017 14:04:31 -0600
Subject: [PATCH] ASoC: wm8753: mark expected switch fall-throughs

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 146568
Addresses-Coverity-ID: 146569
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8753.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index d05d76e79c70..0271a5253bd3 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -971,7 +971,7 @@ static int wm8753_pcm_set_dai_fmt(struct snd_soc_codec *codec,
 	case SND_SOC_DAIFMT_CBS_CFS:
 		break;
 	case SND_SOC_DAIFMT_CBM_CFM:
-		ioctl |= 0x2;
+		ioctl |= 0x2; /* fall through */
 	case SND_SOC_DAIFMT_CBM_CFS:
 		voice |= 0x0040;
 		break;
@@ -1096,7 +1096,7 @@ static int wm8753_i2s_set_dai_fmt(struct snd_soc_codec *codec,
 	case SND_SOC_DAIFMT_CBS_CFS:
 		break;
 	case SND_SOC_DAIFMT_CBM_CFM:
-		ioctl |= 0x1;
+		ioctl |= 0x1; /* fall through */
 	case SND_SOC_DAIFMT_CBM_CFS:
 		hifi |= 0x0040;
 		break;
-- 
2.15.0
