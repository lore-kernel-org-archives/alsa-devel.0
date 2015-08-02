From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 29/42] ASoC: uda1380: Replace TLV_DB_RANGE_HEAD
	with DECLARE_TLV_DB_RANGE
Date: Sun,  2 Aug 2015 17:19:57 +0200
Message-ID: <1438528810-23498-30-git-send-email-lars@metafoo.de>
References: <1438528810-23498-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-138.synserver.de (smtp-out-138.synserver.de
 [212.40.185.138])
 by alsa0.perex.cz (Postfix) with ESMTP id EAF3D264F45
 for <alsa-devel@alsa-project.org>; Sun,  2 Aug 2015 17:20:50 +0200 (CEST)
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
 sound/soc/codecs/uda1380.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/uda1380.c b/sound/soc/codecs/uda1380.c
index 5cafb16..35f0469 100644
--- a/sound/soc/codecs/uda1380.c
+++ b/sound/soc/codecs/uda1380.c
@@ -269,12 +269,11 @@ static DECLARE_TLV_DB_SCALE(amix_tlv, -4950, 150, 1);
  * from -66 dB in 0.5 dB steps (2 dB steps, really) and
  * from -52 dB in 0.25 dB steps
  */
-static const unsigned int mvol_tlv[] = {
-	TLV_DB_RANGE_HEAD(3),
+static const DECLARE_TLV_DB_RANGE(mvol_tlv,
 	0, 15, TLV_DB_SCALE_ITEM(-8200, 100, 1),
 	16, 43, TLV_DB_SCALE_ITEM(-6600, 50, 0),
-	44, 252, TLV_DB_SCALE_ITEM(-5200, 25, 0),
-};
+	44, 252, TLV_DB_SCALE_ITEM(-5200, 25, 0)
+);
 
 /*
  * from -72 dB in 1.5 dB steps (6 dB steps really),
@@ -282,13 +281,12 @@ static const unsigned int mvol_tlv[] = {
  * from -60 dB in 0.5 dB steps (2 dB steps really) and
  * from -46 dB in 0.25 dB steps
  */
-static const unsigned int vc_tlv[] = {
-	TLV_DB_RANGE_HEAD(4),
+static const DECLARE_TLV_DB_RANGE(vc_tlv,
 	0, 7, TLV_DB_SCALE_ITEM(-7800, 150, 1),
 	8, 15, TLV_DB_SCALE_ITEM(-6600, 75, 0),
 	16, 43, TLV_DB_SCALE_ITEM(-6000, 50, 0),
-	44, 228, TLV_DB_SCALE_ITEM(-4600, 25, 0),
-};
+	44, 228, TLV_DB_SCALE_ITEM(-4600, 25, 0)
+);
 
 /* from 0 to 6 dB in 2 dB steps if SPF mode != flat */
 static DECLARE_TLV_DB_SCALE(tr_tlv, 0, 200, 0);
-- 
2.1.4
