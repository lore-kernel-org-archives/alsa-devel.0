From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 084/102] ASoC: arizona: Use
	SOC_ENUM_SINGLE_CONST()
Date: Tue, 18 Feb 2014 12:51:30 +0100
Message-ID: <1392724308-13375-4-git-send-email-tiwai@suse.de>
References: <1392724308-13375-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id EC3F5265738
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 12:51:51 +0100 (CET)
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
 sound/soc/codecs/arizona.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index a32b84ac03f6..53812c5a3d51 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -619,18 +619,14 @@ static const char * const arizona_in_dmic_osr_text[] = {
 };
 
 const struct soc_enum arizona_in_dmic_osr[] = {
-	SOC_ENUM_SINGLE(ARIZONA_IN1L_CONTROL, ARIZONA_IN1_OSR_SHIFT,
-			ARRAY_SIZE(arizona_in_dmic_osr_text),
-			arizona_in_dmic_osr_text),
-	SOC_ENUM_SINGLE(ARIZONA_IN2L_CONTROL, ARIZONA_IN2_OSR_SHIFT,
-			ARRAY_SIZE(arizona_in_dmic_osr_text),
-			arizona_in_dmic_osr_text),
-	SOC_ENUM_SINGLE(ARIZONA_IN3L_CONTROL, ARIZONA_IN3_OSR_SHIFT,
-			ARRAY_SIZE(arizona_in_dmic_osr_text),
-			arizona_in_dmic_osr_text),
-	SOC_ENUM_SINGLE(ARIZONA_IN4L_CONTROL, ARIZONA_IN4_OSR_SHIFT,
-			ARRAY_SIZE(arizona_in_dmic_osr_text),
-			arizona_in_dmic_osr_text),
+	SOC_ENUM_SINGLE_CONST(ARIZONA_IN1L_CONTROL, ARIZONA_IN1_OSR_SHIFT,
+			      arizona_in_dmic_osr_text),
+	SOC_ENUM_SINGLE_CONST(ARIZONA_IN2L_CONTROL, ARIZONA_IN2_OSR_SHIFT,
+			      arizona_in_dmic_osr_text),
+	SOC_ENUM_SINGLE_CONST(ARIZONA_IN3L_CONTROL, ARIZONA_IN3_OSR_SHIFT,
+			      arizona_in_dmic_osr_text),
+	SOC_ENUM_SINGLE_CONST(ARIZONA_IN4L_CONTROL, ARIZONA_IN4_OSR_SHIFT,
+			      arizona_in_dmic_osr_text),
 };
 EXPORT_SYMBOL_GPL(arizona_in_dmic_osr);
 
-- 
1.8.5.2
