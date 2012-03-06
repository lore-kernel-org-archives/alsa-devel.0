From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH] ASoC: DAPM - Use dev_err for debugfs error
	message.
Date: Tue,  6 Mar 2012 18:05:20 +0000
Message-ID: <1331057120-3938-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog125.obsmtp.com (na3sys009aog125.obsmtp.com
	[74.125.149.153])
	by alsa0.perex.cz (Postfix) with ESMTP id A85A924396
	for <alsa-devel@alsa-project.org>; Tue,  6 Mar 2012 19:05:28 +0100 (CET)
Received: by mail-ww0-f46.google.com with SMTP id dq11so4460404wgb.15
	for <alsa-devel@alsa-project.org>; Tue, 06 Mar 2012 10:05:25 -0800 (PST)
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

Remove printk(KERN_ERR) and use dev_err() instead.

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 sound/soc/soc-dapm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index a4d4aa1..8ad63b3 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1667,7 +1667,7 @@ void snd_soc_dapm_debugfs_init(struct snd_soc_dapm_context *dapm,
 	dapm->debugfs_dapm = debugfs_create_dir("dapm", parent);
 
 	if (!dapm->debugfs_dapm) {
-		printk(KERN_WARNING
+		dev_err(dapm->dev,
 		       "Failed to create DAPM debugfs directory\n");
 		return;
 	}
-- 
1.7.5.4
