From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH v2 1/3] ASoC: max9867: remove usage of
	obsoleted TLV-related macro
Date: Wed, 28 Sep 2016 09:29:19 +0900
Message-ID: <1475022561-5968-2-git-send-email-o-takashi@sakamocchi.jp>
References: <1475022561-5968-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 3B9DD2669F6
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
Cc: alsa-devel@alsa-project.org, anish kumar <yesanishhere@gmail.com>
List-Id: alsa-devel@alsa-project.org

TLV_DB_RANGE_HEAD macro was obsoleted by commit bf1d1c9b6179 ("ALSA: tlv:
add DECLARE_TLV_DB_RANGE()").

This commit removes usage of the macro, with the obsoleting macro renamed
to SNDRV_CTL_TLVD_DECLARE_DB_RANGE().

Cc: anish kumar <yesanishhere@gmail.com>
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/soc/codecs/max9867.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/max9867.c b/sound/soc/codecs/max9867.c
index 2a22fdd..1aa838f 100644
--- a/sound/soc/codecs/max9867.c
+++ b/sound/soc/codecs/max9867.c
@@ -38,11 +38,10 @@ static DECLARE_TLV_DB_SCALE(max9860_capture_tlv, -600, 200, 0);
 static DECLARE_TLV_DB_SCALE(max9860_mic_tlv, 2000, 100, 1);
 static DECLARE_TLV_DB_SCALE(max9860_adc_left_tlv, -1200, 100, 1);
 static DECLARE_TLV_DB_SCALE(max9860_adc_right_tlv, -1200, 100, 1);
-static const unsigned int max98088_micboost_tlv[] = {
-	TLV_DB_RANGE_HEAD(2),
+static const SNDRV_CTL_TLVD_DECLARE_DB_RANGE(max98088_micboost_tlv,
 	0, 1, TLV_DB_SCALE_ITEM(0, 2000, 0),
 	2, 2, TLV_DB_SCALE_ITEM(3000, 0, 0),
-};
+);
 
 static const struct snd_kcontrol_new max9867_snd_controls[] = {
 	SOC_DOUBLE_R("Master Playback Volume", MAX9867_LEFTVOL,
-- 
2.7.4
