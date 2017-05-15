From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codecs: msm8916: fix invalid cast to
	bool type" to the asoc tree
Date: Mon, 15 May 2017 17:02:39 +0900
Message-ID: <E1dAAxj-0002Qk-IC@finisterre>
References: <20170502133303.19622-3-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E9AE26731C
 for <alsa-devel@alsa-project.org>; Mon, 15 May 2017 10:02:50 +0200 (CEST)
In-Reply-To: <20170502133303.19622-3-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, ",
 alsa-devel@alsa-project.org"@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codecs: msm8916: fix invalid cast to bool type

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

>From 9f3b777f1de9ff5d17f7259b8f7da5e9d4303e87 Mon Sep 17 00:00:00 2001
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Date: Tue, 2 May 2017 22:33:01 +0900
Subject: [PATCH] ASoC: codecs: msm8916: fix invalid cast to bool type

A function snd_soc_update_bits() is an application of
regmap_update_bits_base(). This function takes some arguments for bitmask
and new value, thus the arguments should be a type which has width.
However bool is used to variable for the argument. This brings truncation
and results in invalid operation.

This commit fixes this bug by using unsigned int type, instead of bool.
This bug is detected by sparse:

smsm8916-wcd-analog.c:809:43: warning: odd constant _Bool cast (40 becomes 1)
smsm8916-wcd-analog.c:814:43: warning: odd constant _Bool cast (40 becomes 1)

Fixes: 585e881e5b9e ("ASoC: codecs: Add msm8916-wcd analog codec")
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/msm8916-wcd-analog.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/msm8916-wcd-analog.c b/sound/soc/codecs/msm8916-wcd-analog.c
index d8e8590746af..a78802920c3c 100644
--- a/sound/soc/codecs/msm8916-wcd-analog.c
+++ b/sound/soc/codecs/msm8916-wcd-analog.c
@@ -223,8 +223,8 @@ struct pm8916_wcd_analog_priv {
 	u16 codec_version;
 	struct clk *mclk;
 	struct regulator_bulk_data supplies[ARRAY_SIZE(supply_names)];
-	bool micbias1_cap_mode;
-	bool micbias2_cap_mode;
+	unsigned int micbias1_cap_mode;
+	unsigned int micbias2_cap_mode;
 };
 
 static const char *const adc2_mux_text[] = { "ZERO", "INP2", "INP3" };
@@ -285,7 +285,7 @@ static void pm8916_wcd_analog_micbias_enable(struct snd_soc_codec *codec)
 
 static int pm8916_wcd_analog_enable_micbias_ext(struct snd_soc_codec
 						 *codec, int event,
-						 int reg, u32 cap_mode)
+						 int reg, unsigned int cap_mode)
 {
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
-- 
2.11.0
