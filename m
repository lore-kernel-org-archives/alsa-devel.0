From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8962: Replace TLV_DB_RANGE_HEAD with
	DECLARE_TLV_DB_RANGE" to the asoc tree
Date: Wed, 05 Aug 2015 13:30:58 +0100
Message-ID: <E1ZMxqU-0005oy-Cl@finisterre>
References: <1438528810-23498-36-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A1EA8265DF9
 for <alsa-devel@alsa-project.org>; Wed,  5 Aug 2015 14:31:09 +0200 (CEST)
In-Reply-To: <1438528810-23498-36-git-send-email-lars@metafoo.de>
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

   ASoC: wm8962: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE

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

>From fcbb71e9ccac59940b619bdd5a51c96495dd4731 Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Sun, 2 Aug 2015 17:20:03 +0200
Subject: [PATCH] ASoC: wm8962: Replace TLV_DB_RANGE_HEAD with
 DECLARE_TLV_DB_RANGE

DECLARE_TLV_DB_RANGE() has the advantage over using TLV_DB_RANGE_HEAD()
that it automatically calculates the number of items in the TLV and is
hence less prone to manual error.

Generate using the following coccinelle script

// <smpl>
@@
declarer name DECLARE_TLV_DB_RANGE;
identifier tlv;
constant x;
@@
-unsigned int tlv[] = {
-	TLV_DB_RANGE_HEAD(x),
+DECLARE_TLV_DB_RANGE(tlv,
	...
-};
+);
// </smpl>

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8962.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index c5748fd..b618da9 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -1456,14 +1456,13 @@ static int wm8962_reset(struct wm8962_priv *wm8962)
 
 static const DECLARE_TLV_DB_SCALE(inpga_tlv, -2325, 75, 0);
 static const DECLARE_TLV_DB_SCALE(mixin_tlv, -1500, 300, 0);
-static const unsigned int mixinpga_tlv[] = {
-	TLV_DB_RANGE_HEAD(5),
+static const DECLARE_TLV_DB_RANGE(mixinpga_tlv,
 	0, 1, TLV_DB_SCALE_ITEM(0, 600, 0),
 	2, 2, TLV_DB_SCALE_ITEM(1300, 1300, 0),
 	3, 4, TLV_DB_SCALE_ITEM(1800, 200, 0),
 	5, 5, TLV_DB_SCALE_ITEM(2400, 0, 0),
-	6, 7, TLV_DB_SCALE_ITEM(2700, 300, 0),
-};
+	6, 7, TLV_DB_SCALE_ITEM(2700, 300, 0)
+);
 static const DECLARE_TLV_DB_SCALE(beep_tlv, -9600, 600, 1);
 static const DECLARE_TLV_DB_SCALE(digital_tlv, -7200, 75, 1);
 static const DECLARE_TLV_DB_SCALE(st_tlv, -3600, 300, 0);
@@ -1471,11 +1470,10 @@ static const DECLARE_TLV_DB_SCALE(inmix_tlv, -600, 600, 0);
 static const DECLARE_TLV_DB_SCALE(bypass_tlv, -1500, 300, 0);
 static const DECLARE_TLV_DB_SCALE(out_tlv, -12100, 100, 1);
 static const DECLARE_TLV_DB_SCALE(hp_tlv, -700, 100, 0);
-static const unsigned int classd_tlv[] = {
-	TLV_DB_RANGE_HEAD(2),
+static const DECLARE_TLV_DB_RANGE(classd_tlv,
 	0, 6, TLV_DB_SCALE_ITEM(0, 150, 0),
-	7, 7, TLV_DB_SCALE_ITEM(1200, 0, 0),
-};
+	7, 7, TLV_DB_SCALE_ITEM(1200, 0, 0)
+);
 static const DECLARE_TLV_DB_SCALE(eq_tlv, -1200, 100, 0);
 
 static int wm8962_dsp2_write_config(struct snd_soc_codec *codec)
-- 
2.1.4
