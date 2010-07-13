From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH] ASoC: TWL4030: DAC power optimization
Date: Tue, 13 Jul 2010 12:07:44 +0300
Message-ID: <1279012064-684-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id CF915243BC
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Jul 2010 11:07:57 +0200 (CEST)
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

Restructure the DAPM connections in order to enable
only the needed DAC (out of four in twl4030 series).
I need to keep the 'AIF Enable' supply connected to
the L2/R2 digital path, since the digital loopback
needs AIF and APLL running.
If no valid route available, than none of the DAC will
be powered, but the AIF and APLL is going to be enabled.
Furthermore, if only one audio path have valid route,
than only the corresponding DAC will be powered.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index d7f0048..6fd6d0b 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -1460,8 +1460,11 @@ static const struct snd_soc_dapm_route intercon[] = {
 	/* Supply for the digital part (APLL) */
 	{"Digital Voice Playback Mixer", NULL, "APLL Enable"},
 
-	{"Digital R1 Playback Mixer", NULL, "AIF Enable"},
-	{"Digital L1 Playback Mixer", NULL, "AIF Enable"},
+	{"DAC Left1", NULL, "AIF Enable"},
+	{"DAC Right1", NULL, "AIF Enable"},
+	{"DAC Left2", NULL, "AIF Enable"},
+	{"DAC Right1", NULL, "AIF Enable"},
+
 	{"Digital R2 Playback Mixer", NULL, "AIF Enable"},
 	{"Digital L2 Playback Mixer", NULL, "AIF Enable"},
 
@@ -1532,10 +1535,10 @@ static const struct snd_soc_dapm_route intercon[] = {
 
 	/* outputs */
 	/* Must be always connected (for AIF and APLL) */
-	{"Virtual HiFi OUT", NULL, "Digital L1 Playback Mixer"},
-	{"Virtual HiFi OUT", NULL, "Digital R1 Playback Mixer"},
-	{"Virtual HiFi OUT", NULL, "Digital L2 Playback Mixer"},
-	{"Virtual HiFi OUT", NULL, "Digital R2 Playback Mixer"},
+	{"Virtual HiFi OUT", NULL, "DAC Left1"},
+	{"Virtual HiFi OUT", NULL, "DAC Right1"},
+	{"Virtual HiFi OUT", NULL, "DAC Left2"},
+	{"Virtual HiFi OUT", NULL, "DAC Right2"},
 	/* Must be always connected (for APLL) */
 	{"Virtual Voice OUT", NULL, "Digital Voice Playback Mixer"},
 	/* Physical outputs */
-- 
1.7.1.1
