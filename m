From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5645: Increase the delay time to
	remove the pop sound" to the asoc tree
Date: Wed, 23 Sep 2015 11:00:53 -0700
Message-ID: <E1ZeoLd-0005Rx-3K@finisterre>
References: <1442990130-15801-3-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 68AC6265158
 for <alsa-devel@alsa-project.org>; Wed, 23 Sep 2015 20:01:33 +0200 (CEST)
In-Reply-To: <1442990130-15801-3-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5645: Increase the delay time to remove the pop sound

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

>From 4f4794124e0421b080a0f1f5f1207636ba55eb85 Mon Sep 17 00:00:00 2001
From: Oder Chiou <oder_chiou@realtek.com>
Date: Wed, 23 Sep 2015 14:35:29 +0800
Subject: [PATCH] ASoC: rt5645: Increase the delay time to remove the pop sound

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5645.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 25c34fb..61384ee9 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -1381,7 +1381,7 @@ static void hp_amp_power(struct snd_soc_codec *codec, int on)
 				regmap_write(rt5645->regmap, RT5645_PR_BASE +
 					RT5645_MAMP_INT_REG2, 0xfc00);
 				snd_soc_write(codec, RT5645_DEPOP_M2, 0x1140);
-				mdelay(5);
+				msleep(40);
 				rt5645->hp_on = true;
 			} else {
 				/* depop parameters */
-- 
2.5.0
