From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 1/3] ASoC: DAPM: Add private data pointer
	for DAPM widget
Date: Fri, 26 Aug 2011 16:33:21 +0300
Message-ID: <1314365603-8947-2-git-send-email-peter.ujfalusi@ti.com>
References: <1314365603-8947-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 09C8E24623
	for <alsa-devel@alsa-project.org>;
	Fri, 26 Aug 2011 15:33:24 +0200 (CEST)
In-Reply-To: <1314365603-8947-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

Support for using custom private data assigned
per DAPM widget.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 include/sound/soc-dapm.h |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index e0583b7..c10d4cc 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -474,6 +474,7 @@ struct snd_soc_dapm_widget {
 	unsigned char force:1;			/* force state */
 	unsigned char ignore_suspend:1;         /* kept enabled over suspend */
 	int subseq;				/* sort within widget type */
+	void *private_data;			/* for widget specific data */
 
 	int (*power_check)(struct snd_soc_dapm_widget *w);
 
@@ -535,4 +536,16 @@ struct snd_soc_dapm_widget_list {
 	struct snd_soc_dapm_widget *widgets[0];
 };
 
+/* Accessors for snd_soc_dapm_widget->private_data */
+static inline void *snd_soc_dapm_widget_get_pdata(struct snd_soc_dapm_widget *w)
+{
+	return w->private_data;
+}
+
+static inline void snd_soc_dapm_widget_set_pdata(struct snd_soc_dapm_widget *w,
+		void *data)
+{
+	w->private_data = data;
+}
+
 #endif
-- 
1.7.6.1
