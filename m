From: Nicolas Boichat <drinkcat@chromium.org>
Subject: [PATCH] ASoC: rt5645: Rename HP control to Headphone
Date: Thu, 14 May 2015 08:43:31 +0800
Message-ID: <1431564211-25641-1-git-send-email-drinkcat@chromium.org>
References: <1431504912-30698-1-git-send-email-drinkcat@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f52.google.com (mail-pa0-f52.google.com
 [209.85.220.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A21F2614FF
 for <alsa-devel@alsa-project.org>; Thu, 14 May 2015 02:44:12 +0200 (CEST)
Received: by pabtp1 with SMTP id tp1so66536262pab.2
 for <alsa-devel@alsa-project.org>; Wed, 13 May 2015 17:44:11 -0700 (PDT)
In-Reply-To: <1431504912-30698-1-git-send-email-drinkcat@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Nicolas Boichat <drinkcat@chromium.org>, Koro Chen <koro.chen@mediatek.com>, Bard Liao <bardliao@realtek.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Use the standard name "Headphone" instead of "HP" for better
userspace integration.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
Acked-by: Bard Liao <bardliao@realtek.com>
---

Resending without modification, adding Mark to CC list.

Thanks!

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
2.1.2
