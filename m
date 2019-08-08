From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: sof: Fix warning when IPC flood test is
	not enabled
Date: Thu,  8 Aug 2019 23:18:50 +0100
Message-ID: <20190808221850.25963-1-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D3456F803F3
 for <alsa-devel@Alsa-project.org>; Fri,  9 Aug 2019 00:18:55 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@Alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

dentry is only used when the flood test is done so move the declaration
of the variable inside the ifdef for the flood test.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/debug.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/debug.c b/sound/soc/sof/debug.c
index 40940b2fe9d5..54cd431faab7 100644
--- a/sound/soc/sof/debug.c
+++ b/sound/soc/sof/debug.c
@@ -221,7 +221,6 @@ static ssize_t sof_dfsentry_read(struct file *file, char __user *buffer,
 {
 	struct snd_sof_dfsentry *dfse = file->private_data;
 	struct snd_sof_dev *sdev = dfse->sdev;
-	struct dentry *dentry;
 	loff_t pos = *ppos;
 	size_t size_ret;
 	int skip = 0;
@@ -229,6 +228,8 @@ static ssize_t sof_dfsentry_read(struct file *file, char __user *buffer,
 	u8 *buf;
 
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_DEBUG_IPC_FLOOD_TEST)
+	struct dentry *dentry;
+
 	dentry = file->f_path.dentry;
 	if ((!strcmp(dentry->d_name.name, "ipc_flood_count") ||
 	     !strcmp(dentry->d_name.name, "ipc_flood_duration_ms")) &&
-- 
2.20.1
