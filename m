From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH] ASoC: dapm - Add methods to retrieve snd_card
	and soc_card from dapm context.
Date: Wed, 20 Jul 2011 12:23:33 +0100
Message-ID: <1311161013-3515-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 672A51038CD
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Jul 2011 13:23:38 +0200 (CEST)
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

In preparation for ASoC Dynamic PCM (AKA DSP) support.

Provide convenience methods to retrieve the soc_card or snd_card from a DAPM context.

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 sound/soc/soc-dapm.c |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 4205a97..aaef0ef 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -124,6 +124,36 @@ static inline struct snd_soc_dapm_widget *dapm_cnew_widget(
 	return kmemdup(_widget, sizeof(*_widget), GFP_KERNEL);
 }
 
+/* get snd_card from DAPM context */
+static inline struct snd_card *dapm_get_snd_card(
+	struct snd_soc_dapm_context *dapm)
+{
+	if (dapm->codec)
+		return dapm->codec->card->snd_card;
+	else if (dapm->platform)
+		return dapm->platform->card->snd_card;
+	else
+		BUG();
+
+	/* unreachable */
+	return NULL;
+}
+
+/* get soc_card from DAPM context */
+static inline struct snd_soc_card *dapm_get_soc_card(
+		struct snd_soc_dapm_context *dapm)
+{
+	if (dapm->codec)
+		return dapm->codec->card;
+	else if (dapm->platform)
+		return dapm->platform->card;
+	else
+		BUG();
+
+	/* unreachable */
+	return NULL;
+}
+
 static int soc_widget_read(struct snd_soc_dapm_widget *w, int reg)
 {
 	if (w->codec)
-- 
1.7.4.1
