From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: add component_list_show()" to the asoc
	tree
Date: Wed,  9 May 2018 10:44:06 +0100 (BST)
Message-ID: <20180509094406.6E64A44007A@finisterre.ee.mobilebroadband>
References: <87d0y6rg3g.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 202C2267738
 for <alsa-devel@alsa-project.org>; Wed,  9 May 2018 18:29:00 +0200 (CEST)
In-Reply-To: <87d0y6rg3g.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: add component_list_show()

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

>From db795f9b924eaf9c86ff6ba025d7ae2f3457ef05 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 8 May 2018 03:21:00 +0000
Subject: [PATCH] ASoC: add component_list_show()

commit ef050bece1b55 ("ASoC: Remove platform code now everything is
componentised") removed platform code, then platform_list_show() was
removed, too. But we want to keep it as component_list_show.
This patch add it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index a4cb141b8f38..f22ef347eead 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -190,6 +190,21 @@ static int dai_list_show(struct seq_file *m, void *v)
 }
 DEFINE_SHOW_ATTRIBUTE(dai_list);
 
+static int component_list_show(struct seq_file *m, void *v)
+{
+	struct snd_soc_component *component;
+
+	mutex_lock(&client_mutex);
+
+	list_for_each_entry(component, &component_list, list)
+		seq_printf(m, "%s\n", component->name);
+
+	mutex_unlock(&client_mutex);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(component_list);
+
 static void soc_init_card_debugfs(struct snd_soc_card *card)
 {
 	if (!snd_soc_debugfs_root)
@@ -228,6 +243,10 @@ static void snd_soc_debugfs_init(void)
 	if (!debugfs_create_file("dais", 0444, snd_soc_debugfs_root, NULL,
 				 &dai_list_fops))
 		pr_warn("ASoC: Failed to create DAI list debugfs file\n");
+
+	if (!debugfs_create_file("components", 0444, snd_soc_debugfs_root, NULL,
+				 &component_list_fops))
+		pr_warn("ASoC: Failed to create component list debugfs file\n");
 }
 
 static void snd_soc_debugfs_exit(void)
-- 
2.17.0
