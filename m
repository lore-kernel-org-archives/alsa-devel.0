From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 40/42] ASoC: wm9090: Replace TLV_DB_RANGE_HEAD
	with DECLARE_TLV_DB_RANGE
Date: Sun,  2 Aug 2015 17:20:08 +0200
Message-ID: <1438528810-23498-41-git-send-email-lars@metafoo.de>
References: <1438528810-23498-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-138.synserver.de (smtp-out-138.synserver.de
 [212.40.185.138])
 by alsa0.perex.cz (Postfix) with ESMTP id 86461265099
 for <alsa-devel@alsa-project.org>; Sun,  2 Aug 2015 17:21:02 +0200 (CEST)
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
 sound/soc/codecs/wm9090.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/wm9090.c b/sound/soc/codecs/wm9090.c
index 12baf72..5d73729 100644
--- a/sound/soc/codecs/wm9090.c
+++ b/sound/soc/codecs/wm9090.c
@@ -162,23 +162,20 @@ static void wait_for_dc_servo(struct snd_soc_codec *codec)
 		dev_err(codec->dev, "Timed out waiting for DC Servo\n");
 }
 
-static const unsigned int in_tlv[] = {
-	TLV_DB_RANGE_HEAD(3),
+static const DECLARE_TLV_DB_RANGE(in_tlv,
 	0, 0, TLV_DB_SCALE_ITEM(-600, 0, 0),
 	1, 3, TLV_DB_SCALE_ITEM(-350, 350, 0),
-	4, 6, TLV_DB_SCALE_ITEM(600, 600, 0),
-};
-static const unsigned int mix_tlv[] = {
-	TLV_DB_RANGE_HEAD(2),
+	4, 6, TLV_DB_SCALE_ITEM(600, 600, 0)
+);
+static const DECLARE_TLV_DB_RANGE(mix_tlv,
 	0, 2, TLV_DB_SCALE_ITEM(-1200, 300, 0),
-	3, 3, TLV_DB_SCALE_ITEM(0, 0, 0),
-};
+	3, 3, TLV_DB_SCALE_ITEM(0, 0, 0)
+);
 static const DECLARE_TLV_DB_SCALE(out_tlv, -5700, 100, 0);
-static const unsigned int spkboost_tlv[] = {
-	TLV_DB_RANGE_HEAD(2),
+static const DECLARE_TLV_DB_RANGE(spkboost_tlv,
 	0, 6, TLV_DB_SCALE_ITEM(0, 150, 0),
-	7, 7, TLV_DB_SCALE_ITEM(1200, 0, 0),
-};
+	7, 7, TLV_DB_SCALE_ITEM(1200, 0, 0)
+);
 
 static const struct snd_kcontrol_new wm9090_controls[] = {
 SOC_SINGLE_TLV("IN1A Volume", WM9090_IN1_LINE_INPUT_A_VOLUME, 0, 6, 0,
-- 
2.1.4
