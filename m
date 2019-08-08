From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: dai_link check under
	soc_dpcm_debugfs_add()" to the asoc tree
Date: Thu,  8 Aug 2019 21:33:39 +0100 (BST)
Message-ID: <20190808203339.E3A512742BE9@ypsilon.sirena.org.uk>
References: <874l2tahnq.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C807DF800E4
 for <alsa-devel@alsa-project.org>; Thu,  8 Aug 2019 22:33:41 +0200 (CEST)
In-Reply-To: <874l2tahnq.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: soc-core: dai_link check under soc_dpcm_debugfs_add()

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

>From 596becd3f82a7b7e091b0f5c380bc9a0e6758126 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 7 Aug 2019 10:31:36 +0900
Subject: [PATCH] ASoC: soc-core: dai_link check under soc_dpcm_debugfs_add()

soc_dpcm_debugfs_add(rtd) is checking rtd->dai_link pointer,
but, rtd->dai_link->dynamic have been already checked before calling it.

	static int soc_probe_link_dais(...) {
		dai_link = rtd->dai_link;
		...
=>		if (dai_link->dynamic)
=>			soc_dpcm_debugfs_add(rtd);
		...
	}

	void soc_dpcm_debugfs_add(rtd)
	{
=>		if (!rtd->dai_link)
			return;
		...
	}

These pointer checks are strange/pointless.
This patch checks dai_link->dynamic under soc_dpcm_debugfs_add().

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/874l2tahnq.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 3 +--
 sound/soc/soc-pcm.c  | 3 +++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 2a75fba31aa4..1fbd525763d5 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1488,8 +1488,7 @@ static int soc_probe_link_dais(struct snd_soc_card *card,
 		return ret;
 
 	/* add DPCM sysfs entries */
-	if (dai_link->dynamic)
-		soc_dpcm_debugfs_add(rtd);
+	soc_dpcm_debugfs_add(rtd);
 
 	num = rtd->num;
 
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 77c986fe08d0..da657c8179cc 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -3200,6 +3200,9 @@ void soc_dpcm_debugfs_add(struct snd_soc_pcm_runtime *rtd)
 	if (!rtd->dai_link)
 		return;
 
+	if (!rtd->dai_link->dynamic)
+		return;
+
 	if (!rtd->card->debugfs_card_root)
 		return;
 
-- 
2.20.1
