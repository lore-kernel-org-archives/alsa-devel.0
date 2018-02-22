From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-generic-dmaengine-pcm: Add a DMA
	debugfs_prefix entry" to the asoc tree
Date: Thu, 22 Feb 2018 13:16:05 +0000
Message-ID: <E1eoqjF-00069X-Jb@debutante>
References: <1519227780-26632-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 64B93267718
 for <alsa-devel@alsa-project.org>; Thu, 22 Feb 2018 14:16:13 +0100 (CET)
In-Reply-To: <1519227780-26632-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@nxp.com>
Cc: nicoleotsuka@gmail.com, alsa-devel@alsa-project.org, broonie@kernel.org, lars@metafoo.de, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-generic-dmaengine-pcm: Add a DMA debugfs_prefix entry

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

>From f0b3bdbd5c63c3f69f3b6a869355c676d22fd348 Mon Sep 17 00:00:00 2001
From: Fabio Estevam <fabio.estevam@nxp.com>
Date: Wed, 21 Feb 2018 14:57:33 -0300
Subject: [PATCH] ASoC: soc-generic-dmaengine-pcm: Add a DMA debugfs_prefix
 entry

After the conversion from platform to component the following warnings
are seen:

fsl-ssi-dai 2028000.ssi: ASoC: Failed to create component debugfs
directory
fsl-spdif-dai 2004000.spdif: ASoC: Failed to create component debugfs
directory

As explained by Mark Brown:

"It's a legit warning - we shouldn't really be creating two components
for the same device.  However this is a bit of a corner case as it's the
dmaengine platform driver which is kind of a virtual device, it's not
really the device that we use with DMA that's being represented but
rather the link between that and the DMA controller."

Disambiguate the DMA component name by adding a "dma" debugfs_prefix
entry.

Suggested-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-generic-dmaengine-pcm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index d53786498b61..8fb828bb8a7f 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -431,6 +431,9 @@ int snd_dmaengine_pcm_register(struct device *dev,
 	if (!pcm)
 		return -ENOMEM;
 
+#ifdef CONFIG_DEBUG_FS
+	pcm->component.debugfs_prefix = "dma";
+#endif
 	pcm->config = config;
 	pcm->flags = flags;
 
-- 
2.16.1
