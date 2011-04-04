From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Add bias level data to DAPM context
	debugfs
Date: Mon,  4 Apr 2011 20:54:45 +0900
Message-ID: <1301918085-26526-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A823C10397B
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Apr 2011 15:32:23 +0200 (CEST)
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

This is also in the old sysfs diagnostics but it's nice to have everything
in one place.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index c9196d6..b193a95 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1204,6 +1204,47 @@ static const struct file_operations dapm_widget_power_fops = {
 	.llseek = default_llseek,
 };
 
+static int dapm_bias_open_file(struct inode *inode, struct file *file)
+{
+	file->private_data = inode->i_private;
+	return 0;
+}
+
+static ssize_t dapm_bias_read_file(struct file *file, char __user *user_buf,
+				   size_t count, loff_t *ppos)
+{
+	struct snd_soc_dapm_context *dapm = file->private_data;
+	char *level;
+
+	switch (dapm->bias_level) {
+	case SND_SOC_BIAS_ON:
+		level = "On\n";
+		break;
+	case SND_SOC_BIAS_PREPARE:
+		level = "Prepare\n";
+		break;
+	case SND_SOC_BIAS_STANDBY:
+		level = "Standby\n";
+		break;
+	case SND_SOC_BIAS_OFF:
+		level = "Off\n";
+		break;
+	default:
+		BUG();
+		level = "Unknown\n";
+		break;
+	}
+
+	return simple_read_from_buffer(user_buf, count, ppos, level,
+				       strlen(level));
+}
+
+static const struct file_operations dapm_bias_fops = {
+	.open = dapm_bias_open_file,
+	.read = dapm_bias_read_file,
+	.llseek = default_llseek,
+};
+
 void snd_soc_dapm_debugfs_init(struct snd_soc_dapm_context *dapm)
 {
 	struct snd_soc_dapm_widget *w;
@@ -1212,6 +1253,13 @@ void snd_soc_dapm_debugfs_init(struct snd_soc_dapm_context *dapm)
 	if (!dapm->debugfs_dapm)
 		return;
 
+	d = debugfs_create_file("bias_level", 0444,
+				dapm->debugfs_dapm, dapm,
+				&dapm_bias_fops);
+	if (!d)
+		dev_warn(dapm->dev,
+			 "ASoC: Failed to create bias level debugfs file\n");
+
 	list_for_each_entry(w, &dapm->card->widgets, list) {
 		if (!w->name || w->dapm != dapm)
 			continue;
-- 
1.7.4.1
