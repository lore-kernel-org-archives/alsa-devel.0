From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/3] ASoC: Make WM8962 beep a signal generator
Date: Wed, 30 Nov 2011 20:57:05 +0000
Message-ID: <1322686625-16488-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1322686625-16488-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 70F9B103BBE
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
 sound/soc/codecs/wm8962.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 8810988..be35b64 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2675,7 +2675,7 @@ SND_SOC_DAPM_INPUT("IN3L"),
 SND_SOC_DAPM_INPUT("IN3R"),
 SND_SOC_DAPM_INPUT("IN4L"),
 SND_SOC_DAPM_INPUT("IN4R"),
-SND_SOC_DAPM_INPUT("Beep"),
+SND_SOC_DAPM_SIGGEN("Beep"),
 SND_SOC_DAPM_INPUT("DMICDAT"),
 
 SND_SOC_DAPM_SUPPLY("MICBIAS", WM8962_PWR_MGMT_1, 1, 0, NULL, 0),
-- 
1.7.7.3
