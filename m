From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 05/13] ASoC: Convert wm8961 MICBIAS to a supply
	widget
Date: Thu, 27 Oct 2011 09:54:42 +0200
Message-ID: <1319702091-19273-5-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20111027075405.GA18360@opensource.wolfsonmicro.com>
	<1319702091-19273-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 46FBB24658
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
 sound/soc/codecs/wm8961.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8961.c b/sound/soc/codecs/wm8961.c
index 9568c8a..7f2df7b 100644
--- a/sound/soc/codecs/wm8961.c
+++ b/sound/soc/codecs/wm8961.c
@@ -531,7 +531,7 @@ SND_SOC_DAPM_PGA("Right Input", WM8961_PWR_MGMT_1, 4, 0, NULL, 0),
 SND_SOC_DAPM_ADC("ADCL", "HiFi Capture", WM8961_PWR_MGMT_1, 3, 0),
 SND_SOC_DAPM_ADC("ADCR", "HiFi Capture", WM8961_PWR_MGMT_1, 2, 0),
 
-SND_SOC_DAPM_MICBIAS("MICBIAS", WM8961_PWR_MGMT_1, 1, 0),
+SND_SOC_DAPM_SUPPLY("MICBIAS", WM8961_PWR_MGMT_1, 1, 0, NULL, 0),
 
 SND_SOC_DAPM_MUX("DACL Sidetone", SND_SOC_NOPM, 0, 0, &dacl_mux),
 SND_SOC_DAPM_MUX("DACR Sidetone", SND_SOC_NOPM, 0, 0, &dacr_mux),
-- 
1.7.6.3
