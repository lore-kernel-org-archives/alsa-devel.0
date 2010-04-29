From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCHv3 2/2] ASoC: TWL4030: Remove OUTL/R outputs
Date: Thu, 29 Apr 2010 10:58:09 +0300
Message-ID: <1272527889-22447-3-git-send-email-peter.ujfalusi@nokia.com>
References: <1272527889-22447-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id A58122433C
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Apr 2010 09:58:25 +0200 (CEST)
In-Reply-To: <1272527889-22447-1-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

OUTL/R are leftovers from the original driver, and they
are no longer needed.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/twl4030.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 12931f6..b717a03 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -1194,8 +1194,6 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 	SND_SOC_DAPM_INPUT("DIGIMIC1"),
 
 	/* Outputs */
-	SND_SOC_DAPM_OUTPUT("OUTL"),
-	SND_SOC_DAPM_OUTPUT("OUTR"),
 	SND_SOC_DAPM_OUTPUT("EARPIECE"),
 	SND_SOC_DAPM_OUTPUT("PREDRIVEL"),
 	SND_SOC_DAPM_OUTPUT("PREDRIVER"),
@@ -1487,8 +1485,6 @@ static const struct snd_soc_dapm_route intercon[] = {
 	/* Must be always connected (for APLL) */
 	{"Virtual Voice OUT", NULL, "Digital Voice Playback Mixer"},
 	/* Physical outputs */
-	{"OUTL", NULL, "Analog L2 Playback Mixer"},
-	{"OUTR", NULL, "Analog R2 Playback Mixer"},
 	{"EARPIECE", NULL, "Earpiece PGA"},
 	{"PREDRIVEL", NULL, "PredriveL PGA"},
 	{"PREDRIVER", NULL, "PredriveR PGA"},
-- 
1.7.0.4
