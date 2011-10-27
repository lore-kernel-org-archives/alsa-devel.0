From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 04/13] ASoC: Convert wm8960 MICBIAS to a supply
	widget
Date: Thu, 27 Oct 2011 09:54:41 +0200
Message-ID: <1319702091-19273-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20111027075405.GA18360@opensource.wolfsonmicro.com>
	<1319702091-19273-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 829F72465F
	for <alsa-devel@alsa-project.org>;
	Thu, 27 Oct 2011 09:55:01 +0200 (CEST)
In-Reply-To: <1319702091-19273-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8960.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index 2df253c..6e22f9b 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -265,7 +265,7 @@ SND_SOC_DAPM_INPUT("RINPUT2"),
 SND_SOC_DAPM_INPUT("LINPUT3"),
 SND_SOC_DAPM_INPUT("RINPUT3"),
 
-SND_SOC_DAPM_MICBIAS("MICB", WM8960_POWER1, 1, 0),
+SND_SOC_DAPM_SUPPLY("MICB", WM8960_POWER1, 1, 0, NULL, 0),
 
 SND_SOC_DAPM_MIXER("Left Boost Mixer", WM8960_POWER1, 5, 0,
 		   wm8960_lin_boost, ARRAY_SIZE(wm8960_lin_boost)),
-- 
1.7.6.3
