From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH] ASoC: damp: Reset dapm wcache after freeing
	damp widgets
Date: Mon, 9 Nov 2015 15:30:26 +0200
Message-ID: <1447075826-641-1-git-send-email-jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 3529426044B
 for <alsa-devel@alsa-project.org>; Mon,  9 Nov 2015 14:30:32 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: liam.r.girdwood@linux.intel.com, peter.ujfalusi@ti.com, broonie@kernel.org, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org

If there is anything in damp->path_source_cache or
damp->path_sink_cache, it can not be valid after the widgets have been
freed. Without this patch a repeated remove and load of a machine
driver may cause NULL pointer reference in dapm_wcache_lookup() when a
freed widget, not belonging to any list, is haunting in the wcache.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
Reported-by: Felipe Balbi <balbi@ti.com>
---
The patch fixes the problem reported here:
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-October/099431.html

 sound/soc/soc-dapm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index ff8bda4..d78db59 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2286,6 +2286,9 @@ static void dapm_free_widgets(struct snd_soc_dapm_context *dapm)
 			continue;
 		snd_soc_dapm_free_widget(w);
 	}
+
+	dapm->path_sink_cache.widget = NULL;
+	dapm->path_source_cache.widget = NULL;
 }
 
 static struct snd_soc_dapm_widget *dapm_find_widget(
-- 
1.9.1
