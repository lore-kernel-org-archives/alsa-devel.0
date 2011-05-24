From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH] ASoC: dapm - fix prefix for DAPM muxes
Date: Tue, 24 May 2011 17:39:09 +0100
Message-ID: <1306255149-4519-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 6EB5E103972
	for <alsa-devel@alsa-project.org>;
	Tue, 24 May 2011 18:39:20 +0200 (CEST)
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

Make sure DAPM muxes have a valid kcontrol name instead of NULL.

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 sound/soc/soc-dapm.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 456617e..c5d98e3 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -489,10 +489,10 @@ static int dapm_new_mux(struct snd_soc_dapm_context *dapm,
 	wlist->widgets[wlistentries - 1] = w;
 
 	if (!kcontrol) {
-		if (dapm->codec)
+		if (dapm->codec && dapm->codec->name_prefix)
 			prefix = dapm->codec->name_prefix;
 		else
-			prefix = NULL;
+			prefix = w->name;
 
 		if (shared) {
 			name = w->kcontrol_news[0].name;
-- 
1.7.4.1
