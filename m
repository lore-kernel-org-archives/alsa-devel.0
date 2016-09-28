From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH v2 2/3] ASoC: rt5616: remove usage of obsoleted
	TLV-related macro
Date: Wed, 28 Sep 2016 09:29:20 +0900
Message-ID: <1475022561-5968-3-git-send-email-o-takashi@sakamocchi.jp>
References: <1475022561-5968-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 3BD75266A2F
 for <alsa-devel@alsa-project.org>; Wed, 28 Sep 2016 02:29:27 +0200 (CEST)
In-Reply-To: <1475022561-5968-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, broonie@kernel.org, lgirdwood@gmail.com
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

TLV_DB_RANGE_HEAD macro was obsoleted by commit bf1d1c9b6179 ("ALSA: tlv:
add DECLARE_TLV_DB_RANGE()").

This commit removes usage of the macro, with the obsoleting macro renamed
to SNDRV_CTL_TLVD_DECLARE_DB_RANGE().

Cc: Bard Liao <bardliao@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/soc/codecs/rt5616.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt5616.c b/sound/soc/codecs/rt5616.c
index f527b5b..851704f 100644
--- a/sound/soc/codecs/rt5616.c
+++ b/sound/soc/codecs/rt5616.c
@@ -294,8 +294,7 @@ static const DECLARE_TLV_DB_SCALE(adc_vol_tlv, -17625, 375, 0);
 static const DECLARE_TLV_DB_SCALE(adc_bst_tlv, 0, 1200, 0);
 
 /* {0, +20, +24, +30, +35, +40, +44, +50, +52} dB */
-static unsigned int bst_tlv[] = {
-	TLV_DB_RANGE_HEAD(7),
+static const SNDRV_CTL_TLVD_DECLARE_DB_RANGE(bst_tlv,
 	0, 0, TLV_DB_SCALE_ITEM(0, 0, 0),
 	1, 1, TLV_DB_SCALE_ITEM(2000, 0, 0),
 	2, 2, TLV_DB_SCALE_ITEM(2400, 0, 0),
@@ -303,7 +302,7 @@ static unsigned int bst_tlv[] = {
 	6, 6, TLV_DB_SCALE_ITEM(4400, 0, 0),
 	7, 7, TLV_DB_SCALE_ITEM(5000, 0, 0),
 	8, 8, TLV_DB_SCALE_ITEM(5200, 0, 0),
-};
+);
 
 static const struct snd_kcontrol_new rt5616_snd_controls[] = {
 	/* Headphone Output Volume */
-- 
2.7.4
