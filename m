From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Check return value of struct_strtoul()
	in pmdown_time_set()
Date: Wed, 27 Oct 2010 20:13:55 -0700
Message-ID: <1288235635-27275-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5134E1037EC
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Oct 2010 05:13:49 +0200 (CEST)
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

strict_strtoul() has just been made must check so do so.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 70d9a73..805343f 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -165,8 +165,11 @@ static ssize_t pmdown_time_set(struct device *dev,
 {
 	struct snd_soc_pcm_runtime *rtd =
 			container_of(dev, struct snd_soc_pcm_runtime, dev);
+	int ret;
 
-	strict_strtol(buf, 10, &rtd->pmdown_time);
+	ret = strict_strtol(buf, 10, &rtd->pmdown_time);
+	if (ret)
+		return ret;
 
 	return count;
 }
-- 
1.7.1
