From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Map microphones on Littlemill
Date: Fri,  2 Dec 2011 17:36:36 +0000
Message-ID: <1322847396-31003-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E9086244C1
	for <alsa-devel@alsa-project.org>; Fri,  2 Dec 2011 18:36:38 +0100 (CET)
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

Littlemill has one analogue microphone on the board (connected to IN1LN)
and an array of four DMICs connected to both DMICDAT lines. The biases
can be selected by jumpers but pick the default jumper fit.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/samsung/littlemill.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/sound/soc/samsung/littlemill.c b/sound/soc/samsung/littlemill.c
index 5d7680f..5cea59b 100644
--- a/sound/soc/samsung/littlemill.c
+++ b/sound/soc/samsung/littlemill.c
@@ -147,11 +147,21 @@ static struct snd_soc_dai_link littlemill_dai[] = {
 
 static struct snd_soc_dapm_widget widgets[] = {
 	SND_SOC_DAPM_HP("Headphone", NULL),
+
+	SND_SOC_DAPM_MIC("AMIC", NULL),
+	SND_SOC_DAPM_MIC("DMIC", NULL),
 };
 
 static struct snd_soc_dapm_route audio_paths[] = {
 	{ "Headphone", NULL, "HPOUT1L" },
 	{ "Headphone", NULL, "HPOUT1R" },
+
+	{ "AMIC", NULL, "MICBIAS1" },   /* Default for AMICBIAS jumper */
+	{ "IN1LN", NULL, "AMIC" },
+
+	{ "DMIC", NULL, "MICBIAS2" },   /* Default for DMICBIAS jumper */
+	{ "DMIC1DAT", NULL, "DMIC" },
+	{ "DMIC2DAT", NULL, "DMIC" },
 };
 
 static struct snd_soc_jack littlemill_headset;
-- 
1.7.7.3
