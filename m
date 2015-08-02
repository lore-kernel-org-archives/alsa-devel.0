From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 08/42] ASoC: cs42l73: Replace TLV_DB_RANGE_HEAD
	with DECLARE_TLV_DB_RANGE
Date: Sun,  2 Aug 2015 17:19:36 +0200
Message-ID: <1438528810-23498-9-git-send-email-lars@metafoo.de>
References: <1438528810-23498-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-138.synserver.de (smtp-out-138.synserver.de
 [212.40.185.138])
 by alsa0.perex.cz (Postfix) with ESMTP id EA07426129A
 for <alsa-devel@alsa-project.org>; Sun,  2 Aug 2015 17:20:24 +0200 (CEST)
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
 sound/soc/codecs/cs42l73.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/cs42l73.c b/sound/soc/codecs/cs42l73.c
index be6477f..427d6cf 100644
--- a/sound/soc/codecs/cs42l73.c
+++ b/sound/soc/codecs/cs42l73.c
@@ -253,11 +253,10 @@ static bool cs42l73_readable_register(struct device *dev, unsigned int reg)
 	}
 }
 
-static const unsigned int hpaloa_tlv[] = {
-	TLV_DB_RANGE_HEAD(2),
+static const DECLARE_TLV_DB_RANGE(hpaloa_tlv,
 	0, 13, TLV_DB_SCALE_ITEM(-7600, 200, 0),
-	14, 75, TLV_DB_SCALE_ITEM(-4900, 100, 0),
-};
+	14, 75, TLV_DB_SCALE_ITEM(-4900, 100, 0)
+);
 
 static DECLARE_TLV_DB_SCALE(adc_boost_tlv, 0, 2500, 0);
 
@@ -267,11 +266,10 @@ static DECLARE_TLV_DB_SCALE(ipd_tlv, -9600, 100, 0);
 
 static DECLARE_TLV_DB_SCALE(micpga_tlv, -600, 50, 0);
 
-static const unsigned int limiter_tlv[] = {
-	TLV_DB_RANGE_HEAD(2),
+static const DECLARE_TLV_DB_RANGE(limiter_tlv,
 	0, 2, TLV_DB_SCALE_ITEM(-3000, 600, 0),
-	3, 7, TLV_DB_SCALE_ITEM(-1200, 300, 0),
-};
+	3, 7, TLV_DB_SCALE_ITEM(-1200, 300, 0)
+);
 
 static const DECLARE_TLV_DB_SCALE(attn_tlv, -6300, 100, 1);
 
-- 
2.1.4
