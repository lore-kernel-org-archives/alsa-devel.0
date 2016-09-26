From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ASOC: max9867/rt5616/wm8960: remove usage of
	obsoleted TLV-related macro
Date: Tue, 27 Sep 2016 08:51:00 +0900
Message-ID: <1474933860-15692-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 2F58C266928
 for <alsa-devel@alsa-project.org>; Tue, 27 Sep 2016 01:51:13 +0200 (CEST)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, anish kumar <yesanishhere@gmail.com>
List-Id: alsa-devel@alsa-project.org

TLV_DB_RANGE_HEAD macro was obsoleted by commit bf1d1c9b6179 ("ALSA: tlv:
add DECLARE_TLV_DB_RANGE()").

This commit removes usage of the macro, with the obsoleting macro renamed
to SNDRV_CTL_TLVD_DECLARE_DB_RANGE().

Cc: Bard Liao <bardliao@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>
Cc: patches@opensource.wolfsonmicro.com
Cc: anish kumar <yesanishhere@gmail.com>
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/soc/codecs/max9867.c | 5 ++---
 sound/soc/codecs/rt5616.c  | 5 ++---
 sound/soc/codecs/wm8960.c  | 5 ++---
 3 files changed, 6 insertions(+), 9 deletions(-)

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
diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index d7f444f..3d8c756 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -226,11 +226,10 @@ static const DECLARE_TLV_DB_SCALE(dac_tlv, -12750, 50, 1);
 static const DECLARE_TLV_DB_SCALE(bypass_tlv, -2100, 300, 0);
 static const DECLARE_TLV_DB_SCALE(out_tlv, -12100, 100, 1);
 static const DECLARE_TLV_DB_SCALE(lineinboost_tlv, -1500, 300, 1);
-static const unsigned int micboost_tlv[] = {
-	TLV_DB_RANGE_HEAD(2),
+static const SNDRV_CTL_TLVD_DECLARE_DB_RANGE(micboost_tlv,
 	0, 1, TLV_DB_SCALE_ITEM(0, 1300, 0),
 	2, 3, TLV_DB_SCALE_ITEM(2000, 900, 0),
-};
+);
 
 static const struct snd_kcontrol_new wm8960_snd_controls[] = {
 SOC_DOUBLE_R_TLV("Capture Volume", WM8960_LINVOL, WM8960_RINVOL,
-- 
2.7.4
