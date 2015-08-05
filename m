From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max98088: Replace TLV_DB_RANGE_HEAD
	with DECLARE_TLV_DB_RANGE" to the asoc tree
Date: Wed, 05 Aug 2015 13:31:38 +0100
Message-ID: <E1ZMxr8-0005yx-TZ@finisterre>
References: <1438528810-23498-15-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 54E0D265FD5
 for <alsa-devel@alsa-project.org>; Wed,  5 Aug 2015 14:31:50 +0200 (CEST)
In-Reply-To: <1438528810-23498-15-git-send-email-lars@metafoo.de>
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

   ASoC: max98088: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE

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

>From 80170468deec8fe851957d1e1cc3cf680ae46804 Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Sun, 2 Aug 2015 17:19:42 +0200
Subject: [PATCH] ASoC: max98088: Replace TLV_DB_RANGE_HEAD with
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
 sound/soc/codecs/max98088.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/max98088.c b/sound/soc/codecs/max98088.c
index d0f4534..d326d66 100644
--- a/sound/soc/codecs/max98088.c
+++ b/sound/soc/codecs/max98088.c
@@ -680,29 +680,26 @@ static int max98088_mic2pre_get(struct snd_kcontrol *kcontrol,
        return 0;
 }
 
-static const unsigned int max98088_micboost_tlv[] = {
-       TLV_DB_RANGE_HEAD(2),
-       0, 1, TLV_DB_SCALE_ITEM(0, 2000, 0),
-       2, 2, TLV_DB_SCALE_ITEM(3000, 0, 0),
-};
+static const DECLARE_TLV_DB_RANGE(max98088_micboost_tlv,
+	0, 1, TLV_DB_SCALE_ITEM(0, 2000, 0),
+	2, 2, TLV_DB_SCALE_ITEM(3000, 0, 0)
+);
 
-static const unsigned int max98088_hp_tlv[] = {
-	TLV_DB_RANGE_HEAD(5),
+static const DECLARE_TLV_DB_RANGE(max98088_hp_tlv,
 	0, 6, TLV_DB_SCALE_ITEM(-6700, 400, 0),
 	7, 14, TLV_DB_SCALE_ITEM(-4000, 300, 0),
 	15, 21, TLV_DB_SCALE_ITEM(-1700, 200, 0),
 	22, 27, TLV_DB_SCALE_ITEM(-400, 100, 0),
-	28, 31, TLV_DB_SCALE_ITEM(150, 50, 0),
-};
+	28, 31, TLV_DB_SCALE_ITEM(150, 50, 0)
+);
 
-static const unsigned int max98088_spk_tlv[] = {
-	TLV_DB_RANGE_HEAD(5),
+static const DECLARE_TLV_DB_RANGE(max98088_spk_tlv,
 	0, 6, TLV_DB_SCALE_ITEM(-6200, 400, 0),
 	7, 14, TLV_DB_SCALE_ITEM(-3500, 300, 0),
 	15, 21, TLV_DB_SCALE_ITEM(-1200, 200, 0),
 	22, 27, TLV_DB_SCALE_ITEM(100, 100, 0),
-	28, 31, TLV_DB_SCALE_ITEM(650, 50, 0),
-};
+	28, 31, TLV_DB_SCALE_ITEM(650, 50, 0)
+);
 
 static const struct snd_kcontrol_new max98088_snd_controls[] = {
 
-- 
2.1.4
