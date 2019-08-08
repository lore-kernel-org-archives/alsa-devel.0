From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: fix module_put() warning in
	soc_cleanup_component" to the asoc tree
Date: Thu,  8 Aug 2019 21:33:39 +0100 (BST)
Message-ID: <20190808203339.AA8012742B42@ypsilon.sirena.org.uk>
References: <20190808025131.32482-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B9B97F8053B
 for <alsa-devel@alsa-project.org>; Thu,  8 Aug 2019 22:33:42 +0200 (CEST)
In-Reply-To: <20190808025131.32482-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-core: fix module_put() warning in soc_cleanup_component

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

>From 0e36f36b04e7677c6b74349c9d4baea1ed5668f2 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Wed, 7 Aug 2019 21:51:31 -0500
Subject: [PATCH] ASoC: soc-core: fix module_put() warning in
 soc_cleanup_component

The recent changes introduce warnings in the SOF load/unload module
tests. The code does not seem balanced with a confusion between
_close() and _remove() macros. Using _remove() fixes the issue and
removes the warning.

Suggested-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Fixes: 4a81e8f30d0b4 ('ASoC: soc-component: add snd_soc_component_get/put()')
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/20190808025131.32482-1-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 1fbd525763d5..bf45e60eb34f 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -935,7 +935,7 @@ static void soc_cleanup_component(struct snd_soc_component *component)
 	snd_soc_dapm_free(snd_soc_component_get_dapm(component));
 	soc_cleanup_component_debugfs(component);
 	component->card = NULL;
-	snd_soc_component_module_put_when_close(component);
+	snd_soc_component_module_put_when_remove(component);
 }
 
 static void soc_remove_component(struct snd_soc_component *component)
-- 
2.20.1
