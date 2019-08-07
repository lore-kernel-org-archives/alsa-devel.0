From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: set component->debugfs_root
	NULL" to the asoc tree
Date: Wed,  7 Aug 2019 14:30:48 +0100 (BST)
Message-ID: <20190807133049.0350A2742BE8@ypsilon.sirena.org.uk>
References: <87muglahq0.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A3E12F80533
 for <alsa-devel@alsa-project.org>; Wed,  7 Aug 2019 15:30:50 +0200 (CEST)
In-Reply-To: <87muglahq0.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-core: set component->debugfs_root NULL

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

>From ad64bfbd09d7b7997a1b1510983350836bcd6ed9 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 7 Aug 2019 10:30:13 +0900
Subject: [PATCH] ASoC: soc-core: set component->debugfs_root NULL

To be more safety code, let's set NULL to component->debugfs_root
when it was cleanuped.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/87muglahq0.wl-kuninori.morimoto.gx@renesas.com
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 0f75dac4bb26..2f37c4e0974b 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -171,7 +171,10 @@ static void soc_init_component_debugfs(struct snd_soc_component *component)
 
 static void soc_cleanup_component_debugfs(struct snd_soc_component *component)
 {
+	if (!component->debugfs_root)
+		return;
 	debugfs_remove_recursive(component->debugfs_root);
+	component->debugfs_root = NULL;
 }
 
 static int dai_list_show(struct seq_file *m, void *v)
-- 
2.20.1
