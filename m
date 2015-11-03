From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt298: fix remove unnedded clk setting"
	to the asoc tree
Date: Tue, 03 Nov 2015 15:15:54 +0000
Message-ID: <E1ZtdJS-0003ql-4U@debutante>
References: <1445415499-29200-2-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 461F12606D7
 for <alsa-devel@alsa-project.org>; Tue,  3 Nov 2015 16:16:02 +0100 (CET)
In-Reply-To: <1445415499-29200-2-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt298: fix remove unnedded clk setting

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

>From 38b409d66fa84e91afd5340fd772609185b20fa9 Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Wed, 21 Oct 2015 16:18:19 +0800
Subject: [PATCH] ASoC: rt298: fix remove unnedded clk setting

The bit is no longer present. So remove it.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt298.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/rt298.c b/sound/soc/codecs/rt298.c
index ef8e23aab2d3..f00fe02d34ab 100644
--- a/sound/soc/codecs/rt298.c
+++ b/sound/soc/codecs/rt298.c
@@ -856,8 +856,6 @@ static int rt298_set_dai_sysclk(struct snd_soc_dai *dai,
 		snd_soc_update_bits(codec,
 			RT298_I2S_CTRL2, 0x0100, 0x0100);
 		snd_soc_update_bits(codec,
-			RT298_PLL_CTRL, 0x4, 0x4);
-		snd_soc_update_bits(codec,
 			RT298_PLL_CTRL1, 0x20, 0x0);
 	}
 
-- 
2.6.2
