From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 083/102] ASoC: ak4535: Use
	SOC_ENUM_SINGLE_CONST()
Date: Tue, 18 Feb 2014 12:51:29 +0100
Message-ID: <1392724308-13375-3-git-send-email-tiwai@suse.de>
References: <1392724308-13375-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0151F26575E
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 12:51:52 +0100 (CET)
In-Reply-To: <1392724308-13375-1-git-send-email-tiwai@suse.de>
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

... for improving readability and maintainability.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/ak4535.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/ak4535.c b/sound/soc/codecs/ak4535.c
index 684fe910669f..143ef8a309dc 100644
--- a/sound/soc/codecs/ak4535.c
+++ b/sound/soc/codecs/ak4535.c
@@ -72,11 +72,11 @@ static const char *ak4535_deemp[] = {"44.1kHz", "Off", "48kHz", "32kHz"};
 static const char *ak4535_mic_select[] = {"Internal", "External"};
 
 static const struct soc_enum ak4535_enum[] = {
-	SOC_ENUM_SINGLE(AK4535_SIG1, 7, 2, ak4535_mono_gain),
-	SOC_ENUM_SINGLE(AK4535_SIG1, 6, 2, ak4535_mono_out),
-	SOC_ENUM_SINGLE(AK4535_MODE2, 2, 2, ak4535_hp_out),
-	SOC_ENUM_SINGLE(AK4535_DAC, 0, 4, ak4535_deemp),
-	SOC_ENUM_SINGLE(AK4535_MIC, 1, 2, ak4535_mic_select),
+	SOC_ENUM_SINGLE_CONST(AK4535_SIG1, 7, ak4535_mono_gain),
+	SOC_ENUM_SINGLE_CONST(AK4535_SIG1, 6, ak4535_mono_out),
+	SOC_ENUM_SINGLE_CONST(AK4535_MODE2, 2, ak4535_hp_out),
+	SOC_ENUM_SINGLE_CONST(AK4535_DAC, 0, ak4535_deemp),
+	SOC_ENUM_SINGLE_CONST(AK4535_MIC, 1, ak4535_mic_select),
 };
 
 static const struct snd_kcontrol_new ak4535_snd_controls[] = {
-- 
1.8.5.2
