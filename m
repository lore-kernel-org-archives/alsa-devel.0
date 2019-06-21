From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 2/2] ASoC: dapm: Adapt for debugfs API change
Date: Fri, 21 Jun 2019 12:33:57 +0100
Message-ID: <20190621113357.8264-2-broonie@kernel.org>
References: <20190621113357.8264-1-broonie@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190621113357.8264-1-broonie@kernel.org>
Sender: stable-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Back in ff9fb72bc07705c (debugfs: return error values, not NULL) the
debugfs APIs were changed to return error pointers rather than NULL
pointers on error, breaking the error checking in ASoC. Update the
code to use IS_ERR() and log the codes that are returned as part of
the error messages.

Fixes: ff9fb72bc07705c (debugfs: return error values, not NULL)
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 sound/soc/soc-dapm.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 6b44b4a78b8e..f013b24c050a 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2156,23 +2156,25 @@ void snd_soc_dapm_debugfs_init(struct snd_soc_dapm_context *dapm,
 {
 	struct dentry *d;
 
-	if (!parent)
+	if (!parent || IS_ERR(parent))
 		return;
 
 	dapm->debugfs_dapm = debugfs_create_dir("dapm", parent);
 
-	if (!dapm->debugfs_dapm) {
+	if (IS_ERR(dapm->debugfs_dapm)) {
 		dev_warn(dapm->dev,
-		       "ASoC: Failed to create DAPM debugfs directory\n");
+			 "ASoC: Failed to create DAPM debugfs directory %ld\n",
+			 PTR_ERR(dapm->debugfs_dapm));
 		return;
 	}
 
 	d = debugfs_create_file("bias_level", 0444,
 				dapm->debugfs_dapm, dapm,
 				&dapm_bias_fops);
-	if (!d)
+	if (IS_ERR(d))
 		dev_warn(dapm->dev,
-			 "ASoC: Failed to create bias level debugfs file\n");
+			 "ASoC: Failed to create bias level debugfs file: %ld\n",
+			 PTR_ERR(d));
 }
 
 static void dapm_debugfs_add_widget(struct snd_soc_dapm_widget *w)
@@ -2186,10 +2188,10 @@ static void dapm_debugfs_add_widget(struct snd_soc_dapm_widget *w)
 	d = debugfs_create_file(w->name, 0444,
 				dapm->debugfs_dapm, w,
 				&dapm_widget_power_fops);
-	if (!d)
+	if (IS_ERR(d))
 		dev_warn(w->dapm->dev,
-			"ASoC: Failed to create %s debugfs file\n",
-			w->name);
+			 "ASoC: Failed to create %s debugfs file: %ld\n",
+			 w->name, PTR_ERR(d));
 }
 
 static void dapm_debugfs_cleanup(struct snd_soc_dapm_context *dapm)
-- 
2.20.1
