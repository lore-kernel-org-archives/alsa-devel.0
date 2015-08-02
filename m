From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 13/42] ASoC: max9768: Replace TLV_DB_RANGE_HEAD
	with DECLARE_TLV_DB_RANGE
Date: Sun,  2 Aug 2015 17:19:41 +0200
Message-ID: <1438528810-23498-14-git-send-email-lars@metafoo.de>
References: <1438528810-23498-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-138.synserver.de (smtp-out-138.synserver.de
 [212.40.185.138])
 by alsa0.perex.cz (Postfix) with ESMTP id 01C1D26150C
 for <alsa-devel@alsa-project.org>; Sun,  2 Aug 2015 17:20:29 +0200 (CEST)
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
 sound/soc/codecs/max9768.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/max9768.c b/sound/soc/codecs/max9768.c
index bd41128..5b82e26 100644
--- a/sound/soc/codecs/max9768.c
+++ b/sound/soc/codecs/max9768.c
@@ -63,8 +63,7 @@ static int max9768_set_gpio(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static const unsigned int volume_tlv[] = {
-	TLV_DB_RANGE_HEAD(43),
+static const DECLARE_TLV_DB_RANGE(volume_tlv,
 	0, 0, TLV_DB_SCALE_ITEM(-16150, 0, 0),
 	1, 1, TLV_DB_SCALE_ITEM(-9280, 0, 0),
 	2, 2, TLV_DB_SCALE_ITEM(-9030, 0, 0),
@@ -107,8 +106,8 @@ static const unsigned int volume_tlv[] = {
 	51, 57, TLV_DB_SCALE_ITEM(290, 50, 0),
 	58, 58, TLV_DB_SCALE_ITEM(650, 0, 0),
 	59, 62, TLV_DB_SCALE_ITEM(700, 60, 0),
-	63, 63, TLV_DB_SCALE_ITEM(950, 0, 0),
-};
+	63, 63, TLV_DB_SCALE_ITEM(950, 0, 0)
+);
 
 static const struct snd_kcontrol_new max9768_volume[] = {
 	SOC_SINGLE_TLV("Playback Volume", MAX9768_VOL, 0, 63, 0, volume_tlv),
-- 
2.1.4
