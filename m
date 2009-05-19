From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 1/1] ASoC: TWL4030: Fix Analog capture path for
	AUXR
Date: Tue, 19 May 2009 10:51:03 +0300
Message-ID: <1242719463-17508-2-git-send-email-peter.ujfalusi@nokia.com>
References: <1242719463-17508-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id AD22F103891
	for <alsa-devel@alsa-project.org>;
	Tue, 19 May 2009 09:51:22 +0200 (CEST)
In-Reply-To: <1242719463-17508-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: sakoman@gmail.com, anuj.aggarwal@ti.com, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

AUXR is selected by bit 2 and not by bit 1 in the ANAMICR register.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index afe7879..70d9500 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -438,7 +438,7 @@ static const struct snd_kcontrol_new twl4030_dapm_analoglmic_controls[] = {
 /* Right analog microphone selection */
 static const struct snd_kcontrol_new twl4030_dapm_analogrmic_controls[] = {
 	SOC_DAPM_SINGLE("Sub mic", TWL4030_REG_ANAMICR, 0, 1, 0),
-	SOC_DAPM_SINGLE("AUXR", TWL4030_REG_ANAMICR, 1, 1, 0),
+	SOC_DAPM_SINGLE("AUXR", TWL4030_REG_ANAMICR, 2, 1, 0),
 };
 
 /* TX1 L/R Analog/Digital microphone selection */
-- 
1.6.3
