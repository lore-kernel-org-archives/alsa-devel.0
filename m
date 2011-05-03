From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: Remove outdated FIXME from WM8915
Date: Tue,  3 May 2011 19:43:18 +0100
Message-ID: <1304448198-6189-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1304448198-6189-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2762F243B3
	for <alsa-devel@alsa-project.org>;
	Tue,  3 May 2011 20:43:11 +0200 (CEST)
In-Reply-To: <1304448198-6189-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Actually the current code is perfectly sensible given the hardware.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8915.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8915.c b/sound/soc/codecs/wm8915.c
index 0dc1dd7..ccc9bd8 100644
--- a/sound/soc/codecs/wm8915.c
+++ b/sound/soc/codecs/wm8915.c
@@ -1001,7 +1001,6 @@ SND_SOC_DAPM_PGA("IN1R", WM8915_POWER_MANAGEMENT_7, 3, 0, NULL, 0),
 SND_SOC_DAPM_PGA("IN2L", WM8915_POWER_MANAGEMENT_7, 6, 0, NULL, 0),
 SND_SOC_DAPM_PGA("IN2R", WM8915_POWER_MANAGEMENT_7, 7, 0, NULL, 0),
 
-/* FIXME - these need to be concentrator widgets */
 SND_SOC_DAPM_SUPPLY("DMIC2", WM8915_POWER_MANAGEMENT_7, 9, 0, NULL, 0),
 SND_SOC_DAPM_SUPPLY("DMIC1", WM8915_POWER_MANAGEMENT_7, 8, 0, NULL, 0),
 
-- 
1.7.4.1
