From: Curtis Malainey <cujomalainey@chromium.org>
Subject: [PATCH] ASoC: rt5677: use more of the volume range
	from DACs
Date: Mon,  6 May 2019 13:30:06 -0700
Message-ID: <20190506203006.161158-1-cujomalainey@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A4B8FF80C07
 for <alsa-devel@alsa-project.org>; Mon,  6 May 2019 22:30:43 +0200 (CEST)
Received: by mail-pl1-x643.google.com with SMTP id n8so6929426plp.10
 for <alsa-devel@alsa-project.org>; Mon, 06 May 2019 13:30:43 -0700 (PDT)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: Oder Chiou <oder_chiou@realtek.com>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Ross Zwisler <zwisler@google.com>, Liam Girdwood <lgirdwood@gmail.com>, Hsinyu Chao <hychao@chromium.org>, Bard Liao <bardliao@realtek.com>, Dylan Reid <dgreid@chromium.org>, Curtis Malainey <cujomalainey@chromium.org>
List-Id: alsa-devel@alsa-project.org

From: Dylan Reid <dgreid@chromium.org>

The DACs volume can go over 0, both according to the data sheet and
real world testing.  The control can go up to +30dB.

This was tested by playing audio at full volume on a samus chromebook.

Signed-off-by: Dylan Reid <dgreid@chromium.org>
Reviewed-by: Hsinyu Chao <hychao@chromium.org>
Signed-off-by: Ross Zwisler <zwisler@google.com>
Signed-off-by: Curtis Malainey <cujomalainey@chromium.org>
---
 sound/soc/codecs/rt5677.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 6fc70e441458..907c957b614d 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -832,13 +832,13 @@ static const struct snd_kcontrol_new rt5677_snd_controls[] = {
 
 	/* DAC Digital Volume */
 	SOC_DOUBLE_TLV("DAC1 Playback Volume", RT5677_DAC1_DIG_VOL,
-		RT5677_L_VOL_SFT, RT5677_R_VOL_SFT, 87, 0, dac_vol_tlv),
+		RT5677_L_VOL_SFT, RT5677_R_VOL_SFT, 127, 0, dac_vol_tlv),
 	SOC_DOUBLE_TLV("DAC2 Playback Volume", RT5677_DAC2_DIG_VOL,
-		RT5677_L_VOL_SFT, RT5677_R_VOL_SFT, 87, 0, dac_vol_tlv),
+		RT5677_L_VOL_SFT, RT5677_R_VOL_SFT, 127, 0, dac_vol_tlv),
 	SOC_DOUBLE_TLV("DAC3 Playback Volume", RT5677_DAC3_DIG_VOL,
-		RT5677_L_VOL_SFT, RT5677_R_VOL_SFT, 87, 0, dac_vol_tlv),
+		RT5677_L_VOL_SFT, RT5677_R_VOL_SFT, 127, 0, dac_vol_tlv),
 	SOC_DOUBLE_TLV("DAC4 Playback Volume", RT5677_DAC4_DIG_VOL,
-		RT5677_L_VOL_SFT, RT5677_R_VOL_SFT, 87, 0, dac_vol_tlv),
+		RT5677_L_VOL_SFT, RT5677_R_VOL_SFT, 127, 0, dac_vol_tlv),
 
 	/* IN1/IN2 Control */
 	SOC_SINGLE_TLV("IN1 Boost", RT5677_IN1, RT5677_BST_SFT1, 8, 0, bst_tlv),
-- 
2.21.0.1020.gf2820cf01a-goog
