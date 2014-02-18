From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 094/102] ASoC: wm8510: Use
	SOC_ENUM_SINGLE_CONST()
Date: Tue, 18 Feb 2014 12:51:40 +0100
Message-ID: <1392724308-13375-14-git-send-email-tiwai@suse.de>
References: <1392724308-13375-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A48426576E
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
 sound/soc/codecs/wm8510.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm8510.c b/sound/soc/codecs/wm8510.c
index 7df7d4572755..0195765aaa86 100644
--- a/sound/soc/codecs/wm8510.c
+++ b/sound/soc/codecs/wm8510.c
@@ -118,10 +118,10 @@ static const char *wm8510_deemp[] = { "None", "32kHz", "44.1kHz", "48kHz" };
 static const char *wm8510_alc[] = { "ALC", "Limiter" };
 
 static const struct soc_enum wm8510_enum[] = {
-	SOC_ENUM_SINGLE(WM8510_COMP, 1, 4, wm8510_companding), /* adc */
-	SOC_ENUM_SINGLE(WM8510_COMP, 3, 4, wm8510_companding), /* dac */
-	SOC_ENUM_SINGLE(WM8510_DAC,  4, 4, wm8510_deemp),
-	SOC_ENUM_SINGLE(WM8510_ALC3,  8, 2, wm8510_alc),
+	SOC_ENUM_SINGLE_CONST(WM8510_COMP, 1, wm8510_companding), /* adc */
+	SOC_ENUM_SINGLE_CONST(WM8510_COMP, 3, wm8510_companding), /* dac */
+	SOC_ENUM_SINGLE_CONST(WM8510_DAC,  4, wm8510_deemp),
+	SOC_ENUM_SINGLE_CONST(WM8510_ALC3,  8, wm8510_alc),
 };
 
 static const struct snd_kcontrol_new wm8510_snd_controls[] = {
-- 
1.8.5.2
