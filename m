From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: core: Log a warning when machines use
	soc-audio
Date: Fri,  2 Mar 2012 13:08:13 +0000
Message-ID: <1330693693-23097-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EFE9924409
	for <alsa-devel@alsa-project.org>; Fri,  2 Mar 2012 14:08:14 +0100 (CET)
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

snd_soc_register_card() has been available and strongly preferred since
2.6.38 but we're still seeing new drivers using it and the conversion rate
for older machines has been low. Help address both issues by logging a
warning when the soc-audio device probes.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index f52bf5b..8d2d066 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1644,6 +1644,10 @@ static int soc_probe(struct platform_device *pdev)
 	if (!card)
 		return -EINVAL;
 
+	dev_warn(&pdev->dev,
+		 "ASoC machine %s should use snd_soc_register_card()\n",
+		 card->name);
+
 	/* Bodge while we unpick instantiation */
 	card->dev = &pdev->dev;
 
-- 
1.7.9.1
