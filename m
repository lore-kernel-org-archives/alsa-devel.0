From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/4] ASoC: Remove DAPM debugfs entries before
	freeing widgets
Date: Sat, 30 Apr 2011 19:45:50 +0200
Message-ID: <1304185550-12003-4-git-send-email-lars@metafoo.de>
References: <1304185550-12003-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-170.synserver.de (smtp-out-171.synserver.de
	[212.40.185.171]) by alsa0.perex.cz (Postfix) with SMTP id 14850244EF
	for <alsa-devel@alsa-project.org>;
	Sat, 30 Apr 2011 19:46:09 +0200 (CEST)
In-Reply-To: <1304185550-12003-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Remove the DAPM debugfs entries before freeing the context's widgets, otherwise a
use after free situation might occur.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-dapm.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 8454cc2..169e176 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1292,6 +1292,11 @@ static void dapm_debugfs_add_widget(struct snd_soc_dapm_widget *w)
 			w->name);
 }
 
+static void dapm_debugfs_cleanup(struct snd_soc_dapm_context *dapm)
+{
+	debugfs_remove_recursive(dapm->debugfs_dapm);
+}
+
 #else
 void snd_soc_dapm_debugfs_init(struct snd_soc_dapm_context *dapm,
 	struct dentry *parent)
@@ -1302,6 +1307,10 @@ static inline void dapm_debugfs_add_widget(struct snd_soc_dapm_widget *w)
 {
 }
 
+static inline void dapm_debugfs_cleanup(struct snd_soc_dapm_context *dapm)
+{
+}
+
 #endif
 
 /* test and update the power status of a mux widget */
@@ -2445,6 +2454,7 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_ignore_suspend);
 void snd_soc_dapm_free(struct snd_soc_dapm_context *dapm)
 {
 	snd_soc_dapm_sys_remove(dapm->dev);
+	dapm_debugfs_cleanup(dapm);
 	dapm_free_widgets(dapm);
 	list_del(&dapm->list);
 }
-- 
1.7.2.5
