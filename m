From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] wm8990: Fix routing of left DAC to speaker
	mixer
Date: Fri, 15 Aug 2008 16:22:32 +0100
Message-ID: <1218813753-24344-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1496D246EF
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Aug 2008 17:22:35 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8990.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

This ought to go into 2.6.27 - it's a fairly straightforward bug fix.

diff --git a/sound/soc/codecs/wm8990.c b/sound/soc/codecs/wm8990.c
index 3ecce51..9505a18 100644
--- a/sound/soc/codecs/wm8990.c
+++ b/sound/soc/codecs/wm8990.c
@@ -920,7 +920,7 @@ static const struct snd_soc_dapm_route audio_map[] = {
 	{"SPKMIX", "SPKMIX Left Mixer PGA Switch", "LOPGA"},
 	{"SPKMIX", "SPKMIX Right Mixer PGA Switch", "ROPGA"},
 	{"SPKMIX", "SPKMIX Right DAC Switch", "Right DAC"},
-	{"SPKMIX", "SPKMIX Left DAC Switch", "Right DAC"},
+	{"SPKMIX", "SPKMIX Left DAC Switch", "Left DAC"},
 
 	/* LONMIX */
 	{"LONMIX", "LONMIX Left Mixer PGA Switch", "LOPGA"},
-- 
1.5.6.3
