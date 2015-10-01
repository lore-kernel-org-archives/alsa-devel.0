From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5645: Add the control of ClassD
	modulator Speaker Gain Ratio" to the asoc tree
Date: Thu, 01 Oct 2015 11:23:58 +0100
Message-ID: <E1Zhb1q-0007Pr-RO@finisterre>
References: <1443682030-18258-2-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B75A7266642
 for <alsa-devel@alsa-project.org>; Thu,  1 Oct 2015 12:24:05 +0200 (CEST)
In-Reply-To: <1443682030-18258-2-git-send-email-oder_chiou@realtek.com>
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

   ASoC: rt5645: Add the control of ClassD modulator Speaker Gain Ratio

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

>From e29fd55d8d23ea7afcadd15a87700583e7da5035 Mon Sep 17 00:00:00 2001
From: Oder Chiou <oder_chiou@realtek.com>
Date: Thu, 1 Oct 2015 14:47:10 +0800
Subject: [PATCH] ASoC: rt5645: Add the control of ClassD modulator Speaker
 Gain Ratio

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5645.c | 12 ++++++++++++
 sound/soc/codecs/rt5645.h |  4 ++++
 2 files changed, 16 insertions(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index b0d96b6..1f7045bc 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -469,6 +469,14 @@ static const DECLARE_TLV_DB_RANGE(bst_tlv,
 	8, 8, TLV_DB_SCALE_ITEM(5200, 0, 0)
 );
 
+/* {-6, -4.5, -3, -1.5, 0, 0.82, 1.58, 2.28} dB */
+static const DECLARE_TLV_DB_RANGE(spk_clsd_tlv,
+	0, 4, TLV_DB_SCALE_ITEM(-600, 150, 0),
+	5, 5, TLV_DB_SCALE_ITEM(82, 0, 0),
+	6, 6, TLV_DB_SCALE_ITEM(158, 0, 0),
+	7, 7, TLV_DB_SCALE_ITEM(228, 0, 0)
+);
+
 static const struct snd_kcontrol_new rt5645_snd_controls[] = {
 	/* Speaker Output Volume */
 	SOC_DOUBLE("Speaker Channel Switch", RT5645_SPK_VOL,
@@ -476,6 +484,10 @@ static const struct snd_kcontrol_new rt5645_snd_controls[] = {
 	SOC_DOUBLE_TLV("Speaker Playback Volume", RT5645_SPK_VOL,
 		RT5645_L_VOL_SFT, RT5645_R_VOL_SFT, 39, 1, out_vol_tlv),
 
+	/* ClassD modulator Speaker Gain Ratio */
+	SOC_SINGLE_TLV("Speaker ClassD Playback Volume", RT5645_SPO_CLSD_RATIO,
+		RT5645_SPK_G_CLSD_SFT, 7, 0, spk_clsd_tlv),
+
 	/* Headphone Output Volume */
 	SOC_DOUBLE("Headphone Channel Switch", RT5645_HP_VOL,
 		RT5645_VOL_L_SFT, RT5645_VOL_R_SFT, 1, 1),
diff --git a/sound/soc/codecs/rt5645.h b/sound/soc/codecs/rt5645.h
index f45861c..d0e0ce5 100644
--- a/sound/soc/codecs/rt5645.h
+++ b/sound/soc/codecs/rt5645.h
@@ -668,6 +668,10 @@
 #define RT5645_M_SV_R_SPM_R			(0x1 << 0)
 #define RT5645_M_SV_R_SPM_R_SFT			0
 
+/* SPOMIX Ratio Control (0x4a) */
+#define RT5645_SPK_G_CLSD_MASK			(0x7 << 0)
+#define RT5645_SPK_G_CLSD_SFT			0
+
 /* Mono Output Mixer Control (0x4c) */
 #define RT5645_M_OV_L_MM			(0x1 << 9)
 #define RT5645_M_OV_L_MM_SFT			9
-- 
2.5.0
