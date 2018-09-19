From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH Resend] ASoC: rt5663: Remove the boost volume
	in the beginning of playback
Date: Wed, 19 Sep 2018 09:56:47 +0800
Message-ID: <1537322207-7784-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 3EBA526761D
 for <alsa-devel@alsa-project.org>; Wed, 19 Sep 2018 03:56:56 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com, alsa-devel@alsa-project.org, tzungbi@google.com, shumingf@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch removes the boost volume in the beginning of playback while the
DAC volume set to lower.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5663.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5663.c b/sound/soc/codecs/rt5663.c
index 9bd24ad..2444fad 100644
--- a/sound/soc/codecs/rt5663.c
+++ b/sound/soc/codecs/rt5663.c
@@ -72,6 +72,7 @@ struct rt5663_priv {
 static const struct reg_sequence rt5663_patch_list[] = {
 	{ 0x002a, 0x8020 },
 	{ 0x0086, 0x0028 },
+	{ 0x0100, 0xa020 },
 	{ 0x0117, 0x0f28 },
 	{ 0x02fb, 0x8089 },
 };
@@ -580,7 +581,7 @@ static const struct reg_default rt5663_reg[] = {
 	{ 0x00fd, 0x0001 },
 	{ 0x00fe, 0x10ec },
 	{ 0x00ff, 0x6406 },
-	{ 0x0100, 0xa0a0 },
+	{ 0x0100, 0xa020 },
 	{ 0x0108, 0x4444 },
 	{ 0x0109, 0x4444 },
 	{ 0x010a, 0xaaaa },
@@ -2337,6 +2338,8 @@ static int rt5663_hp_event(struct snd_soc_dapm_widget *w,
 				0x8000);
 			snd_soc_component_update_bits(component, RT5663_DEPOP_1, 0x3000,
 				0x3000);
+			snd_soc_component_update_bits(component,
+				RT5663_DIG_VOL_ZCD, 0x00c0, 0x0080);
 		}
 		break;
 
@@ -2351,6 +2354,8 @@ static int rt5663_hp_event(struct snd_soc_dapm_widget *w,
 				RT5663_OVCD_HP_MASK, RT5663_OVCD_HP_EN);
 			snd_soc_component_update_bits(component,
 				RT5663_DACREF_LDO, 0x3e0e, 0);
+			snd_soc_component_update_bits(component,
+				RT5663_DIG_VOL_ZCD, 0x00c0, 0);
 		}
 		break;
 
-- 
2.7.4
