From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5645: set sel_i2s_pre_div1 to 2" to
	the asoc tree
Date: Mon, 09 Jan 2017 20:01:43 +0000
Message-ID: <E1cQg8V-0006xG-SP@debutante>
References: <1482811506-6447-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4FE2E266EE9
 for <alsa-devel@alsa-project.org>; Mon,  9 Jan 2017 21:01:51 +0100 (CET)
In-Reply-To: <1482811506-6447-1-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com, broonie@kernel.org, shumingf@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5645: set sel_i2s_pre_div1 to 2

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

>From 02c5c03283c52157d336abf5e44ffcda10579fbf Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Tue, 27 Dec 2016 12:05:05 +0800
Subject: [PATCH] ASoC: rt5645: set sel_i2s_pre_div1 to 2

The i2s clock pre-divider 1 is used for both i2s1 and sysclk.
The i2s1 is usually used for the main i2s and the pre-divider
will be set in hw_params function.

However, if i2s2 is used, the pre-divider is not set in the hw_params
function and the default value of i2s clock pre-divider 1 is too high
for sysclk and DMIC usage. Fix by overriding default divider value to 2.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=95681
Tested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5645.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 10c2a564a715..1ac96ef9ee20 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3833,6 +3833,9 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 		}
 	}
 
+	regmap_update_bits(rt5645->regmap, RT5645_ADDA_CLK1,
+		RT5645_I2S_PD1_MASK, RT5645_I2S_PD1_2);
+
 	if (rt5645->pdata.jd_invert) {
 		regmap_update_bits(rt5645->regmap, RT5645_IRQ_CTRL2,
 			RT5645_JD_1_1_MASK, RT5645_JD_1_1_INV);
-- 
2.11.0
