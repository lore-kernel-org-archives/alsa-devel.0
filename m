From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 086/102] ASoC: max9877: Use
	SOC_ENUM_SINGLE_CONST()
Date: Tue, 18 Feb 2014 12:51:32 +0100
Message-ID: <1392724308-13375-6-git-send-email-tiwai@suse.de>
References: <1392724308-13375-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4CA7C265764
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
 sound/soc/codecs/max9877.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/max9877.c b/sound/soc/codecs/max9877.c
index 29549cdbf4c1..8702bc69a449 100644
--- a/sound/soc/codecs/max9877.c
+++ b/sound/soc/codecs/max9877.c
@@ -63,10 +63,10 @@ static const char *max9877_osc_mode[] = {
 };
 
 static const struct soc_enum max9877_enum[] = {
-	SOC_ENUM_SINGLE(MAX9877_OUTPUT_MODE, 0, ARRAY_SIZE(max9877_out_mode),
-			max9877_out_mode),
-	SOC_ENUM_SINGLE(MAX9877_OUTPUT_MODE, MAX9877_OSC_OFFSET,
-			ARRAY_SIZE(max9877_osc_mode), max9877_osc_mode),
+	SOC_ENUM_SINGLE_CONST(MAX9877_OUTPUT_MODE, 0,
+			      max9877_out_mode),
+	SOC_ENUM_SINGLE_CONST(MAX9877_OUTPUT_MODE, MAX9877_OSC_OFFSET,
+			      max9877_osc_mode),
 };
 
 static const struct snd_kcontrol_new max9877_controls[] = {
-- 
1.8.5.2
