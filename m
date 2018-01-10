From: "Fischer, Christian" <fischerc@swissphone.de>
Subject: [PATCH] ASoC: sgtl5000: Fix powerup/down of micbias
Date: Wed, 10 Jan 2018 10:07:06 +0000
Message-ID: <DD64F087E8F0B540A1C9216D6716FFBDF99455C9@defrsexc01.swissphone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail2.avectris.ch (mail2.avectris.ch [185.94.144.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 08E002676E3
 for <alsa-devel@alsa-project.org>; Wed, 10 Jan 2018 11:07:08 +0100 (CET)
Content-Language: de-DE
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The bias-bias-voltage should powered up/down automatically.
Added missing DAPM_PRE and DAPM_POST widgets to fire up the mic_bias_event function.

--- sound/soc/codecs/sgtl5000.c
+++ sound/soc/codecs/sgtl5000.c
@@ -260,6 +260,9 @@ static const struct snd_soc_dapm_widget
                SND_SOC_DAPM_PRE("VAG_POWER_PRE", power_vag_event),
               SND_SOC_DAPM_POST("VAG_POWER_POST", power_vag_event),
+
+             SND_SOC_DAPM_PRE("MIC_BIAS_PRE", mic_bias_event),
+             SND_SOC_DAPM_POST("MIC_BIAS_POST", mic_bias_event),
};
 /* routes for sgtl5000 */
