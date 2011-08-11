From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Allow userspace control of Speyside
	headphone output
Date: Thu, 11 Aug 2011 11:06:38 +0900
Message-ID: <1313028398-13153-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A35E124425
	for <alsa-devel@alsa-project.org>;
	Thu, 11 Aug 2011 04:06:51 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

In order to facilitate the widest range of use cases (especially things
like speakerphone) allow the headphone output to be enabled and disabled
by the application layer.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/samsung/speyside.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/sound/soc/samsung/speyside.c b/sound/soc/samsung/speyside.c
index 3b63995..67572c9 100644
--- a/sound/soc/samsung/speyside.c
+++ b/sound/soc/samsung/speyside.c
@@ -125,10 +125,6 @@ static struct snd_soc_jack_pin speyside_headset_pins[] = {
 		.pin = "Headset Mic",
 		.mask = SND_JACK_MICROPHONE,
 	},
-	{
-		.pin = "Headphone",
-		.mask = SND_JACK_HEADPHONE,
-	},
 };
 
 /* Default the headphone selection to active high */
@@ -256,6 +252,7 @@ static const struct snd_kcontrol_new controls[] = {
 	SOC_DAPM_PIN_SWITCH("Main AMIC"),
 	SOC_DAPM_PIN_SWITCH("WM1250 Input"),
 	SOC_DAPM_PIN_SWITCH("WM1250 Output"),
+	SOC_DAPM_PIN_SWITCH("Headphone"),
 };
 
 static struct snd_soc_dapm_widget widgets[] = {
-- 
1.7.5.4
