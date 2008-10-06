From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2.6.27?] ASoC: Correct inverted Mic PGA Switch
	control in wm8510 driver
Date: Mon,  6 Oct 2008 11:33:21 +0100
Message-ID: <1223289201-29091-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2B58824400
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Oct 2008 12:33:22 +0200 (CEST)
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

Mic PGA Switch should be inverted in the WM8510 driver but isn't.

Reported-by: ext-jukka.hynninen@vaisala.com
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8510.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8510.c b/sound/soc/codecs/wm8510.c
index 75ed041..9a37c8d 100644
--- a/sound/soc/codecs/wm8510.c
+++ b/sound/soc/codecs/wm8510.c
@@ -199,7 +199,7 @@ SOC_DAPM_SINGLE("PCM Playback Switch", WM8510_MONOMIX, 0, 1, 0),
 };
 
 static const struct snd_kcontrol_new wm8510_boost_controls[] = {
-SOC_DAPM_SINGLE("Mic PGA Switch", WM8510_INPPGA,  6, 1, 0),
+SOC_DAPM_SINGLE("Mic PGA Switch", WM8510_INPPGA,  6, 1, 1),
 SOC_DAPM_SINGLE("Aux Volume", WM8510_ADCBOOST, 0, 7, 0),
 SOC_DAPM_SINGLE("Mic Volume", WM8510_ADCBOOST, 4, 7, 0),
 };
-- 
1.5.6.5
