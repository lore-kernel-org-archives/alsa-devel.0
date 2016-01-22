From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ab8500: remove the useless 'break'
	after 'return'" to the asoc tree
Date: Fri, 22 Jan 2016 18:26:54 +0000
Message-ID: <E1aMgQA-0004Cw-2h@debutante>
References: <1453172746-8110-1-git-send-email-lixiubo@cmss.chinamobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 876E9260541
 for <alsa-devel@alsa-project.org>; Fri, 22 Jan 2016 19:26:59 +0100 (CET)
In-Reply-To: <1453172746-8110-1-git-send-email-lixiubo@cmss.chinamobile.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Xiubo Li <lixiubo@cmss.chinamobile.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: ab8500: remove the useless 'break' after 'return'

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 22363e758770fa24edcc67ba33326f007bcd66a8 Mon Sep 17 00:00:00 2001
From: Xiubo Li <lixiubo@cmss.chinamobile.com>
Date: Tue, 19 Jan 2016 11:13:12 +0800
Subject: [PATCH] ASoC: ab8500: remove the useless 'break' after 'return'

'break' here is not useful after 'return' or 'goto'.

Signed-off-by: Xiubo Li <lixiubo@cmss.chinamobile.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ab8500-codec.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/ab8500-codec.c b/sound/soc/codecs/ab8500-codec.c
index affb192238a4..b6820a1f16c7 100644
--- a/sound/soc/codecs/ab8500-codec.c
+++ b/sound/soc/codecs/ab8500-codec.c
@@ -2134,7 +2134,6 @@ static int ab8500_codec_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 			"%s: ERROR: Unsupporter master mask 0x%x\n",
 			__func__, fmt & SND_SOC_DAIFMT_MASTER_MASK);
 		return -EINVAL;
-		break;
 	}
 
 	snd_soc_update_bits(codec, AB8500_DIGIFCONF3, mask, val);
-- 
2.7.0.rc3
