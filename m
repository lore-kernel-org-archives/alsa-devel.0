From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tpa6130a2: Replace TLV_DB_RANGE_HEAD
	with DECLARE_TLV_DB_RANGE" to the asoc tree
Date: Wed, 05 Aug 2015 13:31:13 +0100
Message-ID: <E1ZMxqj-0005ss-US@finisterre>
References: <1438528810-23498-28-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BF55E265E1E
 for <alsa-devel@alsa-project.org>; Wed,  5 Aug 2015 14:31:26 +0200 (CEST)
In-Reply-To: <1438528810-23498-28-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tpa6130a2: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE

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

>From 4e0e5f8084cf9766ea70234f90271e03fd8aa56d Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Sun, 2 Aug 2015 17:19:55 +0200
Subject: [PATCH] ASoC: tpa6130a2: Replace TLV_DB_RANGE_HEAD with
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
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tpa6130a2.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.c
index 6fac9e0..1e1d4ab 100644
--- a/sound/soc/codecs/tpa6130a2.c
+++ b/sound/soc/codecs/tpa6130a2.c
@@ -259,8 +259,7 @@ static int tpa6130a2_put_volsw(struct snd_kcontrol *kcontrol,
  * TPA6130 volume. From -59.5 to 4 dB with increasing step size when going
  * down in gain.
  */
-static const unsigned int tpa6130_tlv[] = {
-	TLV_DB_RANGE_HEAD(10),
+static const DECLARE_TLV_DB_RANGE(tpa6130_tlv,
 	0, 1, TLV_DB_SCALE_ITEM(-5950, 600, 0),
 	2, 3, TLV_DB_SCALE_ITEM(-5000, 250, 0),
 	4, 5, TLV_DB_SCALE_ITEM(-4550, 160, 0),
@@ -270,8 +269,8 @@ static const unsigned int tpa6130_tlv[] = {
 	12, 13, TLV_DB_SCALE_ITEM(-3040, 180, 0),
 	14, 20, TLV_DB_SCALE_ITEM(-2710, 110, 0),
 	21, 37, TLV_DB_SCALE_ITEM(-1960, 74, 0),
-	38, 63, TLV_DB_SCALE_ITEM(-720, 45, 0),
-};
+	38, 63, TLV_DB_SCALE_ITEM(-720, 45, 0)
+);
 
 static const struct snd_kcontrol_new tpa6130a2_controls[] = {
 	SOC_SINGLE_EXT_TLV("TPA6130A2 Headphone Playback Volume",
@@ -280,12 +279,11 @@ static const struct snd_kcontrol_new tpa6130a2_controls[] = {
 		       tpa6130_tlv),
 };
 
-static const unsigned int tpa6140_tlv[] = {
-	TLV_DB_RANGE_HEAD(3),
+static const DECLARE_TLV_DB_RANGE(tpa6140_tlv,
 	0, 8, TLV_DB_SCALE_ITEM(-5900, 400, 0),
 	9, 16, TLV_DB_SCALE_ITEM(-2500, 200, 0),
-	17, 31, TLV_DB_SCALE_ITEM(-1000, 100, 0),
-};
+	17, 31, TLV_DB_SCALE_ITEM(-1000, 100, 0)
+);
 
 static const struct snd_kcontrol_new tpa6140a2_controls[] = {
 	SOC_SINGLE_EXT_TLV("TPA6140A2 Headphone Playback Volume",
-- 
2.1.4
