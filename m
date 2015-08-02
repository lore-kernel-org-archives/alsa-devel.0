From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 15/42] ASoC: max98090: Replace
	TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
Date: Sun,  2 Aug 2015 17:19:43 +0200
Message-ID: <1438528810-23498-16-git-send-email-lars@metafoo.de>
References: <1438528810-23498-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-138.synserver.de (smtp-out-138.synserver.de
 [212.40.185.138])
 by alsa0.perex.cz (Postfix) with ESMTP id 2B215261B25
 for <alsa-devel@alsa-project.org>; Sun,  2 Aug 2015 17:20:32 +0200 (CEST)
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
 sound/soc/codecs/max98090.c | 42 ++++++++++++++++++------------------------
 1 file changed, 18 insertions(+), 24 deletions(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index 91c9f9f..a8a696a 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -360,22 +360,20 @@ static int max98090_reset(struct max98090_priv *max98090)
 	return ret;
 }
 
-static const unsigned int max98090_micboost_tlv[] = {
-	TLV_DB_RANGE_HEAD(2),
+static const DECLARE_TLV_DB_RANGE(max98090_micboost_tlv,
 	0, 1, TLV_DB_SCALE_ITEM(0, 2000, 0),
-	2, 2, TLV_DB_SCALE_ITEM(3000, 0, 0),
-};
+	2, 2, TLV_DB_SCALE_ITEM(3000, 0, 0)
+);
 
 static const DECLARE_TLV_DB_SCALE(max98090_mic_tlv, 0, 100, 0);
 
 static const DECLARE_TLV_DB_SCALE(max98090_line_single_ended_tlv,
 	-600, 600, 0);
 
-static const unsigned int max98090_line_tlv[] = {
-	TLV_DB_RANGE_HEAD(2),
+static const DECLARE_TLV_DB_RANGE(max98090_line_tlv,
 	0, 3, TLV_DB_SCALE_ITEM(-600, 300, 0),
-	4, 5, TLV_DB_SCALE_ITEM(1400, 600, 0),
-};
+	4, 5, TLV_DB_SCALE_ITEM(1400, 600, 0)
+);
 
 static const DECLARE_TLV_DB_SCALE(max98090_avg_tlv, 0, 600, 0);
 static const DECLARE_TLV_DB_SCALE(max98090_av_tlv, -1200, 100, 0);
@@ -391,38 +389,34 @@ static const DECLARE_TLV_DB_SCALE(max98090_alccomp_tlv, -3100, 100, 0);
 static const DECLARE_TLV_DB_SCALE(max98090_drcexp_tlv, -6600, 100, 0);
 static const DECLARE_TLV_DB_SCALE(max98090_sdg_tlv, 50, 200, 0);
 
-static const unsigned int max98090_mixout_tlv[] = {
-	TLV_DB_RANGE_HEAD(2),
+static const DECLARE_TLV_DB_RANGE(max98090_mixout_tlv,
 	0, 1, TLV_DB_SCALE_ITEM(-1200, 250, 0),
-	2, 3, TLV_DB_SCALE_ITEM(-600, 600, 0),
-};
+	2, 3, TLV_DB_SCALE_ITEM(-600, 600, 0)
+);
 
-static const unsigned int max98090_hp_tlv[] = {
-	TLV_DB_RANGE_HEAD(5),
+static const DECLARE_TLV_DB_RANGE(max98090_hp_tlv,
 	0, 6, TLV_DB_SCALE_ITEM(-6700, 400, 0),
 	7, 14, TLV_DB_SCALE_ITEM(-4000, 300, 0),
 	15, 21, TLV_DB_SCALE_ITEM(-1700, 200, 0),
 	22, 27, TLV_DB_SCALE_ITEM(-400, 100, 0),
-	28, 31, TLV_DB_SCALE_ITEM(150, 50, 0),
-};
+	28, 31, TLV_DB_SCALE_ITEM(150, 50, 0)
+);
 
-static const unsigned int max98090_spk_tlv[] = {
-	TLV_DB_RANGE_HEAD(5),
+static const DECLARE_TLV_DB_RANGE(max98090_spk_tlv,
 	0, 4, TLV_DB_SCALE_ITEM(-4800, 400, 0),
 	5, 10, TLV_DB_SCALE_ITEM(-2900, 300, 0),
 	11, 14, TLV_DB_SCALE_ITEM(-1200, 200, 0),
 	15, 29, TLV_DB_SCALE_ITEM(-500, 100, 0),
-	30, 39, TLV_DB_SCALE_ITEM(950, 50, 0),
-};
+	30, 39, TLV_DB_SCALE_ITEM(950, 50, 0)
+);
 
-static const unsigned int max98090_rcv_lout_tlv[] = {
-	TLV_DB_RANGE_HEAD(5),
+static const DECLARE_TLV_DB_RANGE(max98090_rcv_lout_tlv,
 	0, 6, TLV_DB_SCALE_ITEM(-6200, 400, 0),
 	7, 14, TLV_DB_SCALE_ITEM(-3500, 300, 0),
 	15, 21, TLV_DB_SCALE_ITEM(-1200, 200, 0),
 	22, 27, TLV_DB_SCALE_ITEM(100, 100, 0),
-	28, 31, TLV_DB_SCALE_ITEM(650, 50, 0),
-};
+	28, 31, TLV_DB_SCALE_ITEM(650, 50, 0)
+);
 
 static int max98090_get_enab_tlv(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_value *ucontrol)
-- 
2.1.4
