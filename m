From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 080/102] ASoC: wm5102: Use ARRAY_SIZE() for
	SOC_VALUE_ENUM_SINGLE()
Date: Tue, 18 Feb 2014 12:38:36 +0100
Message-ID: <1392723517-12772-53-git-send-email-tiwai@suse.de>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id BE95A2655EE
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

... to make clear the meaning of the argument.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/wm5102.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index ebffe81daa1d..293dffcb1d2f 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -622,13 +622,16 @@ static const unsigned int wm5102_osr_val[] = {
 
 static const struct soc_enum wm5102_hpout_osr[] = {
 	SOC_VALUE_ENUM_SINGLE(ARIZONA_OUTPUT_PATH_CONFIG_1L,
-			      ARIZONA_OUT1_OSR_SHIFT, 0x7, 3,
+			      ARIZONA_OUT1_OSR_SHIFT, 0x7,
+			      ARRAY_SIZE(wm5102_osr_text),
 			      wm5102_osr_text, wm5102_osr_val),
 	SOC_VALUE_ENUM_SINGLE(ARIZONA_OUTPUT_PATH_CONFIG_2L,
-			      ARIZONA_OUT2_OSR_SHIFT, 0x7, 3,
+			      ARIZONA_OUT2_OSR_SHIFT, 0x7,
+			      ARRAY_SIZE(wm5102_osr_text),
 			      wm5102_osr_text, wm5102_osr_val),
 	SOC_VALUE_ENUM_SINGLE(ARIZONA_OUTPUT_PATH_CONFIG_3L,
-			      ARIZONA_OUT3_OSR_SHIFT, 0x7, 3,
+			      ARIZONA_OUT3_OSR_SHIFT, 0x7,
+			      ARRAY_SIZE(wm5102_osr_text),
 			      wm5102_osr_text, wm5102_osr_val),
 };
 
-- 
1.8.5.2
