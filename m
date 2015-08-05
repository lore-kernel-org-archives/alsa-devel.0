From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8961: Replace TLV_DB_RANGE_HEAD with
	DECLARE_TLV_DB_RANGE" to the asoc tree
Date: Wed, 05 Aug 2015 13:31:01 +0100
Message-ID: <E1ZMxqX-0005pT-0t@finisterre>
References: <1438528810-23498-35-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 73A3C265E02
 for <alsa-devel@alsa-project.org>; Wed,  5 Aug 2015 14:31:17 +0200 (CEST)
In-Reply-To: <1438528810-23498-35-git-send-email-lars@metafoo.de>
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

   ASoC: wm8961: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE

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

>From 5d272d89339a4f8c1905d5bdf5851346582b78f2 Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Sun, 2 Aug 2015 17:20:02 +0200
Subject: [PATCH] ASoC: wm8961: Replace TLV_DB_RANGE_HEAD with
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
 sound/soc/codecs/wm8961.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm8961.c b/sound/soc/codecs/wm8961.c
index a057662..44ee143 100644
--- a/sound/soc/codecs/wm8961.c
+++ b/sound/soc/codecs/wm8961.c
@@ -331,13 +331,12 @@ static const DECLARE_TLV_DB_SCALE(out_tlv, -12100, 100, 1);
 static const DECLARE_TLV_DB_SCALE(hp_sec_tlv, -700, 100, 0);
 static const DECLARE_TLV_DB_SCALE(adc_tlv, -7200, 75, 1);
 static const DECLARE_TLV_DB_SCALE(sidetone_tlv, -3600, 300, 0);
-static unsigned int boost_tlv[] = {
-	TLV_DB_RANGE_HEAD(4),
+static const DECLARE_TLV_DB_RANGE(boost_tlv,
 	0, 0, TLV_DB_SCALE_ITEM(0,  0, 0),
 	1, 1, TLV_DB_SCALE_ITEM(13, 0, 0),
 	2, 2, TLV_DB_SCALE_ITEM(20, 0, 0),
-	3, 3, TLV_DB_SCALE_ITEM(29, 0, 0),
-};
+	3, 3, TLV_DB_SCALE_ITEM(29, 0, 0)
+);
 static const DECLARE_TLV_DB_SCALE(pga_tlv, -2325, 75, 0);
 
 static const struct snd_kcontrol_new wm8961_snd_controls[] = {
-- 
2.1.4
