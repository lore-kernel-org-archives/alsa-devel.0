From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/3] ASoC: Add support for on-board analogue
	microphones on Speyside WM8962
Date: Fri, 23 Sep 2011 16:54:05 +0100
Message-ID: <1316793246-819-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1316793246-819-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 14908103871
	for <alsa-devel@alsa-project.org>;
	Fri, 23 Sep 2011 17:54:11 +0200 (CEST)
In-Reply-To: <1316793246-819-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
 sound/soc/samsung/speyside_wm8962.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/sound/soc/samsung/speyside_wm8962.c b/sound/soc/samsung/speyside_wm8962.c
index 35539eb..10c06dc 100644
--- a/sound/soc/samsung/speyside_wm8962.c
+++ b/sound/soc/samsung/speyside_wm8962.c
@@ -141,6 +141,7 @@ static struct snd_soc_dapm_widget widgets[] = {
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
 
 	SND_SOC_DAPM_MIC("DMIC", NULL),
+	SND_SOC_DAPM_MIC("AMIC", NULL),
 
 	SND_SOC_DAPM_SPK("Main Speaker", NULL),
 };
@@ -156,6 +157,10 @@ static struct snd_soc_dapm_route audio_paths[] = {
 	{ "IN4L", NULL, "Headset Mic" },
 	{ "IN4R", NULL, "Headset Mic" },
 
+	{ "AMIC", NULL, "MICBIAS" },
+	{ "IN1L", NULL, "AMIC" },
+	{ "IN1R", NULL, "AMIC" },
+
 	{ "DMIC", NULL, "MICBIAS" },
 	{ "DMICDAT", NULL, "DMIC" },
 };
-- 
1.7.6.3
