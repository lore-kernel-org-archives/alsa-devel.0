From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: adau1373: Replace TLV_DB_RANGE_HEAD
	with DECLARE_TLV_DB_RANGE" to the asoc tree
Date: Wed, 05 Aug 2015 13:31:58 +0100
Message-ID: <E1ZMxrS-000646-RE@finisterre>
References: <1438528810-23498-4-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6BC1926607E
 for <alsa-devel@alsa-project.org>; Wed,  5 Aug 2015 14:32:10 +0200 (CEST)
In-Reply-To: <1438528810-23498-4-git-send-email-lars@metafoo.de>
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

   ASoC: adau1373: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE

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

>From 31581f3c09e796d5faac183eadfe06dca2223a5e Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Sun, 2 Aug 2015 17:19:31 +0200
Subject: [PATCH] ASoC: adau1373: Replace TLV_DB_RANGE_HEAD with
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
 sound/soc/codecs/adau1373.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/adau1373.c b/sound/soc/codecs/adau1373.c
index a431602..1fc1bd4 100644
--- a/sound/soc/codecs/adau1373.c
+++ b/sound/soc/codecs/adau1373.c
@@ -320,13 +320,12 @@ static const struct reg_default adau1373_reg_defaults[] = {
 	{ ADAU1373_DIGEN,		0x00 },
 };
 
-static const unsigned int adau1373_out_tlv[] = {
-	TLV_DB_RANGE_HEAD(4),
+static const DECLARE_TLV_DB_RANGE(adau1373_out_tlv,
 	0, 7, TLV_DB_SCALE_ITEM(-7900, 400, 1),
 	8, 15, TLV_DB_SCALE_ITEM(-4700, 300, 0),
 	16, 23, TLV_DB_SCALE_ITEM(-2300, 200, 0),
-	24, 31, TLV_DB_SCALE_ITEM(-700, 100, 0),
-};
+	24, 31, TLV_DB_SCALE_ITEM(-700, 100, 0)
+);
 
 static const DECLARE_TLV_DB_MINMAX(adau1373_digital_tlv, -9563, 0);
 static const DECLARE_TLV_DB_SCALE(adau1373_in_pga_tlv, -1300, 100, 1);
@@ -381,12 +380,11 @@ static const char *adau1373_bass_hpf_cutoff_text[] = {
 	"158Hz", "232Hz", "347Hz", "520Hz",
 };
 
-static const unsigned int adau1373_bass_tlv[] = {
-	TLV_DB_RANGE_HEAD(3),
+static const DECLARE_TLV_DB_RANGE(adau1373_bass_tlv,
 	0, 2, TLV_DB_SCALE_ITEM(-600, 600, 1),
 	3, 4, TLV_DB_SCALE_ITEM(950, 250, 0),
-	5, 7, TLV_DB_SCALE_ITEM(1400, 150, 0),
-};
+	5, 7, TLV_DB_SCALE_ITEM(1400, 150, 0)
+);
 
 static SOC_ENUM_SINGLE_DECL(adau1373_bass_lpf_cutoff_enum,
 	ADAU1373_BASS1, 5, adau1373_bass_lpf_cutoff_text);
@@ -414,11 +412,10 @@ static SOC_ENUM_SINGLE_DECL(adau1373_3d_level_enum,
 static SOC_ENUM_SINGLE_DECL(adau1373_3d_cutoff_enum,
 	ADAU1373_3D_CTRL1, 0, adau1373_3d_cutoff_text);
 
-static const unsigned int adau1373_3d_tlv[] = {
-	TLV_DB_RANGE_HEAD(2),
+static const DECLARE_TLV_DB_RANGE(adau1373_3d_tlv,
 	0, 0, TLV_DB_SCALE_ITEM(0, 0, 0),
-	1, 7, TLV_DB_LINEAR_ITEM(-1800, -120),
-};
+	1, 7, TLV_DB_LINEAR_ITEM(-1800, -120)
+);
 
 static const char *adau1373_lr_mux_text[] = {
 	"Mute",
-- 
2.1.4
