From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 040/102] ASoC: stl5000: Use
	SOC_ENUM_SINGLE_DECL()
Date: Tue, 18 Feb 2014 12:37:56 +0100
Message-ID: <1392723517-12772-13-git-send-email-tiwai@suse.de>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 736302655C1
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 12:38:39 +0100 (CET)
In-Reply-To: <1392723517-12772-2-git-send-email-tiwai@suse.de>
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

Just replace with the helper macro.  No functional change at all.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/sgtl5000.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 0fcbe90f3ef2..ab4754a7a88c 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -187,8 +187,9 @@ static const char *adc_mux_text[] = {
 	"MIC_IN", "LINE_IN"
 };
 
-static const struct soc_enum adc_enum =
-SOC_ENUM_SINGLE(SGTL5000_CHIP_ANA_CTRL, 2, 2, adc_mux_text);
+static SOC_ENUM_SINGLE_DECL(adc_enum,
+			    SGTL5000_CHIP_ANA_CTRL, 2,
+			    adc_mux_text);
 
 static const struct snd_kcontrol_new adc_mux =
 SOC_DAPM_ENUM("Capture Mux", adc_enum);
@@ -198,8 +199,9 @@ static const char *dac_mux_text[] = {
 	"DAC", "LINE_IN"
 };
 
-static const struct soc_enum dac_enum =
-SOC_ENUM_SINGLE(SGTL5000_CHIP_ANA_CTRL, 6, 2, dac_mux_text);
+static SOC_ENUM_SINGLE_DECL(dac_enum,
+			    SGTL5000_CHIP_ANA_CTRL, 6,
+			    dac_mux_text);
 
 static const struct snd_kcontrol_new dac_mux =
 SOC_DAPM_ENUM("Headphone Mux", dac_enum);
-- 
1.8.5.2
