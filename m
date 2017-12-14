From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5663: Fix the wrong result of the
	first jack detection" to the asoc tree
Date: Thu, 14 Dec 2017 11:49:09 +0000
Message-ID: <E1ePS0j-0005No-43@debutante>
References: <1513216447-26901-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 98B2F266B67
 for <alsa-devel@alsa-project.org>; Thu, 14 Dec 2017 12:49:20 +0100 (CET)
In-Reply-To: <1513216447-26901-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com, alsa-devel@alsa-project.org, shruthi.sudhakar@intel.com, lgirdwood@gmail.com, albertchen@realtek.com, broonie@kernel.org, bardliao@realtek.com, shumingf@realtek.com, naveen.m@intel.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5663: Fix the wrong result of the first jack detection

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

>From 958d022e326810fd762505bd02007aced79ffcbc Mon Sep 17 00:00:00 2001
From: "oder_chiou@realtek.com" <oder_chiou@realtek.com>
Date: Thu, 14 Dec 2017 09:54:07 +0800
Subject: [PATCH] ASoC: rt5663: Fix the wrong result of the first jack
 detection

In the first jack detection while booting, the result will always show as
headset, even we insert the headphone.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5663.c | 4 ++++
 sound/soc/codecs/rt5663.h | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/sound/soc/codecs/rt5663.c b/sound/soc/codecs/rt5663.c
index b036c9dc0c8c..d329bf719d80 100644
--- a/sound/soc/codecs/rt5663.c
+++ b/sound/soc/codecs/rt5663.c
@@ -1560,6 +1560,10 @@ static int rt5663_jack_detect(struct snd_soc_codec *codec, int jack_insert)
 			RT5663_IRQ_POW_SAV_MASK, RT5663_IRQ_POW_SAV_EN);
 		snd_soc_update_bits(codec, RT5663_IRQ_1,
 			RT5663_EN_IRQ_JD1_MASK, RT5663_EN_IRQ_JD1_EN);
+		snd_soc_update_bits(codec, RT5663_EM_JACK_TYPE_1,
+			RT5663_EM_JD_MASK, RT5663_EM_JD_RST);
+		snd_soc_update_bits(codec, RT5663_EM_JACK_TYPE_1,
+			RT5663_EM_JD_MASK, RT5663_EM_JD_NOR);
 
 		while (true) {
 			regmap_read(rt5663->regmap, RT5663_INT_ST_2, &val);
diff --git a/sound/soc/codecs/rt5663.h b/sound/soc/codecs/rt5663.h
index c5a9b69579ad..03adc8004ba9 100644
--- a/sound/soc/codecs/rt5663.h
+++ b/sound/soc/codecs/rt5663.h
@@ -1029,6 +1029,10 @@
 #define RT5663_POL_EXT_JD_SHIFT			10
 #define RT5663_POL_EXT_JD_EN			(0x1 << 10)
 #define RT5663_POL_EXT_JD_DIS			(0x0 << 10)
+#define RT5663_EM_JD_MASK			(0x1 << 7)
+#define RT5663_EM_JD_SHIFT			7
+#define RT5663_EM_JD_NOR			(0x1 << 7)
+#define RT5663_EM_JD_RST			(0x0 << 7)
 
 /* DACREF LDO Control (0x0112)*/
 #define RT5663_PWR_LDO_DACREFL_MASK		(0x1 << 9)
-- 
2.15.1
