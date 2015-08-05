From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8991: Don't use range container for
	TLVs with one entry" to the asoc tree
Date: Wed, 05 Aug 2015 13:30:54 +0100
Message-ID: <E1ZMxqQ-0005o1-VN@finisterre>
References: <1438528810-23498-38-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D80F265DFC
 for <alsa-devel@alsa-project.org>; Wed,  5 Aug 2015 14:31:11 +0200 (CEST)
In-Reply-To: <1438528810-23498-38-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm8991: Don't use range container for TLVs with one entry

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

>From 00769dbe3982c76dd68dac1d3f54328fa935bd21 Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Sun, 2 Aug 2015 17:20:05 +0200
Subject: [PATCH] ASoC: wm8991: Don't use range container for TLVs with one
 entry

For TLVs with only a single entry it is not necessary to use a range
container. Use DECLARE_TLV_DB_LINEAR() directly instead of a combination of
TLV_DB_RANGE_HEAD() and TLV_DB_LINEAR_ITEM().

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8991.c | 52 ++++++++---------------------------------------
 1 file changed, 9 insertions(+), 43 deletions(-)

diff --git a/sound/soc/codecs/wm8991.c b/sound/soc/codecs/wm8991.c
index 44a6777..de9110e 100644
--- a/sound/soc/codecs/wm8991.c
+++ b/sound/soc/codecs/wm8991.c
@@ -111,45 +111,14 @@ static bool wm8991_volatile(struct device *dev, unsigned int reg)
 	}
 }
 
-static const unsigned int rec_mix_tlv[] = {
-	TLV_DB_RANGE_HEAD(1),
-	0, 7, TLV_DB_LINEAR_ITEM(-1500, 600),
-};
-
-static const unsigned int in_pga_tlv[] = {
-	TLV_DB_RANGE_HEAD(1),
-	0, 0x1F, TLV_DB_LINEAR_ITEM(-1650, 3000),
-};
-
-static const unsigned int out_mix_tlv[] = {
-	TLV_DB_RANGE_HEAD(1),
-	0, 7, TLV_DB_LINEAR_ITEM(0, -2100),
-};
-
-static const unsigned int out_pga_tlv[] = {
-	TLV_DB_RANGE_HEAD(1),
-	0, 127, TLV_DB_LINEAR_ITEM(-7300, 600),
-};
-
-static const unsigned int out_omix_tlv[] = {
-	TLV_DB_RANGE_HEAD(1),
-	0, 7, TLV_DB_LINEAR_ITEM(-600, 0),
-};
-
-static const unsigned int out_dac_tlv[] = {
-	TLV_DB_RANGE_HEAD(1),
-	0, 255, TLV_DB_LINEAR_ITEM(-7163, 0),
-};
-
-static const unsigned int in_adc_tlv[] = {
-	TLV_DB_RANGE_HEAD(1),
-	0, 255, TLV_DB_LINEAR_ITEM(-7163, 1763),
-};
-
-static const unsigned int out_sidetone_tlv[] = {
-	TLV_DB_RANGE_HEAD(1),
-	0, 31, TLV_DB_LINEAR_ITEM(-3600, 0),
-};
+static const DECLARE_TLV_DB_LINEAR(rec_mix_tlv, -1500, 600);
+static const DECLARE_TLV_DB_LINEAR(in_pga_tlv, -1650, 3000);
+static const DECLARE_TLV_DB_LINEAR(out_mix_tlv, 0, -2100);
+static const DECLARE_TLV_DB_LINEAR(out_pga_tlv, -7300, 600);
+static const DECLARE_TLV_DB_LINEAR(out_omix_tlv, -600, 0);
+static const DECLARE_TLV_DB_LINEAR(out_dac_tlv, -7163, 0);
+static const DECLARE_TLV_DB_LINEAR(in_adc_tlv, -7163, 1763);
+static const DECLARE_TLV_DB_LINEAR(out_sidetone_tlv, -3600, 0);
 
 static int wm899x_outpga_put_volsw_vu(struct snd_kcontrol *kcontrol,
 				      struct snd_ctl_elem_value *ucontrol)
@@ -429,10 +398,7 @@ static int outmixer_event(struct snd_soc_dapm_widget *w,
 }
 
 /* INMIX dB values */
-static const unsigned int in_mix_tlv[] = {
-	TLV_DB_RANGE_HEAD(1),
-	0, 7, TLV_DB_LINEAR_ITEM(-1200, 600),
-};
+static const DECLARE_TLV_DB_LINEAR(in_mix_tlv, -1200, 600);
 
 /* Left In PGA Connections */
 static const struct snd_kcontrol_new wm8991_dapm_lin12_pga_controls[] = {
-- 
2.1.4
