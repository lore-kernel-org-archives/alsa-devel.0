From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/5] ASoC: dapm: Remove unnecessary loop
Date: Fri, 14 Jun 2013 13:16:52 +0200
Message-ID: <1371208614-18697-3-git-send-email-lars@metafoo.de>
References: <1371208614-18697-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-121.synserver.de (smtp-out-121.synserver.de
 [212.40.185.121])
 by alsa0.perex.cz (Postfix) with ESMTP id DC7282625FF
 for <alsa-devel@alsa-project.org>; Fri, 14 Jun 2013 13:16:52 +0200 (CEST)
In-Reply-To: <1371208614-18697-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The condition 'i == item' is only true when, well, 'i' equals 'item'.
So just use 'item' directly as the index into the array.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-dapm.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index f81d942..6d4a72e 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -367,11 +367,10 @@ static void dapm_set_path_status(struct snd_soc_dapm_widget *w,
 		val = soc_widget_read(w, e->reg);
 		item = (val >> e->shift_l) & e->mask;
 
-		p->connect = 0;
-		for (i = 0; i < e->max; i++) {
-			if (!(strcmp(p->name, e->texts[i])) && item == i)
-				p->connect = 1;
-		}
+		if (item < e->max && !strcmp(p->name, e->texts[item]))
+			p->connect = 1;
+		else
+			p->connect = 0;
 	}
 	break;
 	case snd_soc_dapm_virt_mux: {
@@ -401,11 +400,10 @@ static void dapm_set_path_status(struct snd_soc_dapm_widget *w,
 				break;
 		}
 
-		p->connect = 0;
-		for (i = 0; i < e->max; i++) {
-			if (!(strcmp(p->name, e->texts[i])) && item == i)
-				p->connect = 1;
-		}
+		if (item < e->max && !strcmp(p->name, e->texts[item]))
+			p->connect = 1;
+		else
+			p->connect = 0;
 	}
 	break;
 	/* does not affect routing - always connected */
-- 
1.8.0
