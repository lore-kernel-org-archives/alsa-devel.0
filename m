From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Sync initial widget state with hardware
Date: Wed,  9 Feb 2011 18:04:11 +0000
Message-ID: <1297274651-16959-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 78E91103999
	for <alsa-devel@alsa-project.org>; Wed,  9 Feb 2011 19:04:14 +0100 (CET)
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

ASoC generally uses the register defaults for everything, but in some
cases the hardware will default to enabling some of the DAPM widgets
(clocks for example). Ensure that DAPM knows about the actual widget
state at initialisation by reading the enable bits after instantiating
the widgets so they don't get left enabled needlessly.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index d0342aa..b30eda6 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1664,6 +1664,7 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_add_routes);
 int snd_soc_dapm_new_widgets(struct snd_soc_dapm_context *dapm)
 {
 	struct snd_soc_dapm_widget *w;
+	unsigned int val;
 
 	list_for_each_entry(w, &dapm->card->widgets, list)
 	{
@@ -1712,6 +1713,18 @@ int snd_soc_dapm_new_widgets(struct snd_soc_dapm_context *dapm)
 		case snd_soc_dapm_post:
 			break;
 		}
+
+		/* Read the initial power state from the device */
+		if (w->reg >= 0) {
+			val = snd_soc_read(w->codec, w->reg);
+			val &= 1 << w->shift;
+			if (w->invert)
+				val = !val;
+
+			if (val)
+				w->power = 1;
+		}
+
 		w->new = 1;
 	}
 
-- 
1.7.2.3
