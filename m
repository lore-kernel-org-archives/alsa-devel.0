From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 006/102] ASoC: lm49453: Remove superfluous const
Date: Tue, 18 Feb 2014 12:32:18 +0100
Message-ID: <1392723148-12597-4-git-send-email-tiwai@suse.de>
References: <1392723148-12597-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 66B45265294
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
 sound/soc/codecs/lm49453.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/lm49453.c b/sound/soc/codecs/lm49453.c
index e19490cfb3a8..6b7fe5e54881 100644
--- a/sound/soc/codecs/lm49453.c
+++ b/sound/soc/codecs/lm49453.c
@@ -195,18 +195,18 @@ struct lm49453_priv {
 
 static const char *lm49453_mic2mode_text[] = {"Single Ended", "Differential"};
 
-static const SOC_ENUM_SINGLE_DECL(lm49453_mic2mode_enum, LM49453_P0_MICR_REG, 5,
-				  lm49453_mic2mode_text);
+static SOC_ENUM_SINGLE_DECL(lm49453_mic2mode_enum, LM49453_P0_MICR_REG, 5,
+			    lm49453_mic2mode_text);
 
 static const char *lm49453_dmic_cfg_text[] = {"DMICDAT1", "DMICDAT2"};
 
-static const SOC_ENUM_SINGLE_DECL(lm49453_dmic12_cfg_enum,
-				  LM49453_P0_DIGITAL_MIC1_CONFIG_REG,
-				  7, lm49453_dmic_cfg_text);
+static SOC_ENUM_SINGLE_DECL(lm49453_dmic12_cfg_enum,
+			    LM49453_P0_DIGITAL_MIC1_CONFIG_REG, 7,
+			    lm49453_dmic_cfg_text);
 
-static const SOC_ENUM_SINGLE_DECL(lm49453_dmic34_cfg_enum,
-				  LM49453_P0_DIGITAL_MIC2_CONFIG_REG,
-				  7, lm49453_dmic_cfg_text);
+static SOC_ENUM_SINGLE_DECL(lm49453_dmic34_cfg_enum,
+			    LM49453_P0_DIGITAL_MIC2_CONFIG_REG, 7,
+			    lm49453_dmic_cfg_text);
 
 /* MUX Controls */
 static const char *lm49453_adcl_mux_text[] = { "MIC1", "Aux_L" };
-- 
1.8.5.2
