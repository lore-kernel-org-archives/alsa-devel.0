From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5645: Prevent the weird sound of the
	headphone while rebooting" to the asoc tree
Date: Mon, 05 Oct 2015 16:11:07 +0100
Message-ID: <E1Zj7Pv-0000us-UW@finisterre>
References: <1444044857-21433-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B1B0C260694
 for <alsa-devel@alsa-project.org>; Mon,  5 Oct 2015 17:11:24 +0200 (CEST)
In-Reply-To: <1444044857-21433-1-git-send-email-oder_chiou@realtek.com>
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

   ASoC: rt5645: Prevent the weird sound of the headphone while rebooting

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

>From a2c026cfec3fb84375785dd2d6ec80bd60c5120e Mon Sep 17 00:00:00 2001
From: Oder Chiou <oder_chiou@realtek.com>
Date: Mon, 5 Oct 2015 19:34:16 +0800
Subject: [PATCH] ASoC: rt5645: Prevent the weird sound of the headphone while
 rebooting

The patch adds the codec reset setting in the shutdown function to prevent
the weird sound of the headphone happened by rebooting.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5645.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 66b7332e..cd1a4ec 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3514,6 +3514,8 @@ static void rt5645_i2c_shutdown(struct i2c_client *i2c)
 		RT5645_CBJ_MN_JD);
 	regmap_update_bits(rt5645->regmap, RT5645_IN1_CTRL1, RT5645_CBJ_BST1_EN,
 		0);
+	msleep(20);
+	regmap_write(rt5645->regmap, RT5645_RESET, 0);
 }
 
 static struct i2c_driver rt5645_i2c_driver = {
-- 
2.5.0
