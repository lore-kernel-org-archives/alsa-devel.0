From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs42l56: Replace TLV_DB_RANGE_HEAD with
	DECLARE_TLV_DB_RANGE" to the asoc tree
Date: Wed, 05 Aug 2015 13:31:51 +0100
Message-ID: <E1ZMxrL-00062E-QH@finisterre>
References: <1438528810-23498-8-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D600266027
 for <alsa-devel@alsa-project.org>; Wed,  5 Aug 2015 14:32:04 +0200 (CEST)
In-Reply-To: <1438528810-23498-8-git-send-email-lars@metafoo.de>
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

   ASoC: cs42l56: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE

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

>From 37879bafc2e0932279ad440d5a81c323e0c5c58c Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Sun, 2 Aug 2015 17:19:35 +0200
Subject: [PATCH] ASoC: cs42l56: Replace TLV_DB_RANGE_HEAD with
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
 sound/soc/codecs/cs42l56.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/cs42l56.c b/sound/soc/codecs/cs42l56.c
index 1e11ba4..e88a559e 100644
--- a/sound/soc/codecs/cs42l56.c
+++ b/sound/soc/codecs/cs42l56.c
@@ -185,21 +185,18 @@ static DECLARE_TLV_DB_SCALE(tone_tlv, -1050, 150, 0);
 static DECLARE_TLV_DB_SCALE(preamp_tlv, 0, 1000, 0);
 static DECLARE_TLV_DB_SCALE(pga_tlv, -600, 50, 0);
 
-static const unsigned int ngnb_tlv[] = {
-	TLV_DB_RANGE_HEAD(2),
+static const DECLARE_TLV_DB_RANGE(ngnb_tlv,
 	0, 1, TLV_DB_SCALE_ITEM(-8200, 600, 0),
-	2, 5, TLV_DB_SCALE_ITEM(-7600, 300, 0),
-};
-static const unsigned int ngb_tlv[] = {
-	TLV_DB_RANGE_HEAD(2),
+	2, 5, TLV_DB_SCALE_ITEM(-7600, 300, 0)
+);
+static const DECLARE_TLV_DB_RANGE(ngb_tlv,
 	0, 2, TLV_DB_SCALE_ITEM(-6400, 600, 0),
-	3, 7, TLV_DB_SCALE_ITEM(-4600, 300, 0),
-};
-static const unsigned int alc_tlv[] = {
-	TLV_DB_RANGE_HEAD(2),
+	3, 7, TLV_DB_SCALE_ITEM(-4600, 300, 0)
+);
+static const DECLARE_TLV_DB_RANGE(alc_tlv,
 	0, 2, TLV_DB_SCALE_ITEM(-3000, 600, 0),
-	3, 7, TLV_DB_SCALE_ITEM(-1200, 300, 0),
-};
+	3, 7, TLV_DB_SCALE_ITEM(-1200, 300, 0)
+);
 
 static const char * const beep_config_text[] = {
 	"Off", "Single", "Multiple", "Continuous"
-- 
2.1.4
