From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5645: polling jd status in all
	conditions" to the asoc tree
Date: Thu, 05 May 2016 16:56:17 +0100
Message-ID: <E1ayLdR-0004iH-Lr@debutante>
References: <1462418011-20974-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 076112668C9
 for <alsa-devel@alsa-project.org>; Thu,  5 May 2016 17:56:30 +0200 (CEST)
In-Reply-To: <1462418011-20974-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, john.lin@realtek.com, broonie@kernel.org, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5645: polling jd status in all conditions

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

>From 381437dd0bd590902320b97e6512792b075becd4 Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Thu, 5 May 2016 11:13:31 +0800
Subject: [PATCH] ASoC: rt5645: polling jd status in all conditions

We only polling jd status when rt5645->pdata.jd_invert is true.
However, it should be done at all time since there will be no
interrupt for jd if we press a headset button and remove the
headset at the same time.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5645.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index dff706ac7895..3c6594da6c9c 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3286,10 +3286,8 @@ static void rt5645_jack_detect_work(struct work_struct *work)
 		if (btn_type == 0)/* button release */
 			report =  rt5645->jack_type;
 		else {
-			if (rt5645->pdata.jd_invert) {
-				mod_timer(&rt5645->btn_check_timer,
-					msecs_to_jiffies(100));
-			}
+			mod_timer(&rt5645->btn_check_timer,
+				msecs_to_jiffies(100));
 		}
 
 		break;
@@ -3816,9 +3814,9 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 	if (rt5645->pdata.jd_invert) {
 		regmap_update_bits(rt5645->regmap, RT5645_IRQ_CTRL2,
 			RT5645_JD_1_1_MASK, RT5645_JD_1_1_INV);
-		setup_timer(&rt5645->btn_check_timer,
-			rt5645_btn_check_callback, (unsigned long)rt5645);
 	}
+	setup_timer(&rt5645->btn_check_timer,
+		rt5645_btn_check_callback, (unsigned long)rt5645);
 
 	INIT_DELAYED_WORK(&rt5645->jack_detect_work, rt5645_jack_detect_work);
 	INIT_DELAYED_WORK(&rt5645->rcclock_work, rt5645_rcclock_work);
-- 
2.8.1
