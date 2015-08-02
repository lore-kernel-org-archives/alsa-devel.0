From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 42/42] ASoC: wm_hubs: Replace TLV_DB_RANGE_HEAD
	with DECLARE_TLV_DB_RANGE
Date: Sun,  2 Aug 2015 17:20:10 +0200
Message-ID: <1438528810-23498-43-git-send-email-lars@metafoo.de>
References: <1438528810-23498-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-138.synserver.de (smtp-out-138.synserver.de
 [212.40.185.138])
 by alsa0.perex.cz (Postfix) with ESMTP id E0E512612AD
 for <alsa-devel@alsa-project.org>; Sun,  2 Aug 2015 17:21:04 +0200 (CEST)
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
 sound/soc/codecs/wm_hubs.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm_hubs.c b/sound/soc/codecs/wm_hubs.c
index fd86bd1..624b3b9 100644
--- a/sound/soc/codecs/wm_hubs.c
+++ b/sound/soc/codecs/wm_hubs.c
@@ -38,11 +38,10 @@ static const DECLARE_TLV_DB_SCALE(earpiece_tlv, -600, 600, 0);
 static const DECLARE_TLV_DB_SCALE(outmix_tlv, -2100, 300, 0);
 static const DECLARE_TLV_DB_SCALE(spkmixout_tlv, -1800, 600, 1);
 static const DECLARE_TLV_DB_SCALE(outpga_tlv, -5700, 100, 0);
-static const unsigned int spkboost_tlv[] = {
-	TLV_DB_RANGE_HEAD(2),
+static const DECLARE_TLV_DB_RANGE(spkboost_tlv,
 	0, 6, TLV_DB_SCALE_ITEM(0, 150, 0),
-	7, 7, TLV_DB_SCALE_ITEM(1200, 0, 0),
-};
+	7, 7, TLV_DB_SCALE_ITEM(1200, 0, 0)
+);
 static const DECLARE_TLV_DB_SCALE(line_tlv, -600, 600, 0);
 
 static const char *speaker_ref_text[] = {
-- 
2.1.4
