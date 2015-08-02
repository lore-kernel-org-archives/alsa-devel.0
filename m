From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 01/42] ASoC: 88pm860x: Replace
	TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
Date: Sun,  2 Aug 2015 17:19:29 +0200
Message-ID: <1438528810-23498-2-git-send-email-lars@metafoo.de>
References: <1438528810-23498-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-138.synserver.de (smtp-out-138.synserver.de
 [212.40.185.138])
 by alsa0.perex.cz (Postfix) with ESMTP id 2AB922606A6
 for <alsa-devel@alsa-project.org>; Sun,  2 Aug 2015 17:20:17 +0200 (CEST)
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
 sound/soc/codecs/88pm860x-codec.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/88pm860x-codec.c b/sound/soc/codecs/88pm860x-codec.c
index 4d91a6a..e8bed6b 100644
--- a/sound/soc/codecs/88pm860x-codec.c
+++ b/sound/soc/codecs/88pm860x-codec.c
@@ -156,33 +156,29 @@ static const DECLARE_TLV_DB_SCALE(dpga_tlv, -9450, 150, 1);
 static const DECLARE_TLV_DB_SCALE(adc_tlv, -900, 300, 0);
 
 /* {-23, -17, -13.5, -11, -9, -6, -3, 0}dB */
-static const unsigned int mic_tlv[] = {
-	TLV_DB_RANGE_HEAD(5),
+static const DECLARE_TLV_DB_RANGE(mic_tlv,
 	0, 0, TLV_DB_SCALE_ITEM(-2300, 0, 0),
 	1, 1, TLV_DB_SCALE_ITEM(-1700, 0, 0),
 	2, 2, TLV_DB_SCALE_ITEM(-1350, 0, 0),
 	3, 3, TLV_DB_SCALE_ITEM(-1100, 0, 0),
-	4, 7, TLV_DB_SCALE_ITEM(-900, 300, 0),
-};
+	4, 7, TLV_DB_SCALE_ITEM(-900, 300, 0)
+);
 
 /* {0, 0, 0, -6, 0, 6, 12, 18}dB */
-static const unsigned int aux_tlv[] = {
-	TLV_DB_RANGE_HEAD(2),
+static const DECLARE_TLV_DB_RANGE(aux_tlv,
 	0, 2, TLV_DB_SCALE_ITEM(0, 0, 0),
-	3, 7, TLV_DB_SCALE_ITEM(-600, 600, 0),
-};
+	3, 7, TLV_DB_SCALE_ITEM(-600, 600, 0)
+);
 
 /* {-16, -13, -10, -7, -5.2, -3,3, -2.2, 0}dB, mute instead of -16dB */
-static const unsigned int out_tlv[] = {
-	TLV_DB_RANGE_HEAD(4),
+static const DECLARE_TLV_DB_RANGE(out_tlv,
 	0, 3, TLV_DB_SCALE_ITEM(-1600, 300, 1),
 	4, 4, TLV_DB_SCALE_ITEM(-520, 0, 0),
 	5, 5, TLV_DB_SCALE_ITEM(-330, 0, 0),
-	6, 7, TLV_DB_SCALE_ITEM(-220, 220, 0),
-};
+	6, 7, TLV_DB_SCALE_ITEM(-220, 220, 0)
+);
 
-static const unsigned int st_tlv[] = {
-	TLV_DB_RANGE_HEAD(8),
+static const DECLARE_TLV_DB_RANGE(st_tlv,
 	0, 1, TLV_DB_SCALE_ITEM(-12041, 602, 0),
 	2, 3, TLV_DB_SCALE_ITEM(-11087, 250, 0),
 	4, 5, TLV_DB_SCALE_ITEM(-10643, 158, 0),
@@ -190,8 +186,8 @@ static const unsigned int st_tlv[] = {
 	8, 9, TLV_DB_SCALE_ITEM(-10133, 92, 0),
 	10, 13, TLV_DB_SCALE_ITEM(-9958, 70, 0),
 	14, 17, TLV_DB_SCALE_ITEM(-9689, 53, 0),
-	18, 271, TLV_DB_SCALE_ITEM(-9484, 37, 0),
-};
+	18, 271, TLV_DB_SCALE_ITEM(-9484, 37, 0)
+);
 
 /* Sidetone Gain = M * 2^(-5-N) */
 struct st_gain {
-- 
2.1.4
