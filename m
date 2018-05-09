From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: convert platform explanation to
	component" to the asoc tree
Date: Wed,  9 May 2018 10:43:40 +0100 (BST)
Message-ID: <20180509094340.23F6E44007C@finisterre.ee.mobilebroadband>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 4027E267757
 for <alsa-devel@alsa-project.org>; Wed,  9 May 2018 18:29:01 +0200 (CEST)
In-Reply-To: 
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

   ASoC: convert platform explanation to component

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

>From d9f29e9ebe6ec7193c160ac3d38d5d1d6b55adda Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 8 May 2018 03:21:24 +0000
Subject: [PATCH] ASoC: convert platform explanation to component

commit ef050bece1b55 ("ASoC: Remove platform code now everything is
componentised") removed platform code, but it didn't care
about platform documentation.
This patch convert platform explanation to component

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/sound/soc/platform.rst | 30 ++++++++++++----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/Documentation/sound/soc/platform.rst b/Documentation/sound/soc/platform.rst
index d5574904d981..cc817078daa6 100644
--- a/Documentation/sound/soc/platform.rst
+++ b/Documentation/sound/soc/platform.rst
@@ -23,30 +23,26 @@ The platform DMA driver optionally supports the following ALSA operations:-
   };
 
 The platform driver exports its DMA functionality via struct
-snd_soc_platform_driver:-
+snd_soc_component_driver:-
 ::
 
-  struct snd_soc_platform_driver {
-	char *name;
+  struct snd_soc_component_driver {
+	const char *name;
 
-	int (*probe)(struct platform_device *pdev);
-	int (*remove)(struct platform_device *pdev);
-	int (*suspend)(struct platform_device *pdev, struct snd_soc_cpu_dai *cpu_dai);
-	int (*resume)(struct platform_device *pdev, struct snd_soc_cpu_dai *cpu_dai);
+	...
+	int (*probe)(struct snd_soc_component *);
+	void (*remove)(struct snd_soc_component *);
+	int (*suspend)(struct snd_soc_component *);
+	int (*resume)(struct snd_soc_component *);
 
 	/* pcm creation and destruction */
-	int (*pcm_new)(struct snd_card *, struct snd_soc_codec_dai *, struct snd_pcm *);
+	int (*pcm_new)(struct snd_soc_pcm_runtime *);
 	void (*pcm_free)(struct snd_pcm *);
 
-	/*
-	 * For platform caused delay reporting.
-	 * Optional.
-	 */
-	snd_pcm_sframes_t (*delay)(struct snd_pcm_substream *,
-		struct snd_soc_dai *);
-
-	/* platform stream ops */
-	struct snd_pcm_ops *pcm_ops;
+	...
+	const struct snd_pcm_ops *ops;
+	const struct snd_compr_ops *compr_ops;
+	...
   };
 
 Please refer to the ALSA driver documentation for details of audio DMA.
-- 
2.17.0
