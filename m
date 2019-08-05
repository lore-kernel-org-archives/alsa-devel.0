From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-pcm: remove
	soc_rtdcom_copy_kernel()" to the asoc tree
Date: Mon,  5 Aug 2019 17:10:02 +0100 (BST)
Message-ID: <20190805161002.2F0F62742EB3@ypsilon.sirena.org.uk>
References: <87lfwl5rot.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EA5DFF80635
 for <alsa-devel@alsa-project.org>; Mon,  5 Aug 2019 18:10:04 +0200 (CEST)
In-Reply-To: <87lfwl5rot.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: soc-pcm: remove soc_rtdcom_copy_kernel()

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

>From 4efbb20971af527990f3c51056d142e3f7dc6b4a Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 26 Jul 2019 13:49:29 +0900
Subject: [PATCH] ASoC: soc-pcm: remove soc_rtdcom_copy_kernel()

No ALSA SoC driver has .copy_kernel at component->driver->ops.
We can revive it if some-driver want to use it, but let's remove it
so far to avoid maintaining complex code

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/87lfwl5rot.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-pcm.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index bf04b69d6878..e85548244b55 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -2896,28 +2896,6 @@ static int soc_rtdcom_copy_user(struct snd_pcm_substream *substream, int channel
 	return -EINVAL;
 }
 
-static int soc_rtdcom_copy_kernel(struct snd_pcm_substream *substream, int channel,
-				  unsigned long pos, void *buf, unsigned long bytes)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_rtdcom_list *rtdcom;
-	struct snd_soc_component *component;
-
-	for_each_rtdcom(rtd, rtdcom) {
-		component = rtdcom->component;
-
-		if (!component->driver->ops ||
-		    !component->driver->ops->copy_kernel)
-			continue;
-
-		/* FIXME. it returns 1st copy now */
-		return component->driver->ops->copy_kernel(substream, channel,
-							   pos, buf, bytes);
-	}
-
-	return -EINVAL;
-}
-
 static int soc_rtdcom_fill_silence(struct snd_pcm_substream *substream, int channel,
 				   unsigned long pos, unsigned long bytes)
 {
@@ -3111,8 +3089,6 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 
 		if (ops->copy_user)
 			rtd->ops.copy_user	= soc_rtdcom_copy_user;
-		if (ops->copy_kernel)
-			rtd->ops.copy_kernel	= soc_rtdcom_copy_kernel;
 		if (ops->fill_silence)
 			rtd->ops.fill_silence	= soc_rtdcom_fill_silence;
 		if (ops->page)
-- 
2.20.1
