From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 33/42] ASoC: wm8753: Replace TLV_DB_RANGE_HEAD
	with DECLARE_TLV_DB_RANGE
Date: Sun,  2 Aug 2015 17:20:01 +0200
Message-ID: <1438528810-23498-34-git-send-email-lars@metafoo.de>
References: <1438528810-23498-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-138.synserver.de (smtp-out-138.synserver.de
 [212.40.185.138])
 by alsa0.perex.cz (Postfix) with ESMTP id 68C3826262D
 for <alsa-devel@alsa-project.org>; Sun,  2 Aug 2015 17:20:55 +0200 (CEST)
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
 sound/soc/codecs/wm8753.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index b5e50ff..0e946f3 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -276,12 +276,11 @@ static const DECLARE_TLV_DB_SCALE(rec_mix_tlv, -1500, 300, 0);
 static const DECLARE_TLV_DB_SCALE(mic_preamp_tlv, 1200, 600, 0);
 static const DECLARE_TLV_DB_SCALE(adc_tlv, -9750, 50, 1);
 static const DECLARE_TLV_DB_SCALE(dac_tlv, -12750, 50, 1);
-static const unsigned int out_tlv[] = {
-	TLV_DB_RANGE_HEAD(2),
+static const DECLARE_TLV_DB_RANGE(out_tlv,
 	/* 0000000 - 0101111 = "Analogue mute" */
 	0, 48, TLV_DB_SCALE_ITEM(-25500, 0, 0),
-	48, 127, TLV_DB_SCALE_ITEM(-7300, 100, 0),
-};
+	48, 127, TLV_DB_SCALE_ITEM(-7300, 100, 0)
+);
 static const DECLARE_TLV_DB_SCALE(mix_tlv, -1500, 300, 0);
 static const DECLARE_TLV_DB_SCALE(voice_mix_tlv, -1200, 300, 0);
 static const DECLARE_TLV_DB_SCALE(pga_tlv, -1725, 75, 0);
-- 
2.1.4
