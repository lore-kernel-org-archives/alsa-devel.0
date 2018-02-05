From: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
Subject: [PATCH v2] ASoC: dapm: fix debugfs read using
	path->connected
Date: Mon, 5 Feb 2018 13:00:00 +0800
Message-ID: <1517806800-4210-1-git-send-email-kaichieh.chuang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by alsa0.perex.cz (Postfix) with ESMTP id 841812671BE
 for <alsa-devel@alsa-project.org>; Mon,  5 Feb 2018 06:00:12 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, wsd_upstream@mediatek.com, chipeng.chang@mediatek.com, garlic.tseng@mediatek.com, shane.chien@mediatek.com, linux-mediatek@lists.infradead.org, kaichieh.chuang@mediatek.com
List-Id: alsa-devel@alsa-project.org

This fix a bug in dapm_widget_power_read_file(),
where it may sent opposite order of source/sink widget
into the p->connected().

for example,
static int connected_check(source, sink);
{"w_sink", NULL, "w_source", connected_check}

the dapm_widget_power_read_file() will query p->connected()
in following case
	p->conneted("w_source", "w_sink")
	p->conneted("w_sink", "w_source")
we should avoid the last case, since it's the wrong order (source/sink)
as declared in snd_soc_dapm_route.

Signed-off-by: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
---
 sound/soc/soc-dapm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index a10b21c..ee6d9d9a 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2026,7 +2026,7 @@ static ssize_t dapm_widget_power_read_file(struct file *file,
 	snd_soc_dapm_for_each_direction(dir) {
 		rdir = SND_SOC_DAPM_DIR_REVERSE(dir);
 		snd_soc_dapm_widget_for_each_path(w, dir, p) {
-			if (p->connected && !p->connected(w, p->node[rdir]))
+			if (p->connected && !p->connected(p->source, p->sink))
 				continue;
 
 			if (!p->connect)
-- 
1.7.9.5
