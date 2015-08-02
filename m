From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 36/42] ASoC: wm8990: Don't use range container
	for TLV with one entry
Date: Sun,  2 Aug 2015 17:20:04 +0200
Message-ID: <1438528810-23498-37-git-send-email-lars@metafoo.de>
References: <1438528810-23498-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-138.synserver.de (smtp-out-138.synserver.de
 [212.40.185.138])
 by alsa0.perex.cz (Postfix) with ESMTP id AAB3B265015
 for <alsa-devel@alsa-project.org>; Sun,  2 Aug 2015 17:20:58 +0200 (CEST)
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

For TLVs with only a single entry it is not necessary to use a range
container. Use DECLARE_TLV_DB_SCALE() directly instead of a combination of
TLV_DB_RANGE_HEAD() and TLV_DB_SCALE_ITEM().

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/wm8990.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm8990.c b/sound/soc/codecs/wm8990.c
index 83d72d8..23ecd30 100644
--- a/sound/soc/codecs/wm8990.c
+++ b/sound/soc/codecs/wm8990.c
@@ -418,10 +418,7 @@ static int outmixer_event(struct snd_soc_dapm_widget *w,
 }
 
 /* INMIX dB values */
-static const unsigned int in_mix_tlv[] = {
-	TLV_DB_RANGE_HEAD(1),
-	0, 7, TLV_DB_SCALE_ITEM(-1200, 600, 0),
-};
+static const DECLARE_TLV_DB_SCALE(in_mix_tlv, -1200, 600, 0);
 
 /* Left In PGA Connections */
 static const struct snd_kcontrol_new wm8990_dapm_lin12_pga_controls[] = {
-- 
2.1.4
