From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 09/42] ASoC: da7210: Replace TLV_DB_RANGE_HEAD
	with DECLARE_TLV_DB_RANGE
Date: Sun,  2 Aug 2015 17:19:37 +0200
Message-ID: <1438528810-23498-10-git-send-email-lars@metafoo.de>
References: <1438528810-23498-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-138.synserver.de (smtp-out-138.synserver.de
 [212.40.185.138])
 by alsa0.perex.cz (Postfix) with ESMTP id E9CFB2612DE
 for <alsa-devel@alsa-project.org>; Sun,  2 Aug 2015 17:20:25 +0200 (CEST)
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
 sound/soc/codecs/da7210.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/da7210.c b/sound/soc/codecs/da7210.c
index c7b3e92..7dc52fe 100644
--- a/sound/soc/codecs/da7210.c
+++ b/sound/soc/codecs/da7210.c
@@ -267,33 +267,29 @@ enum clk_src {
  *
  * Reserved area are considered as "mute".
  */
-static const unsigned int hp_out_tlv[] = {
-	TLV_DB_RANGE_HEAD(2),
+static const DECLARE_TLV_DB_RANGE(hp_out_tlv,
 	0x0, 0x10, TLV_DB_SCALE_ITEM(TLV_DB_GAIN_MUTE, 0, 1),
 	/* -54 dB to +15 dB */
-	0x11, 0x3f, TLV_DB_SCALE_ITEM(-5400, 150, 0),
-};
+	0x11, 0x3f, TLV_DB_SCALE_ITEM(-5400, 150, 0)
+);
 
-static const unsigned int lineout_vol_tlv[] = {
-	TLV_DB_RANGE_HEAD(2),
+static const DECLARE_TLV_DB_RANGE(lineout_vol_tlv,
 	0x0, 0x10, TLV_DB_SCALE_ITEM(TLV_DB_GAIN_MUTE, 0, 1),
 	/* -54dB to 15dB */
 	0x11, 0x3f, TLV_DB_SCALE_ITEM(-5400, 150, 0)
-};
+);
 
-static const unsigned int mono_vol_tlv[] = {
-	TLV_DB_RANGE_HEAD(2),
+static const DECLARE_TLV_DB_RANGE(mono_vol_tlv,
 	0x0, 0x2, TLV_DB_SCALE_ITEM(-1800, 0, 1),
 	/* -18dB to 6dB */
 	0x3, 0x7, TLV_DB_SCALE_ITEM(-1800, 600, 0)
-};
+);
 
-static const unsigned int aux1_vol_tlv[] = {
-	TLV_DB_RANGE_HEAD(2),
+static const DECLARE_TLV_DB_RANGE(aux1_vol_tlv,
 	0x0, 0x10, TLV_DB_SCALE_ITEM(TLV_DB_GAIN_MUTE, 0, 1),
 	/* -48dB to 21dB */
 	0x11, 0x3f, TLV_DB_SCALE_ITEM(-4800, 150, 0)
-};
+);
 
 static const DECLARE_TLV_DB_SCALE(eq_gain_tlv, -1050, 150, 0);
 static const DECLARE_TLV_DB_SCALE(adc_eq_master_gain_tlv, -1800, 600, 1);
-- 
2.1.4
