From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: core: Allow DAIs to specify a base
	address
Date: Tue,  1 May 2012 20:04:27 +0100
Message-ID: <1335899068-22645-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 03F9F104343
	for <alsa-devel@alsa-project.org>;
	Tue,  1 May 2012 21:04:32 +0200 (CEST)
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

Devices with many DAIs are becoming more and more common, and generally
the more modern devices have consistent register layouts between DAIs.
Rather than have drivers open code lookups based on the DAI ID or cause
uglification in UI by having register addresses for IDs provide a base
address field they can use.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc-dai.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index c63985b..2704ab0 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -198,6 +198,7 @@ struct snd_soc_dai_driver {
 	const char *name;
 	unsigned int id;
 	int ac97_control;
+	unsigned int base;
 
 	/* DAI driver callbacks */
 	int (*probe)(struct snd_soc_dai *dai);
-- 
1.7.10
