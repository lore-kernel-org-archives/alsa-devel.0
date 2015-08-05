From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8737: Replace TLV_DB_RANGE_HEAD with
	DECLARE_TLV_DB_RANGE" to the asoc tree
Date: Wed, 05 Aug 2015 13:31:04 +0100
Message-ID: <E1ZMxqa-0005qV-L1@finisterre>
References: <1438528810-23498-33-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 31CB1265DFE
 for <alsa-devel@alsa-project.org>; Wed,  5 Aug 2015 14:31:16 +0200 (CEST)
In-Reply-To: <1438528810-23498-33-git-send-email-lars@metafoo.de>
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

   ASoC: wm8737: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE

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

>From 7d711f63e36737968dcda5ce28fed3fb3e12fbdc Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Sun, 2 Aug 2015 17:20:00 +0200
Subject: [PATCH] ASoC: wm8737: Replace TLV_DB_RANGE_HEAD with
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
 sound/soc/codecs/wm8737.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm8737.c b/sound/soc/codecs/wm8737.c
index 6ad606f..54e6158 100644
--- a/sound/soc/codecs/wm8737.c
+++ b/sound/soc/codecs/wm8737.c
@@ -79,13 +79,12 @@ static int wm8737_reset(struct snd_soc_codec *codec)
 	return snd_soc_write(codec, WM8737_RESET, 0);
 }
 
-static const unsigned int micboost_tlv[] = {
-	TLV_DB_RANGE_HEAD(4),
+static const DECLARE_TLV_DB_RANGE(micboost_tlv,
 	0, 0, TLV_DB_SCALE_ITEM(1300, 0, 0),
 	1, 1, TLV_DB_SCALE_ITEM(1800, 0, 0),
 	2, 2, TLV_DB_SCALE_ITEM(2800, 0, 0),
-	3, 3, TLV_DB_SCALE_ITEM(3300, 0, 0),
-};
+	3, 3, TLV_DB_SCALE_ITEM(3300, 0, 0)
+);
 static const DECLARE_TLV_DB_SCALE(pga_tlv, -9750, 50, 1);
 static const DECLARE_TLV_DB_SCALE(adc_tlv, -600, 600, 0);
 static const DECLARE_TLV_DB_SCALE(ng_tlv, -7800, 600, 0);
-- 
2.1.4
