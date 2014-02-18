From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 059/102] ASoC: wm8995: Use
	SOC_ENUM_SINGLE_DECL()
Date: Tue, 18 Feb 2014 12:38:15 +0100
Message-ID: <1392723517-12772-32-git-send-email-tiwai@suse.de>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D3B92655D3
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
 sound/soc/codecs/wm8995.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm8995.c b/sound/soc/codecs/wm8995.c
index b5e3ab094fb6..33ff361250a8 100644
--- a/sound/soc/codecs/wm8995.c
+++ b/sound/soc/codecs/wm8995.c
@@ -781,14 +781,12 @@ static const char *sidetone_text[] = {
 	"ADC/DMIC1", "DMIC2",
 };
 
-static const struct soc_enum sidetone1_enum =
-	SOC_ENUM_SINGLE(WM8995_SIDETONE, 0, 2, sidetone_text);
+static SOC_ENUM_SINGLE_DECL(sidetone1_enum, WM8995_SIDETONE, 0, sidetone_text);
 
 static const struct snd_kcontrol_new sidetone1_mux =
 	SOC_DAPM_ENUM("Left Sidetone Mux", sidetone1_enum);
 
-static const struct soc_enum sidetone2_enum =
-	SOC_ENUM_SINGLE(WM8995_SIDETONE, 1, 2, sidetone_text);
+static SOC_ENUM_SINGLE_DECL(sidetone2_enum, WM8995_SIDETONE, 1, sidetone_text);
 
 static const struct snd_kcontrol_new sidetone2_mux =
 	SOC_DAPM_ENUM("Right Sidetone Mux", sidetone2_enum);
@@ -884,8 +882,7 @@ static const char *adc_mux_text[] = {
 	"DMIC",
 };
 
-static const struct soc_enum adc_enum =
-	SOC_ENUM_SINGLE(0, 0, 2, adc_mux_text);
+static const SOC_ENUM_SINGLE_DECL(adc_enum, 0, 0, adc_mux_text);
 
 static const struct snd_kcontrol_new adcl_mux =
 	SOC_DAPM_ENUM_VIRT("ADCL Mux", adc_enum);
-- 
1.8.5.2
