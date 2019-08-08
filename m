From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: define soc_dpcm_debugfs_add()
	for non CONFIG_DEBUG_FS" to the asoc tree
Date: Thu,  8 Aug 2019 21:33:40 +0100 (BST)
Message-ID: <20190808203340.4B3F82742BDD@ypsilon.sirena.org.uk>
References: <875zn9ahnv.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5269BF803F3
 for <alsa-devel@alsa-project.org>; Thu,  8 Aug 2019 22:33:41 +0200 (CEST)
In-Reply-To: <875zn9ahnv.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: soc-core: define soc_dpcm_debugfs_add() for non CONFIG_DEBUG_FS

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

>From ee5b3f11416d1ba69e919b2fe86aae0b46f9a83e Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 7 Aug 2019 10:31:31 +0900
Subject: [PATCH] ASoC: soc-core: define soc_dpcm_debugfs_add() for non
 CONFIG_DEBUG_FS

soc_dpcm_debugfs_add() is implemented at soc-pcm.c under CONFIG_DEBUG_FS.
Thus, soc-core.c which is only user of it need to use CONFIG_DEBUG_FS, too.

This patch defines soc_dpcm_debugfs_add() for non CONFIG_DEBUG_FS case.
Then, we can remove #ifdef CONFIG_DEBUG_FS from soc-core.c

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/875zn9ahnv.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc-dpcm.h | 9 ++++++++-
 sound/soc/soc-core.c     | 2 --
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/sound/soc-dpcm.h b/include/sound/soc-dpcm.h
index 4be3a2b7c106..e55aeb00ce2d 100644
--- a/include/sound/soc-dpcm.h
+++ b/include/sound/soc-dpcm.h
@@ -142,9 +142,16 @@ void snd_soc_dpcm_be_set_state(struct snd_soc_pcm_runtime *be, int stream,
 
 /* internal use only */
 int soc_dpcm_be_digital_mute(struct snd_soc_pcm_runtime *fe, int mute);
-void soc_dpcm_debugfs_add(struct snd_soc_pcm_runtime *rtd);
 int soc_dpcm_runtime_update(struct snd_soc_card *);
 
+#ifdef CONFIG_DEBUG_FS
+void soc_dpcm_debugfs_add(struct snd_soc_pcm_runtime *rtd);
+#else
+static inline void soc_dpcm_debugfs_add(struct snd_soc_pcm_runtime *rtd)
+{
+}
+#endif
+
 int dpcm_path_get(struct snd_soc_pcm_runtime *fe,
 	int stream, struct snd_soc_dapm_widget_list **list_);
 int dpcm_process_paths(struct snd_soc_pcm_runtime *fe,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 25b26caea4e0..2a75fba31aa4 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1487,11 +1487,9 @@ static int soc_probe_link_dais(struct snd_soc_card *card,
 	if (ret)
 		return ret;
 
-#ifdef CONFIG_DEBUG_FS
 	/* add DPCM sysfs entries */
 	if (dai_link->dynamic)
 		soc_dpcm_debugfs_add(rtd);
-#endif
 
 	num = rtd->num;
 
-- 
2.20.1
