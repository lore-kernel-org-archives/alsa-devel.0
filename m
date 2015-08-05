From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm9090: Replace TLV_DB_RANGE_HEAD with
	DECLARE_TLV_DB_RANGE" to the asoc tree
Date: Wed, 05 Aug 2015 13:30:49 +0100
Message-ID: <E1ZMxqL-0005mc-Bk@finisterre>
References: <1438528810-23498-41-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3BA96265DAB
 for <alsa-devel@alsa-project.org>; Wed,  5 Aug 2015 14:31:01 +0200 (CEST)
In-Reply-To: <1438528810-23498-41-git-send-email-lars@metafoo.de>
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

   ASoC: wm9090: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE

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

>From 0894e2b3cddaf00a52302d0eb83edb717c6fb913 Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Sun, 2 Aug 2015 17:20:08 +0200
Subject: [PATCH] ASoC: wm9090: Replace TLV_DB_RANGE_HEAD with
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
 sound/soc/codecs/wm9090.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/wm9090.c b/sound/soc/codecs/wm9090.c
index 13d23fc..334c4c1 100644
--- a/sound/soc/codecs/wm9090.c
+++ b/sound/soc/codecs/wm9090.c
@@ -162,23 +162,20 @@ static void wait_for_dc_servo(struct snd_soc_codec *codec)
 		dev_err(codec->dev, "Timed out waiting for DC Servo\n");
 }
 
-static const unsigned int in_tlv[] = {
-	TLV_DB_RANGE_HEAD(3),
+static const DECLARE_TLV_DB_RANGE(in_tlv,
 	0, 0, TLV_DB_SCALE_ITEM(-600, 0, 0),
 	1, 3, TLV_DB_SCALE_ITEM(-350, 350, 0),
-	4, 6, TLV_DB_SCALE_ITEM(600, 600, 0),
-};
-static const unsigned int mix_tlv[] = {
-	TLV_DB_RANGE_HEAD(2),
+	4, 6, TLV_DB_SCALE_ITEM(600, 600, 0)
+);
+static const DECLARE_TLV_DB_RANGE(mix_tlv,
 	0, 2, TLV_DB_SCALE_ITEM(-1200, 300, 0),
-	3, 3, TLV_DB_SCALE_ITEM(0, 0, 0),
-};
+	3, 3, TLV_DB_SCALE_ITEM(0, 0, 0)
+);
 static const DECLARE_TLV_DB_SCALE(out_tlv, -5700, 100, 0);
-static const unsigned int spkboost_tlv[] = {
-	TLV_DB_RANGE_HEAD(2),
+static const DECLARE_TLV_DB_RANGE(spkboost_tlv,
 	0, 6, TLV_DB_SCALE_ITEM(0, 150, 0),
-	7, 7, TLV_DB_SCALE_ITEM(1200, 0, 0),
-};
+	7, 7, TLV_DB_SCALE_ITEM(1200, 0, 0)
+);
 
 static const struct snd_kcontrol_new wm9090_controls[] = {
 SOC_SINGLE_TLV("IN1A Volume", WM9090_IN1_LINE_INPUT_A_VOLUME, 0, 6, 0,
-- 
2.1.4
