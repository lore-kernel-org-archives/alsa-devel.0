From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dapm: fix debugfs read using
	path->connected" to the asoc tree
Date: Mon, 05 Feb 2018 15:20:07 +0000
Message-ID: <E1eiiYx-0007GX-U8@debutante>
References: <1517806800-4210-1-git-send-email-kaichieh.chuang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C91F2673A1
 for <alsa-devel@alsa-project.org>; Mon,  5 Feb 2018 16:20:20 +0100 (CET)
In-Reply-To: <1517806800-4210-1-git-send-email-kaichieh.chuang@mediatek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, wsd_upstream@mediatek.com, chipeng.chang@mediatek.com, garlic.tseng@mediatek.com, shane.chien@mediatek.com, broonie@kernel.org, linux-mediatek@lists.infradead.org, kaichieh.chuang@mediatek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dapm: fix debugfs read using path->connected

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 7a32c89e89c5529f3d436b7cc6bc8d4447819669 Mon Sep 17 00:00:00 2001
From: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
Date: Mon, 5 Feb 2018 13:00:00 +0800
Subject: [PATCH] ASoC: dapm: fix debugfs read using path->connected

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
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-dapm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index a10b21cfc31e..ee6d9d9a3c5e 100644
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
2.15.1
