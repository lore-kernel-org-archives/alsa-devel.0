From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH v2] ASoC: DAPM - Use dev_warn for debugfs
	warning message.
Date: Tue,  6 Mar 2012 18:13:25 +0000
Message-ID: <1331057605-4542-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog114.obsmtp.com (na3sys009aog114.obsmtp.com
	[74.125.149.211])
	by alsa0.perex.cz (Postfix) with ESMTP id 580B324398
	for <alsa-devel@alsa-project.org>; Tue,  6 Mar 2012 19:13:42 +0100 (CET)
Received: by mail-wi0-f182.google.com with SMTP id hn6so3222708wib.41
	for <alsa-devel@alsa-project.org>; Tue, 06 Mar 2012 10:13:28 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Remove printk(KERN_WARNING) and use dev_warn() instead.

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 sound/soc/soc-dapm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index a4d4aa1..dcd1160 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1667,7 +1667,7 @@ void snd_soc_dapm_debugfs_init(struct snd_soc_dapm_context *dapm,
 	dapm->debugfs_dapm = debugfs_create_dir("dapm", parent);
 
 	if (!dapm->debugfs_dapm) {
-		printk(KERN_WARNING
+		dev_warn(dapm->dev,
 		       "Failed to create DAPM debugfs directory\n");
 		return;
 	}
-- 
1.7.5.4
