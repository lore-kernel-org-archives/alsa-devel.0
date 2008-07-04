From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Fix warning from strict_strtoul()
Date: Fri,  4 Jul 2008 16:01:14 +0100
Message-ID: <1215183674-13038-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 15D4124A74
	for <alsa-devel@alsa-project.org>;
	Fri,  4 Jul 2008 17:01:15 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 9e83357..456d78a 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -808,7 +808,11 @@ static ssize_t dapm_pop_time_store(struct device *dev,
 				   const char *buf, size_t count)
 
 {
-	if (strict_strtoul(buf, 10, &pop_time) < 0)
+	unsigned long val;
+
+	if (strict_strtoul(buf, 10, &val) >= 0)
+		pop_time = val;
+	else
 		printk(KERN_ERR "Unable to parse pop_time setting\n");
 
 	return count;
-- 
1.5.6
