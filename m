From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs42l73: Replace TLV_DB_RANGE_HEAD with
	DECLARE_TLV_DB_RANGE" to the asoc tree
Date: Wed, 05 Aug 2015 13:31:50 +0100
Message-ID: <E1ZMxrK-00061l-2g@finisterre>
References: <1438528810-23498-9-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A57926601B
 for <alsa-devel@alsa-project.org>; Wed,  5 Aug 2015 14:32:03 +0200 (CEST)
In-Reply-To: <1438528810-23498-9-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Brian Austin <brian.austin@cirrus.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs42l73: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE

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

>From 0c8129152cb849183a204fe0ce95673e4c88d2f6 Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Sun, 2 Aug 2015 17:19:36 +0200
Subject: [PATCH] ASoC: cs42l73: Replace TLV_DB_RANGE_HEAD with
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
Acked-by: Brian Austin <brian.austin@cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs42l73.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/cs42l73.c b/sound/soc/codecs/cs42l73.c
index b7853b9..15ba377 100644
--- a/sound/soc/codecs/cs42l73.c
+++ b/sound/soc/codecs/cs42l73.c
@@ -253,11 +253,10 @@ static bool cs42l73_readable_register(struct device *dev, unsigned int reg)
 	}
 }
 
-static const unsigned int hpaloa_tlv[] = {
-	TLV_DB_RANGE_HEAD(2),
+static const DECLARE_TLV_DB_RANGE(hpaloa_tlv,
 	0, 13, TLV_DB_SCALE_ITEM(-7600, 200, 0),
-	14, 75, TLV_DB_SCALE_ITEM(-4900, 100, 0),
-};
+	14, 75, TLV_DB_SCALE_ITEM(-4900, 100, 0)
+);
 
 static DECLARE_TLV_DB_SCALE(adc_boost_tlv, 0, 2500, 0);
 
@@ -267,11 +266,10 @@ static DECLARE_TLV_DB_SCALE(ipd_tlv, -9600, 100, 0);
 
 static DECLARE_TLV_DB_SCALE(micpga_tlv, -600, 50, 0);
 
-static const unsigned int limiter_tlv[] = {
-	TLV_DB_RANGE_HEAD(2),
+static const DECLARE_TLV_DB_RANGE(limiter_tlv,
 	0, 2, TLV_DB_SCALE_ITEM(-3000, 600, 0),
-	3, 7, TLV_DB_SCALE_ITEM(-1200, 300, 0),
-};
+	3, 7, TLV_DB_SCALE_ITEM(-1200, 300, 0)
+);
 
 static const DECLARE_TLV_DB_SCALE(attn_tlv, -6300, 100, 1);
 
-- 
2.1.4
