From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: core: Upgrade the severity of probe
	deferral errors to dev_err()
Date: Thu,  9 Aug 2012 18:51:41 +0100
Message-ID: <1344534702-3601-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 771902663E1
 for <alsa-devel@alsa-project.org>; Thu,  9 Aug 2012 19:22:01 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King <linux@arm.linux.org.uk>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

In the past when ASoC had a custom probe deferral mechanism people
complained about the logspam it generated and didn't want to know about
the fact that we were doing probe deferral so all the error messages for
it were at dev_dbg(), making diagnostics hard. Now that we have probe
deferral as an accepted thing and it's generating log messages anyway
there's no need to worry about this so upgrade the severity of all the
probe deferral sources to dev_err() so that they are displayed by default.

Also add one for missing aux_devs since there wasn't one.

Reported-by: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 91b096a..97fb881 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -826,7 +826,7 @@ static int soc_bind_dai_link(struct snd_soc_card *card, int num)
 	}
 
 	if (!rtd->cpu_dai) {
-		dev_dbg(card->dev, "CPU DAI %s not registered\n",
+		dev_err(card->dev, "CPU DAI %s not registered\n",
 			dai_link->cpu_dai_name);
 		return -EPROBE_DEFER;
 	}
@@ -857,14 +857,14 @@ static int soc_bind_dai_link(struct snd_soc_card *card, int num)
 		}
 
 		if (!rtd->codec_dai) {
-			dev_dbg(card->dev, "CODEC DAI %s not registered\n",
+			dev_err(card->dev, "CODEC DAI %s not registered\n",
 				dai_link->codec_dai_name);
 			return -EPROBE_DEFER;
 		}
 	}
 
 	if (!rtd->codec) {
-		dev_dbg(card->dev, "CODEC %s not registered\n",
+		dev_err(card->dev, "CODEC %s not registered\n",
 			dai_link->codec_name);
 		return -EPROBE_DEFER;
 	}
@@ -888,7 +888,7 @@ static int soc_bind_dai_link(struct snd_soc_card *card, int num)
 		rtd->platform = platform;
 	}
 	if (!rtd->platform) {
-		dev_dbg(card->dev, "platform %s not registered\n",
+		dev_err(card->dev, "platform %s not registered\n",
 			dai_link->platform_name);
 		return -EPROBE_DEFER;
 	}
@@ -1481,6 +1481,8 @@ static int soc_check_aux_dev(struct snd_soc_card *card, int num)
 			return 0;
 	}
 
+	dev_err(card->dev, "%s not registered\n", aux_dev->codec_name);
+
 	return -EPROBE_DEFER;
 }
 
-- 
1.7.10.4
