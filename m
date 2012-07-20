From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: dapm: Fix _PRE and _POST events for DAPM
	performance improvements
Date: Fri, 20 Jul 2012 17:32:20 +0100
Message-ID: <1342801940-11549-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0E962265319
 for <alsa-devel@alsa-project.org>; Fri, 20 Jul 2012 18:41:24 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Ever since the DAPM performance improvements we've been marking all widgets
as not dirty after each DAPM run. Since _PRE and _POST events aren't part
of the DAPM graph this has rendered them non-functional, they will never be
marked dirty again and thus will never be run again.

Fix this by skipping them when marking widgets as not dirty.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 35c5f81..4d2c0f9 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1597,7 +1597,15 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 	}
 
 	list_for_each_entry(w, &card->widgets, list) {
-		list_del_init(&w->dirty);
+		switch (w->id) {
+		case snd_soc_dapm_pre:
+		case snd_soc_dapm_post:
+			/* These widgets always need to be powered */
+			break;
+		default:
+			list_del_init(&w->dirty);
+			break;
+		}
 
 		if (w->power) {
 			d = w->dapm;
-- 
1.7.10.4
