From: Peter Ujfalusi <peter.ujfalusi@Nokia.com>
Subject: [PATCHv2 2/2] ASoC: TWL4030: Remove OUTL/R outputs
Date: Wed, 28 Apr 2010 15:50:15 +0300
Message-ID: <1272459015-22789-3-git-send-email-peter.ujfalusi@nokia.com>
References: <1272459015-22789-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 60BC810388E
	for <alsa-devel@alsa-project.org>;
	Wed, 28 Apr 2010 14:50:24 +0200 (CEST)
In-Reply-To: <1272459015-22789-1-git-send-email-peter.ujfalusi@nokia.com>
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
---
 sound/soc/codecs/twl4030.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 78a53e7..816a995 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -1211,8 +1211,6 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 	SND_SOC_DAPM_INPUT("DIGIMIC1"),
 
 	/* Outputs */
-	SND_SOC_DAPM_OUTPUT("OUTL"),
-	SND_SOC_DAPM_OUTPUT("OUTR"),
 	SND_SOC_DAPM_OUTPUT("EARPIECE"),
 	SND_SOC_DAPM_OUTPUT("PREDRIVEL"),
 	SND_SOC_DAPM_OUTPUT("PREDRIVER"),
@@ -1504,8 +1502,6 @@ static const struct snd_soc_dapm_route intercon[] = {
 	/* Must be always connected (for APLL) */
 	{"APLL", NULL, "Digital Voice Playback Mixer"},
 	/* Physical outputs */
-	{"OUTL", NULL, "Analog L2 Playback Mixer"},
-	{"OUTR", NULL, "Analog R2 Playback Mixer"},
 	{"EARPIECE", NULL, "Earpiece PGA"},
 	{"PREDRIVEL", NULL, "PredriveL PGA"},
 	{"PREDRIVER", NULL, "PredriveR PGA"},
-- 
1.7.0.4
