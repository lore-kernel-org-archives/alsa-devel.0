From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: Use DAPM context rather than CODEC
	when constructing sequences
Date: Fri, 12 Nov 2010 16:01:11 +0000
Message-ID: <1289577671-13837-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1289577671-13837-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B74D8103978
	for <alsa-devel@alsa-project.org>; Fri, 12 Nov 2010 17:01:17 +0100 (CET)
In-Reply-To: <1289577671-13837-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

DAPM widgets may be associated with non-CODEC devices so compare based
on the DAPM context rather than the CODEC pointer.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index bc2ec06..5ee93a5 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -710,8 +710,8 @@ static int dapm_seq_compare(struct snd_soc_dapm_widget *a,
 		return sort[a->id] - sort[b->id];
 	if (a->reg != b->reg)
 		return a->reg - b->reg;
-	if (a->codec != b->codec)
-		return (unsigned long)a->codec - (unsigned long)b->codec;
+	if (a->dapm != b->dapm)
+		return (unsigned long)a->dapm - (unsigned long)b->dapm;
 
 	return 0;
 }
-- 
1.7.1
