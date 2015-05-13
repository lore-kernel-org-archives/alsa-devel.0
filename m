From: Nicolas Boichat <drinkcat@chromium.org>
Subject: [PATCH] ASoC: rt5645: Rename HP control to Headphone
Date: Wed, 13 May 2015 16:15:12 +0800
Message-ID: <1431504912-30698-1-git-send-email-drinkcat@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f175.google.com (mail-pd0-f175.google.com
 [209.85.192.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 2650F2605EF
 for <alsa-devel@alsa-project.org>; Wed, 13 May 2015 10:15:20 +0200 (CEST)
Received: by pdbqa5 with SMTP id qa5so44054818pdb.1
 for <alsa-devel@alsa-project.org>; Wed, 13 May 2015 01:15:19 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, Koro Chen <koro.chen@mediatek.com>
List-Id: alsa-devel@alsa-project.org

Use the standard name "Headphone" instead of "HP" for better
userspace integration.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---
 sound/soc/codecs/rt5645.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index be4d741..bc925f0 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -464,9 +464,9 @@ static const struct snd_kcontrol_new rt5645_snd_controls[] = {
 		RT5645_L_VOL_SFT, RT5645_R_VOL_SFT, 39, 1, out_vol_tlv),
 
 	/* Headphone Output Volume */
-	SOC_DOUBLE("HP Channel Switch", RT5645_HP_VOL,
+	SOC_DOUBLE("Headphone Channel Switch", RT5645_HP_VOL,
 		RT5645_VOL_L_SFT, RT5645_VOL_R_SFT, 1, 1),
-	SOC_DOUBLE_TLV("HP Playback Volume", RT5645_HP_VOL,
+	SOC_DOUBLE_TLV("Headphone Playback Volume", RT5645_HP_VOL,
 		RT5645_L_VOL_SFT, RT5645_R_VOL_SFT, 39, 1, out_vol_tlv),
 
 	/* OUTPUT Control */
-- 
2.2.0.rc0.207.ga3a616c
