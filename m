From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/3] ASoC: Make WM5100 tone generator widgets
	signal generators
Date: Wed, 30 Nov 2011 20:57:04 +0000
Message-ID: <1322686625-16488-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1322686625-16488-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6DD67103BBC
	for <alsa-devel@alsa-project.org>; Wed, 30 Nov 2011 21:57:09 +0100 (CET)
In-Reply-To: <1322686625-16488-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
 sound/soc/codecs/wm5100.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm5100.c b/sound/soc/codecs/wm5100.c
index 8be5dae..a234b70 100644
--- a/sound/soc/codecs/wm5100.c
+++ b/sound/soc/codecs/wm5100.c
@@ -952,7 +952,7 @@ SND_SOC_DAPM_INPUT("IN3L"),
 SND_SOC_DAPM_INPUT("IN3R"),
 SND_SOC_DAPM_INPUT("IN4L"),
 SND_SOC_DAPM_INPUT("IN4R"),
-SND_SOC_DAPM_INPUT("TONE"),
+SND_SOC_DAPM_SIGGEN("TONE"),
 
 SND_SOC_DAPM_PGA_E("IN1L PGA", WM5100_INPUT_ENABLES, WM5100_IN1L_ENA_SHIFT, 0,
 		   NULL, 0, wm5100_out_ev, SND_SOC_DAPM_POST_PMU),
-- 
1.7.7.3
