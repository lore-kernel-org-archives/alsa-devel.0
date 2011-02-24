From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: soc-dapm: Include quotes around contents
	in debugfs entries
Date: Thu, 24 Feb 2011 17:09:32 +0000
Message-ID: <1298567372-7030-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A266824439
	for <alsa-devel@alsa-project.org>; Thu, 24 Feb 2011 18:09:34 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Sometimes the name of the control switch of a dapm route contains
spaces which makes it impossible to distinguish it from the source widget.
Add quotes around the names of the widgets to makes these parsable.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 200ae7c..b8e6ab7 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1242,7 +1242,7 @@ static ssize_t dapm_widget_power_read_file(struct file *file,
 
 		if (p->connect)
 			ret += snprintf(buf + ret, PAGE_SIZE - ret,
-					" in  %s %s\n",
+					" in  \"%s\" \"%s\"\n",
 					p->name ? p->name : "static",
 					p->source->name);
 	}
@@ -1252,7 +1252,7 @@ static ssize_t dapm_widget_power_read_file(struct file *file,
 
 		if (p->connect)
 			ret += snprintf(buf + ret, PAGE_SIZE - ret,
-					" out %s %s\n",
+					" out \"%s\" \"%s\"\n",
 					p->name ? p->name : "static",
 					p->sink->name);
 	}
-- 
1.7.4.1
