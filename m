From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Hook wm_hubs micbiases up to CLK_SYS
Date: Fri, 18 Feb 2011 15:08:51 -0800
Message-ID: <1298070531-11251-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1673F2449F
	for <alsa-devel@alsa-project.org>; Sat, 19 Feb 2011 00:08:34 +0100 (CET)
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

The microphone detection functionality requires a clock to work. In any
non-detection case where the MICBIAS is enabled CLK_SYS will be needed
anyway so there is no negative impact on power consumption.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_hubs.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm_hubs.c b/sound/soc/codecs/wm_hubs.c
index a5c1556..7b6b3c1 100644
--- a/sound/soc/codecs/wm_hubs.c
+++ b/sound/soc/codecs/wm_hubs.c
@@ -675,6 +675,9 @@ SND_SOC_DAPM_OUTPUT("LINEOUT2N"),
 };
 
 static const struct snd_soc_dapm_route analogue_routes[] = {
+	{ "MICBIAS1", NULL, "CLK_SYS" },
+	{ "MICBIAS2", NULL, "CLK_SYS" },
+
 	{ "IN1L PGA", "IN1LP Switch", "IN1LP" },
 	{ "IN1L PGA", "IN1LN Switch", "IN1LN" },
 
-- 
1.7.2.3
