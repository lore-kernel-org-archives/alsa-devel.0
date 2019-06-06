From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt1011: fix warning reported by kbuild
	test robot and minor issue" to the asoc tree
Date: Thu,  6 Jun 2019 22:27:19 +0100 (BST)
Message-ID: <20190606212719.20FEC440046@finisterre.sirena.org.uk>
References: <20190606062232.3753-1-shumingf@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7B927F89818
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 23:27:21 +0200 (CEST)
In-Reply-To: <20190606062232.3753-1-shumingf@realtek.com>
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, cychiang@google.com, lgirdwood@gmail.com, Mark Brown <broonie@kernel.org>, derek.fang@realtek.com, mingjane_hsieh@realtek.com, flove@realtek.com, hychao@google.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt1011: fix warning reported by kbuild test robot and minor issue

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From 64429a8711e121e5d5d93d970c5ed3492332dd18 Mon Sep 17 00:00:00 2001
From: Shuming Fan <shumingf@realtek.com>
Date: Thu, 6 Jun 2019 14:22:32 +0800
Subject: [PATCH] ASoC: rt1011: fix warning reported by kbuild test robot and
 minor issue

This patch fixes following issues:
- warning: this decimal constant is unsigned only in ISO C90
- sparse: incorrect type in assignment
- check if value.integer.value is zero for "R0 Load Mode" control

Signed-off-by: Shuming Fan <shumingf@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt1011.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/rt1011.c b/sound/soc/codecs/rt1011.c
index 3a0ae80c5ee0..5605b660f4bf 100644
--- a/sound/soc/codecs/rt1011.c
+++ b/sound/soc/codecs/rt1011.c
@@ -1145,8 +1145,8 @@ static int rt1011_bq_drc_coeff_get(struct snd_kcontrol *kcontrol,
 	bq_drc_info = rt1011->bq_drc_params[mode_idx];
 
 	for (i = 0; i < RT1011_BQ_DRC_NUM; i++) {
-		params[i].reg = cpu_to_le16(bq_drc_info[i].reg);
-		params[i].val = cpu_to_le16(bq_drc_info[i].val);
+		params[i].reg = bq_drc_info[i].reg;
+		params[i].val = bq_drc_info[i].val;
 	}
 
 	return 0;
@@ -1187,8 +1187,8 @@ static int rt1011_bq_drc_coeff_put(struct snd_kcontrol *kcontrol,
 	pr_info("%s, id.name=%s, mode_idx=%d\n", __func__,
 		ucontrol->id.name, mode_idx);
 	for (i = 0; i < RT1011_BQ_DRC_NUM; i++) {
-		bq_drc_info[i].reg =	le16_to_cpu(params[i].reg);
-		bq_drc_info[i].val =	le16_to_cpu(params[i].val);
+		bq_drc_info[i].reg = params[i].reg;
+		bq_drc_info[i].val = params[i].val;
 	}
 
 	for (i = 0; i < RT1011_BQ_DRC_NUM; i++) {
@@ -1284,6 +1284,9 @@ static int rt1011_r0_load_mode_put(struct snd_kcontrol *kcontrol,
 	if (!component->card->instantiated)
 		return 0;
 
+	if (ucontrol->value.integer.value[0] == 0)
+		return -EINVAL;
+
 	dev = regmap_get_device(rt1011->regmap);
 	if (snd_soc_component_get_bias_level(component) == SND_SOC_BIAS_OFF) {
 		rt1011->r0_reg = ucontrol->value.integer.value[0];
-- 
2.20.1
