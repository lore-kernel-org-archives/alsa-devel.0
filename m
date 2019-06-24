From: Curtis Malainey <cujomalainey@chromium.org>
Subject: [PATCH] ASoC: rt5677: depop stereo dac
Date: Mon, 24 Jun 2019 13:52:39 -0700
Message-ID: <20190624205239.150516-1-cujomalainey@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AA260F8065B
 for <alsa-devel@alsa-project.org>; Mon, 24 Jun 2019 22:52:48 +0200 (CEST)
Received: by mail-pl1-x644.google.com with SMTP id bi6so7560261plb.12
 for <alsa-devel@alsa-project.org>; Mon, 24 Jun 2019 13:52:48 -0700 (PDT)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Ross Zwisler <zwisler@chromium.org>, Bard Liao <bardliao@realtek.com>, Curtis Malainey <cujomalainey@chromium.org>
List-Id: alsa-devel@alsa-project.org

Upon enabling the ASRC DAC we need a delay to avoid popping the
speakers.

Signed-off-by: Curtis Malainey <cujomalainey@chromium.org>
Cc: Ross Zwisler <zwisler@chromium.org>
---
 sound/soc/codecs/rt5677.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 20b1d03530bd0..c779dc3474f9e 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -2608,7 +2608,8 @@ static const struct snd_soc_dapm_widget rt5677_dapm_widgets[] = {
 	SND_SOC_DAPM_SUPPLY_S("I2S2 ASRC", 1, RT5677_ASRC_1, 1, 0, NULL, 0),
 	SND_SOC_DAPM_SUPPLY_S("I2S3 ASRC", 1, RT5677_ASRC_1, 2, 0, NULL, 0),
 	SND_SOC_DAPM_SUPPLY_S("I2S4 ASRC", 1, RT5677_ASRC_1, 3, 0, NULL, 0),
-	SND_SOC_DAPM_SUPPLY_S("DAC STO ASRC", 1, RT5677_ASRC_2, 14, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("DAC STO ASRC", 1, RT5677_ASRC_2, 14, 0,
+		rt5677_filter_power_event, SND_SOC_DAPM_POST_PMU),
 	SND_SOC_DAPM_SUPPLY_S("DAC MONO2 L ASRC", 1, RT5677_ASRC_2, 13, 0, NULL,
 		0),
 	SND_SOC_DAPM_SUPPLY_S("DAC MONO2 R ASRC", 1, RT5677_ASRC_2, 12, 0, NULL,
-- 
2.22.0.410.gd8fdbe21b5-goog
