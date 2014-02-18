From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 010/102] ASoC: ssm2518: Remove superfluous const
Date: Tue, 18 Feb 2014 12:32:22 +0100
Message-ID: <1392723148-12597-8-git-send-email-tiwai@suse.de>
References: <1392723148-12597-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 90F82265357
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 12:32:33 +0100 (CET)
In-Reply-To: <1392723148-12597-1-git-send-email-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

As SOC_ENUM_SINGLE_DECL() itself contains const modifier now, we can
reduce const from its users.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/ssm2518.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/ssm2518.c b/sound/soc/codecs/ssm2518.c
index cc8debce752f..806f3d826ffb 100644
--- a/sound/soc/codecs/ssm2518.c
+++ b/sound/soc/codecs/ssm2518.c
@@ -169,19 +169,19 @@ static const char * const ssm2518_drc_hold_time_text[] = {
 	"682.24 ms", "1364 ms",
 };
 
-static const SOC_ENUM_SINGLE_DECL(ssm2518_drc_peak_detector_attack_time_enum,
+static SOC_ENUM_SINGLE_DECL(ssm2518_drc_peak_detector_attack_time_enum,
 	SSM2518_REG_DRC_2, 4, ssm2518_drc_peak_detector_attack_time_text);
-static const SOC_ENUM_SINGLE_DECL(ssm2518_drc_peak_detector_release_time_enum,
+static SOC_ENUM_SINGLE_DECL(ssm2518_drc_peak_detector_release_time_enum,
 	SSM2518_REG_DRC_2, 0, ssm2518_drc_peak_detector_release_time_text);
-static const SOC_ENUM_SINGLE_DECL(ssm2518_drc_attack_time_enum,
+static SOC_ENUM_SINGLE_DECL(ssm2518_drc_attack_time_enum,
 	SSM2518_REG_DRC_6, 4, ssm2518_drc_peak_detector_attack_time_text);
-static const SOC_ENUM_SINGLE_DECL(ssm2518_drc_decay_time_enum,
+static SOC_ENUM_SINGLE_DECL(ssm2518_drc_decay_time_enum,
 	SSM2518_REG_DRC_6, 0, ssm2518_drc_peak_detector_release_time_text);
-static const SOC_ENUM_SINGLE_DECL(ssm2518_drc_hold_time_enum,
+static SOC_ENUM_SINGLE_DECL(ssm2518_drc_hold_time_enum,
 	SSM2518_REG_DRC_7, 4, ssm2518_drc_hold_time_text);
-static const SOC_ENUM_SINGLE_DECL(ssm2518_drc_noise_gate_hold_time_enum,
+static SOC_ENUM_SINGLE_DECL(ssm2518_drc_noise_gate_hold_time_enum,
 	SSM2518_REG_DRC_7, 0, ssm2518_drc_hold_time_text);
-static const SOC_ENUM_SINGLE_DECL(ssm2518_drc_rms_averaging_time_enum,
+static SOC_ENUM_SINGLE_DECL(ssm2518_drc_rms_averaging_time_enum,
 	SSM2518_REG_DRC_9, 0, ssm2518_drc_peak_detector_release_time_text);
 
 static const struct snd_kcontrol_new ssm2518_snd_controls[] = {
-- 
1.8.5.2
