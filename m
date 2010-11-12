From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2.6.37 1/2] ASoC: Fix dapm_seq_compare() for
	multi-component
Date: Fri, 12 Nov 2010 16:01:10 +0000
Message-ID: <1289577671-13837-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B7A1E10397A
	for <alsa-devel@alsa-project.org>; Fri, 12 Nov 2010 17:01:17 +0100 (CET)
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

Ensure that we keep all widget powerups in DAPM sequence by making
the CODEC the last thing we compare on rather than the first thing.
Also fix the fact that we're currently comparing the widget pointers
rather than the CODEC pointers when we do the substraction so we
won't get stable results.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 8352430..bc2ec06 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -706,12 +706,12 @@ static int dapm_seq_compare(struct snd_soc_dapm_widget *a,
 			    struct snd_soc_dapm_widget *b,
 			    int sort[])
 {
-	if (a->codec != b->codec)
-		return (unsigned long)a - (unsigned long)b;
 	if (sort[a->id] != sort[b->id])
 		return sort[a->id] - sort[b->id];
 	if (a->reg != b->reg)
 		return a->reg - b->reg;
+	if (a->codec != b->codec)
+		return (unsigned long)a->codec - (unsigned long)b->codec;
 
 	return 0;
 }
-- 
1.7.1
