From: Koro Chen <koro.chen@mediatek.com>
Subject: [PATCH] ASoC: dapm: Modify widget stream name according to prefix
Date: Mon, 11 May 2015 10:36:53 +0800
Message-ID: <1431311813-37430-1-git-send-email-koro.chen@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: matthias.bgg@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de
Cc: srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org, s.hauer@pengutronix.de, lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Koro Chen <koro.chen@mediatek.com>
List-Id: alsa-devel@alsa-project.org

When there is prefix specified, currently we will add this prefix in
widget->name, but not in widget->sname.
it causes failure at snd_soc_dapm_link_dai_widgets:

if (!w->sname || !strstr(w->sname, dai_w->name))

because dai_w->name has prefix added, but w->sname does not.
We should also add prefix for stream name

Signed-off-by: Koro Chen <koro.chen@mediatek.com>
---
 sound/soc/soc-dapm.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index defe0f0..158204d 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3100,11 +3100,16 @@ snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
 	}
 
 	prefix = soc_dapm_prefix(dapm);
-	if (prefix)
+	if (prefix) {
 		w->name = kasprintf(GFP_KERNEL, "%s %s", prefix, widget->name);
-	else
+		if (widget->sname)
+			w->sname = kasprintf(GFP_KERNEL, "%s %s", prefix,
+					     widget->sname);
+	} else {
 		w->name = kasprintf(GFP_KERNEL, "%s", widget->name);
-
+		if (widget->sname)
+			w->sname = kasprintf(GFP_KERNEL, "%s", widget->sname);
+	}
 	if (w->name == NULL) {
 		kfree(w);
 		return NULL;
-- 
1.8.1.1.dirty
