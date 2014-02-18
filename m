From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 081/102] ASoC: wm8997: Use ARRAY_SIZE() for
	SOC_VALUE_ENUM_SINGLE()
Date: Tue, 18 Feb 2014 12:38:37 +0100
Message-ID: <1392723517-12772-54-git-send-email-tiwai@suse.de>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id BE1A32655ED
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
 sound/soc/codecs/wm8997.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8997.c b/sound/soc/codecs/wm8997.c
index 6107108228b6..4e6442ce9a2a 100644
--- a/sound/soc/codecs/wm8997.c
+++ b/sound/soc/codecs/wm8997.c
@@ -123,10 +123,12 @@ static const unsigned int wm8997_osr_val[] = {
 
 static const struct soc_enum wm8997_hpout_osr[] = {
 	SOC_VALUE_ENUM_SINGLE(ARIZONA_OUTPUT_PATH_CONFIG_1L,
-			      ARIZONA_OUT1_OSR_SHIFT, 0x7, 3,
+			      ARIZONA_OUT1_OSR_SHIFT, 0x7,
+			      ARRAY_SIZE(wm8997_osr_text),
 			      wm8997_osr_text, wm8997_osr_val),
 	SOC_VALUE_ENUM_SINGLE(ARIZONA_OUTPUT_PATH_CONFIG_3L,
-			      ARIZONA_OUT3_OSR_SHIFT, 0x7, 3,
+			      ARIZONA_OUT3_OSR_SHIFT, 0x7,
+			      ARRAY_SIZE(wm8997_osr_text),
 			      wm8997_osr_text, wm8997_osr_val),
 };
 
-- 
1.8.5.2
