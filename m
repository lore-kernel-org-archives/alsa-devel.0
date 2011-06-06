From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 5/6] ASoC: Only provide a default bias level
	update for CODEC contexts
Date: Mon,  6 Jun 2011 19:18:32 +0100
Message-ID: <1307384313-23559-5-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1307384313-23559-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 67BEB24438
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Jun 2011 20:18:37 +0200 (CEST)
In-Reply-To: <1307384313-23559-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

This allows the card driver to use the bias level variable more easily in
multi component systems.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 1682834..34106bc 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -146,10 +146,13 @@ static int snd_soc_dapm_set_bias_level(struct snd_soc_dapm_context *dapm,
 	if (ret != 0)
 		goto out;
 
-	if (dapm->codec && dapm->codec->driver->set_bias_level)
-		ret = dapm->codec->driver->set_bias_level(dapm->codec, level);
-	else
-		dapm->bias_level = level;
+	if (dapm->codec) {
+		if (dapm->codec->driver->set_bias_level)
+			ret = dapm->codec->driver->set_bias_level(dapm->codec,
+								  level);
+		else
+			dapm->bias_level = level;
+	}
 	if (ret != 0)
 		goto out;
 
-- 
1.7.5.3
