From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: 88pm860x: Replace TLV_DB_RANGE_HEAD
	with DECLARE_TLV_DB_RANGE" to the asoc tree
Date: Wed, 05 Aug 2015 13:32:02 +0100
Message-ID: <E1ZMxrW-000652-Ch@finisterre>
References: <1438528810-23498-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 326202660B4
 for <alsa-devel@alsa-project.org>; Wed,  5 Aug 2015 14:32:15 +0200 (CEST)
In-Reply-To: <1438528810-23498-2-git-send-email-lars@metafoo.de>
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

   ASoC: 88pm860x: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE

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

>From f17cbcfef3cf6d91a374817f84c66951c84f11e2 Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Sun, 2 Aug 2015 17:19:29 +0200
Subject: [PATCH] ASoC: 88pm860x: Replace TLV_DB_RANGE_HEAD with
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
 sound/soc/codecs/88pm860x-codec.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/88pm860x-codec.c b/sound/soc/codecs/88pm860x-codec.c
index 38b3dad..51dd50e 100644
--- a/sound/soc/codecs/88pm860x-codec.c
+++ b/sound/soc/codecs/88pm860x-codec.c
@@ -156,33 +156,29 @@ static const DECLARE_TLV_DB_SCALE(dpga_tlv, -9450, 150, 1);
 static const DECLARE_TLV_DB_SCALE(adc_tlv, -900, 300, 0);
 
 /* {-23, -17, -13.5, -11, -9, -6, -3, 0}dB */
-static const unsigned int mic_tlv[] = {
-	TLV_DB_RANGE_HEAD(5),
+static const DECLARE_TLV_DB_RANGE(mic_tlv,
 	0, 0, TLV_DB_SCALE_ITEM(-2300, 0, 0),
 	1, 1, TLV_DB_SCALE_ITEM(-1700, 0, 0),
 	2, 2, TLV_DB_SCALE_ITEM(-1350, 0, 0),
 	3, 3, TLV_DB_SCALE_ITEM(-1100, 0, 0),
-	4, 7, TLV_DB_SCALE_ITEM(-900, 300, 0),
-};
+	4, 7, TLV_DB_SCALE_ITEM(-900, 300, 0)
+);
 
 /* {0, 0, 0, -6, 0, 6, 12, 18}dB */
-static const unsigned int aux_tlv[] = {
-	TLV_DB_RANGE_HEAD(2),
+static const DECLARE_TLV_DB_RANGE(aux_tlv,
 	0, 2, TLV_DB_SCALE_ITEM(0, 0, 0),
-	3, 7, TLV_DB_SCALE_ITEM(-600, 600, 0),
-};
+	3, 7, TLV_DB_SCALE_ITEM(-600, 600, 0)
+);
 
 /* {-16, -13, -10, -7, -5.2, -3,3, -2.2, 0}dB, mute instead of -16dB */
-static const unsigned int out_tlv[] = {
-	TLV_DB_RANGE_HEAD(4),
+static const DECLARE_TLV_DB_RANGE(out_tlv,
 	0, 3, TLV_DB_SCALE_ITEM(-1600, 300, 1),
 	4, 4, TLV_DB_SCALE_ITEM(-520, 0, 0),
 	5, 5, TLV_DB_SCALE_ITEM(-330, 0, 0),
-	6, 7, TLV_DB_SCALE_ITEM(-220, 220, 0),
-};
+	6, 7, TLV_DB_SCALE_ITEM(-220, 220, 0)
+);
 
-static const unsigned int st_tlv[] = {
-	TLV_DB_RANGE_HEAD(8),
+static const DECLARE_TLV_DB_RANGE(st_tlv,
 	0, 1, TLV_DB_SCALE_ITEM(-12041, 602, 0),
 	2, 3, TLV_DB_SCALE_ITEM(-11087, 250, 0),
 	4, 5, TLV_DB_SCALE_ITEM(-10643, 158, 0),
@@ -190,8 +186,8 @@ static const unsigned int st_tlv[] = {
 	8, 9, TLV_DB_SCALE_ITEM(-10133, 92, 0),
 	10, 13, TLV_DB_SCALE_ITEM(-9958, 70, 0),
 	14, 17, TLV_DB_SCALE_ITEM(-9689, 53, 0),
-	18, 271, TLV_DB_SCALE_ITEM(-9484, 37, 0),
-};
+	18, 271, TLV_DB_SCALE_ITEM(-9484, 37, 0)
+);
 
 /* Sidetone Gain = M * 2^(-5-N) */
 struct st_gain {
-- 
2.1.4
