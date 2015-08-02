From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 35/42] ASoC: wm8962: Replace TLV_DB_RANGE_HEAD
	with DECLARE_TLV_DB_RANGE
Date: Sun,  2 Aug 2015 17:20:03 +0200
Message-ID: <1438528810-23498-36-git-send-email-lars@metafoo.de>
References: <1438528810-23498-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-138.synserver.de (smtp-out-138.synserver.de
 [212.40.185.138])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A9C626500C
 for <alsa-devel@alsa-project.org>; Sun,  2 Aug 2015 17:20:57 +0200 (CEST)
In-Reply-To: <1438528810-23498-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, Brian Austin <brian.austin@cirrus.com>, Lars-Peter Clausen <lars@metafoo.de>, Support Opensource <support.opensource@diasemi.com>, Anish Kumar <yesanishhere@gmail.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Paul Handrigan <Paul.Handrigan@cirrus.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Bard Liao <bardliao@realtek.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

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
---
 sound/soc/codecs/wm8962.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 5c01707..b4eb975 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -1456,14 +1456,13 @@ static int wm8962_reset(struct wm8962_priv *wm8962)
 
 static const DECLARE_TLV_DB_SCALE(inpga_tlv, -2325, 75, 0);
 static const DECLARE_TLV_DB_SCALE(mixin_tlv, -1500, 300, 0);
-static const unsigned int mixinpga_tlv[] = {
-	TLV_DB_RANGE_HEAD(5),
+static const DECLARE_TLV_DB_RANGE(mixinpga_tlv,
 	0, 1, TLV_DB_SCALE_ITEM(0, 600, 0),
 	2, 2, TLV_DB_SCALE_ITEM(1300, 1300, 0),
 	3, 4, TLV_DB_SCALE_ITEM(1800, 200, 0),
 	5, 5, TLV_DB_SCALE_ITEM(2400, 0, 0),
-	6, 7, TLV_DB_SCALE_ITEM(2700, 300, 0),
-};
+	6, 7, TLV_DB_SCALE_ITEM(2700, 300, 0)
+);
 static const DECLARE_TLV_DB_SCALE(beep_tlv, -9600, 600, 1);
 static const DECLARE_TLV_DB_SCALE(digital_tlv, -7200, 75, 1);
 static const DECLARE_TLV_DB_SCALE(st_tlv, -3600, 300, 0);
@@ -1471,11 +1470,10 @@ static const DECLARE_TLV_DB_SCALE(inmix_tlv, -600, 600, 0);
 static const DECLARE_TLV_DB_SCALE(bypass_tlv, -1500, 300, 0);
 static const DECLARE_TLV_DB_SCALE(out_tlv, -12100, 100, 1);
 static const DECLARE_TLV_DB_SCALE(hp_tlv, -700, 100, 0);
-static const unsigned int classd_tlv[] = {
-	TLV_DB_RANGE_HEAD(2),
+static const DECLARE_TLV_DB_RANGE(classd_tlv,
 	0, 6, TLV_DB_SCALE_ITEM(0, 150, 0),
-	7, 7, TLV_DB_SCALE_ITEM(1200, 0, 0),
-};
+	7, 7, TLV_DB_SCALE_ITEM(1200, 0, 0)
+);
 static const DECLARE_TLV_DB_SCALE(eq_tlv, -1200, 100, 0);
 
 static int wm8962_dsp2_write_config(struct snd_soc_codec *codec)
-- 
2.1.4
