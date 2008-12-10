From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/8] ASoC: TWL4030: Add missing Carkit output
Date: Wed, 10 Dec 2008 20:01:09 +0000
Message-ID: <1228939275-7768-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081210195858.GA4062@rakim.wolfsonmicro.main>
	<1228939275-7768-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2EB9F243C0
	for <alsa-devel@alsa-project.org>; Wed, 10 Dec 2008 21:01:17 +0100 (CET)
In-Reply-To: <1228939275-7768-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

From: Peter Ujfalusi <peter.ujfalusi@nokia.com>

SND_SOC_DAPM_OUTPUT definition for carkitL/R was missing.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/twl4030.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 71ab534..13d5a12 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -761,6 +761,8 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 	SND_SOC_DAPM_OUTPUT("PREDRIVER"),
 	SND_SOC_DAPM_OUTPUT("HSOL"),
 	SND_SOC_DAPM_OUTPUT("HSOR"),
+	SND_SOC_DAPM_OUTPUT("CARKITL"),
+	SND_SOC_DAPM_OUTPUT("CARKITR"),
 	SND_SOC_DAPM_OUTPUT("HFL"),
 	SND_SOC_DAPM_OUTPUT("HFR"),
 
-- 
1.5.6.5
