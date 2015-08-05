From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: uda1380: Replace TLV_DB_RANGE_HEAD with
	DECLARE_TLV_DB_RANGE" to the asoc tree
Date: Wed, 05 Aug 2015 13:31:10 +0100
Message-ID: <E1ZMxqg-0005rw-1q@finisterre>
References: <1438528810-23498-30-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E8F5F265E10
 for <alsa-devel@alsa-project.org>; Wed,  5 Aug 2015 14:31:21 +0200 (CEST)
In-Reply-To: <1438528810-23498-30-git-send-email-lars@metafoo.de>
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

   ASoC: uda1380: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE

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

>From 5ee0b8f8296f237604f0ff72f03e7836f5e164b4 Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Sun, 2 Aug 2015 17:19:57 +0200
Subject: [PATCH] ASoC: uda1380: Replace TLV_DB_RANGE_HEAD with
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
 sound/soc/codecs/uda1380.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/uda1380.c b/sound/soc/codecs/uda1380.c
index 6e159f5..4b9b438 100644
--- a/sound/soc/codecs/uda1380.c
+++ b/sound/soc/codecs/uda1380.c
@@ -269,12 +269,11 @@ static DECLARE_TLV_DB_SCALE(amix_tlv, -4950, 150, 1);
  * from -66 dB in 0.5 dB steps (2 dB steps, really) and
  * from -52 dB in 0.25 dB steps
  */
-static const unsigned int mvol_tlv[] = {
-	TLV_DB_RANGE_HEAD(3),
+static const DECLARE_TLV_DB_RANGE(mvol_tlv,
 	0, 15, TLV_DB_SCALE_ITEM(-8200, 100, 1),
 	16, 43, TLV_DB_SCALE_ITEM(-6600, 50, 0),
-	44, 252, TLV_DB_SCALE_ITEM(-5200, 25, 0),
-};
+	44, 252, TLV_DB_SCALE_ITEM(-5200, 25, 0)
+);
 
 /*
  * from -72 dB in 1.5 dB steps (6 dB steps really),
@@ -282,13 +281,12 @@ static const unsigned int mvol_tlv[] = {
  * from -60 dB in 0.5 dB steps (2 dB steps really) and
  * from -46 dB in 0.25 dB steps
  */
-static const unsigned int vc_tlv[] = {
-	TLV_DB_RANGE_HEAD(4),
+static const DECLARE_TLV_DB_RANGE(vc_tlv,
 	0, 7, TLV_DB_SCALE_ITEM(-7800, 150, 1),
 	8, 15, TLV_DB_SCALE_ITEM(-6600, 75, 0),
 	16, 43, TLV_DB_SCALE_ITEM(-6000, 50, 0),
-	44, 228, TLV_DB_SCALE_ITEM(-4600, 25, 0),
-};
+	44, 228, TLV_DB_SCALE_ITEM(-4600, 25, 0)
+);
 
 /* from 0 to 6 dB in 2 dB steps if SPF mode != flat */
 static DECLARE_TLV_DB_SCALE(tr_tlv, 0, 200, 0);
-- 
2.1.4
