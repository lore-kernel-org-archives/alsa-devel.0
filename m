From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: call
	snd_soc_dapm_debugfs_init() at soc_init_card_debugfs()" to
	the asoc tree
Date: Thu,  8 Aug 2019 21:33:40 +0100 (BST)
Message-ID: <20190808203340.ECB492742EDC@ypsilon.sirena.org.uk>
References: <87a7clahob.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8D78AF8053A
 for <alsa-devel@alsa-project.org>; Thu,  8 Aug 2019 22:33:42 +0200 (CEST)
In-Reply-To: <87a7clahob.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: soc-core: call snd_soc_dapm_debugfs_init() at soc_init_card_debugfs()

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

>From d8ca7a0a8583fc491b625450580c4092879af3dd Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 7 Aug 2019 10:31:14 +0900
Subject: [PATCH] ASoC: soc-core: call snd_soc_dapm_debugfs_init() at
 soc_init_card_debugfs()

We have 2 soc_init_card_debugfs() implementations for with/without DEBUG_FS.
But, snd_soc_instantiate_card() calls snd_soc_dapm_debugfs_init() under
ifdef DEBUG_FS after soc_init_card_debugfs(). This is very strange.
We can call snd_soc_dapm_debugfs_init() under soc_init_card_debugfs().

	#ifdef CONFIG_DEBUG_FS
=>	static void soc_init_card_debugfs(...)
	{
		...
	}
	...
	#else
=>	static inline void soc_init_card_debugfs(...)
	{
		...
	}
	#endif

	static int snd_soc_instantiate_card(struct snd_soc_card *card)
	{
		...
=>		soc_init_card_debugfs(card);

*	#ifdef CONFIG_DEBUG_FS
*		snd_soc_dapm_debugfs_init(&card->dapm, card->debugfs_card_root);
*	#endif
	}

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/87a7clahob.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 4b9ae867613c..cf3d967d731e 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -216,6 +216,8 @@ static void soc_init_card_debugfs(struct snd_soc_card *card)
 
 	debugfs_create_u32("dapm_pop_time", 0644, card->debugfs_card_root,
 			   &card->pop_time);
+
+	snd_soc_dapm_debugfs_init(&card->dapm, card->debugfs_card_root);
 }
 
 static void soc_cleanup_card_debugfs(struct snd_soc_card *card)
@@ -1982,10 +1984,6 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 
 	soc_init_card_debugfs(card);
 
-#ifdef CONFIG_DEBUG_FS
-	snd_soc_dapm_debugfs_init(&card->dapm, card->debugfs_card_root);
-#endif
-
 #ifdef CONFIG_PM_SLEEP
 	/* deferred resume work */
 	INIT_WORK(&card->deferred_resume_work, soc_resume_deferred);
-- 
2.20.1
