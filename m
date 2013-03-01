From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/3] ASoC: wm8960: Fix ADC power bits
Date: Fri,  1 Mar 2013 18:15:36 +0800
Message-ID: <1362132936-31597-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1362132936-31597-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 53278265DD9
 for <alsa-devel@alsa-project.org>; Fri,  1 Mar 2013 11:16:48 +0100 (CET)
In-Reply-To: <1362132936-31597-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8960.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index c737a5b..0a4ffdd 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -333,8 +333,8 @@ SND_SOC_DAPM_MIXER("Left Input Mixer", WM8960_POWER3, 5, 0,
 SND_SOC_DAPM_MIXER("Right Input Mixer", WM8960_POWER3, 4, 0,
 		   wm8960_rin, ARRAY_SIZE(wm8960_rin)),
 
-SND_SOC_DAPM_ADC("Left ADC", "Capture", WM8960_POWER2, 3, 0),
-SND_SOC_DAPM_ADC("Right ADC", "Capture", WM8960_POWER2, 2, 0),
+SND_SOC_DAPM_ADC("Left ADC", "Capture", WM8960_POWER1, 3, 0),
+SND_SOC_DAPM_ADC("Right ADC", "Capture", WM8960_POWER1, 2, 0),
 
 SND_SOC_DAPM_DAC("Left DAC", "Playback", WM8960_POWER2, 8, 0),
 SND_SOC_DAPM_DAC("Right DAC", "Playback", WM8960_POWER2, 7, 0),
-- 
1.7.10.4
