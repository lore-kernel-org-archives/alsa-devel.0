From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 16/42] ASoC: max98095: Replace
	TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
Date: Sun,  2 Aug 2015 17:19:44 +0200
Message-ID: <1438528810-23498-17-git-send-email-lars@metafoo.de>
References: <1438528810-23498-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-138.synserver.de (smtp-out-138.synserver.de
 [212.40.185.138])
 by alsa0.perex.cz (Postfix) with ESMTP id 634B42606A6
 for <alsa-devel@alsa-project.org>; Sun,  2 Aug 2015 17:20:33 +0200 (CEST)
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
 sound/soc/codecs/max98095.c | 35 +++++++++++++++--------------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/sound/soc/codecs/max98095.c b/sound/soc/codecs/max98095.c
index 7e3814e..6812984 100644
--- a/sound/soc/codecs/max98095.c
+++ b/sound/soc/codecs/max98095.c
@@ -661,48 +661,43 @@ static int max98095_mic2pre_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static const unsigned int max98095_micboost_tlv[] = {
-	TLV_DB_RANGE_HEAD(2),
+static const DECLARE_TLV_DB_RANGE(max98095_micboost_tlv,
 	0, 1, TLV_DB_SCALE_ITEM(0, 2000, 0),
-	2, 2, TLV_DB_SCALE_ITEM(3000, 0, 0),
-};
+	2, 2, TLV_DB_SCALE_ITEM(3000, 0, 0)
+);
 
 static const DECLARE_TLV_DB_SCALE(max98095_mic_tlv, 0, 100, 0);
 static const DECLARE_TLV_DB_SCALE(max98095_adc_tlv, -1200, 100, 0);
 static const DECLARE_TLV_DB_SCALE(max98095_adcboost_tlv, 0, 600, 0);
 
-static const unsigned int max98095_hp_tlv[] = {
-	TLV_DB_RANGE_HEAD(5),
+static const DECLARE_TLV_DB_RANGE(max98095_hp_tlv,
 	0, 6, TLV_DB_SCALE_ITEM(-6700, 400, 0),
 	7, 14, TLV_DB_SCALE_ITEM(-4000, 300, 0),
 	15, 21, TLV_DB_SCALE_ITEM(-1700, 200, 0),
 	22, 27, TLV_DB_SCALE_ITEM(-400, 100, 0),
-	28, 31, TLV_DB_SCALE_ITEM(150, 50, 0),
-};
+	28, 31, TLV_DB_SCALE_ITEM(150, 50, 0)
+);
 
-static const unsigned int max98095_spk_tlv[] = {
-	TLV_DB_RANGE_HEAD(4),
+static const DECLARE_TLV_DB_RANGE(max98095_spk_tlv,
 	0, 10, TLV_DB_SCALE_ITEM(-5900, 400, 0),
 	11, 18, TLV_DB_SCALE_ITEM(-1700, 200, 0),
 	19, 27, TLV_DB_SCALE_ITEM(-200, 100, 0),
-	28, 39, TLV_DB_SCALE_ITEM(650, 50, 0),
-};
+	28, 39, TLV_DB_SCALE_ITEM(650, 50, 0)
+);
 
-static const unsigned int max98095_rcv_lout_tlv[] = {
-	TLV_DB_RANGE_HEAD(5),
+static const DECLARE_TLV_DB_RANGE(max98095_rcv_lout_tlv,
 	0, 6, TLV_DB_SCALE_ITEM(-6200, 400, 0),
 	7, 14, TLV_DB_SCALE_ITEM(-3500, 300, 0),
 	15, 21, TLV_DB_SCALE_ITEM(-1200, 200, 0),
 	22, 27, TLV_DB_SCALE_ITEM(100, 100, 0),
-	28, 31, TLV_DB_SCALE_ITEM(650, 50, 0),
-};
+	28, 31, TLV_DB_SCALE_ITEM(650, 50, 0)
+);
 
-static const unsigned int max98095_lin_tlv[] = {
-	TLV_DB_RANGE_HEAD(3),
+static const DECLARE_TLV_DB_RANGE(max98095_lin_tlv,
 	0, 2, TLV_DB_SCALE_ITEM(-600, 300, 0),
 	3, 3, TLV_DB_SCALE_ITEM(300, 1100, 0),
-	4, 5, TLV_DB_SCALE_ITEM(1400, 600, 0),
-};
+	4, 5, TLV_DB_SCALE_ITEM(1400, 600, 0)
+);
 
 static const struct snd_kcontrol_new max98095_snd_controls[] = {
 
-- 
2.1.4
