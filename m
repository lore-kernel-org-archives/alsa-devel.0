From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt1011: Add a flag for the R0
	calibration test" to the asoc tree
Date: Wed,  7 Aug 2019 14:30:49 +0100 (BST)
Message-ID: <20190807133049.B70882743057@ypsilon.sirena.org.uk>
References: <20190806091459.14382-1-shumingf@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 41427F80290
 for <alsa-devel@alsa-project.org>; Wed,  7 Aug 2019 15:30:53 +0200 (CEST)
In-Reply-To: <20190806091459.14382-1-shumingf@realtek.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Shuming Fan <shumingf@realtek.com>
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, cychiang@google.com, lgirdwood@gmail.com, Mark Brown <broonie@kernel.org>, derek.fang@realtek.com, frankbozar@google.com, sathya.prakash.m.r@intel.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt1011: Add a flag for the R0 calibration test

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

>From 0922c7a51c775b71a297598623debe9cb6ce3a08 Mon Sep 17 00:00:00 2001
From: Shuming Fan <shumingf@realtek.com>
Date: Tue, 6 Aug 2019 17:14:59 +0800
Subject: [PATCH] ASoC: rt1011: Add a flag for the R0 calibration test

The factory test needs to know whether the calibration completed.
This flag helps to confirm the calibration completed or not.

Signed-off-by: Shuming Fan <shumingf@realtek.com>
Link: https://lore.kernel.org/r/20190806091459.14382-1-shumingf@realtek.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt1011.c | 14 +++++++++++++-
 sound/soc/codecs/rt1011.h |  2 +-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt1011.c b/sound/soc/codecs/rt1011.c
index b25b4c1127ca..638abcaf52b3 100644
--- a/sound/soc/codecs/rt1011.c
+++ b/sound/soc/codecs/rt1011.c
@@ -1225,7 +1225,10 @@ static int rt1011_bq_drc_info(struct snd_kcontrol *kcontrol,
 static int rt1011_r0_cali_get(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_value *ucontrol)
 {
-	ucontrol->value.integer.value[0] = 0;
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	struct rt1011_priv *rt1011 = snd_soc_component_get_drvdata(component);
+
+	ucontrol->value.integer.value[0] = rt1011->cali_done;
 
 	return 0;
 }
@@ -1239,6 +1242,7 @@ static int rt1011_r0_cali_put(struct snd_kcontrol *kcontrol,
 	if (!component->card->instantiated)
 		return 0;
 
+	rt1011->cali_done = 0;
 	if (snd_soc_component_get_bias_level(component) == SND_SOC_BIAS_OFF &&
 		ucontrol->value.integer.value[0])
 		rt1011_calibrate(rt1011, 1);
@@ -2135,6 +2139,7 @@ static int rt1011_calibrate(struct rt1011_priv *rt1011, unsigned char cali_flag)
 			r0_factor = ((format / r0[0] * 100) / 128)
 							- (r0_integer * 100);
 			rt1011->r0_reg = r0[0];
+			rt1011->cali_done = 1;
 			dev_info(dev,	"r0 resistance about %d.%02d ohm, reg=0x%X\n",
 				r0_integer, r0_factor, r0[0]);
 		}
@@ -2185,6 +2190,13 @@ static void rt1011_calibration_work(struct work_struct *work)
 
 	rt1011_calibrate(rt1011, 1);
 
+	/*
+	 * This flag should reset after booting.
+	 * The factory test will do calibration again and use this flag to check
+	 * whether the calibration completed
+	 */
+	rt1011->cali_done = 0;
+
 	/* initial */
 	rt1011_reg_init(component);
 }
diff --git a/sound/soc/codecs/rt1011.h b/sound/soc/codecs/rt1011.h
index 5d431d7f1d16..2d65983f3d0f 100644
--- a/sound/soc/codecs/rt1011.h
+++ b/sound/soc/codecs/rt1011.h
@@ -666,7 +666,7 @@ struct rt1011_priv {
 	int pll_out;
 
 	int bq_drc_set;
-	unsigned int r0_reg;
+	unsigned int r0_reg, cali_done;
 	int recv_spk_mode;
 };
 
-- 
2.20.1
