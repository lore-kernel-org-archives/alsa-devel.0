From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: dapm: Show if widgets are forced in
	debugfs
Date: Sat,  3 Mar 2012 18:01:28 +0000
Message-ID: <1330797688-14966-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4F5C61039E4
	for <alsa-devel@alsa-project.org>; Sat,  3 Mar 2012 19:01:32 +0100 (CET)
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

The information was not otherwise visible.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 3a5adab..60c851b 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1569,8 +1569,9 @@ static ssize_t dapm_widget_power_read_file(struct file *file,
 	out = is_connected_output_ep(w);
 	dapm_clear_walk(w->dapm);
 
-	ret = snprintf(buf, PAGE_SIZE, "%s: %s  in %d out %d",
-		       w->name, w->power ? "On" : "Off", in, out);
+	ret = snprintf(buf, PAGE_SIZE, "%s: %s%s  in %d out %d",
+		       w->name, w->power ? "On" : "Off",
+		       w->force ? " (forced)" : "", in, out);
 
 	if (w->reg >= 0)
 		ret += snprintf(buf + ret, PAGE_SIZE - ret,
-- 
1.7.9.1
