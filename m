From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: jz4740: Replace TLV_DB_RANGE_HEAD with
	DECLARE_TLV_DB_RANGE" to the asoc tree
Date: Wed, 05 Aug 2015 13:31:42 +0100
Message-ID: <E1ZMxrC-0005zt-Oa@finisterre>
References: <1438528810-23498-13-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AC6D9265DAB
 for <alsa-devel@alsa-project.org>; Wed,  5 Aug 2015 14:31:53 +0200 (CEST)
In-Reply-To: <1438528810-23498-13-git-send-email-lars@metafoo.de>
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

   ASoC: jz4740: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE

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

>From 4689ac530efa8dadfb3ef8a284f9b2b14b75ad5f Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Sun, 2 Aug 2015 17:19:40 +0200
Subject: [PATCH] ASoC: jz4740: Replace TLV_DB_RANGE_HEAD with
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
 sound/soc/codecs/jz4740.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/jz4740.c b/sound/soc/codecs/jz4740.c
index 9363fdb..1f5ab99 100644
--- a/sound/soc/codecs/jz4740.c
+++ b/sound/soc/codecs/jz4740.c
@@ -78,11 +78,10 @@ struct jz4740_codec {
 	struct regmap *regmap;
 };
 
-static const unsigned int jz4740_mic_tlv[] = {
-	TLV_DB_RANGE_HEAD(2),
+static const DECLARE_TLV_DB_RANGE(jz4740_mic_tlv,
 	0, 2, TLV_DB_SCALE_ITEM(0, 600, 0),
-	3, 3, TLV_DB_SCALE_ITEM(2000, 0, 0),
-};
+	3, 3, TLV_DB_SCALE_ITEM(2000, 0, 0)
+);
 
 static const DECLARE_TLV_DB_SCALE(jz4740_out_tlv, 0, 200, 0);
 static const DECLARE_TLV_DB_SCALE(jz4740_in_tlv, -3450, 150, 0);
-- 
2.1.4
