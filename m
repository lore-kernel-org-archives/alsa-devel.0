From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-component: add
	snd_soc_pcm_component_pointer()" to the asoc tree
Date: Mon,  5 Aug 2019 17:09:57 +0100 (BST)
Message-ID: <20190805160957.5A47C2742EB0@ypsilon.sirena.org.uk>
References: <87sgqt4d0j.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B6F3AF8053A
 for <alsa-devel@alsa-project.org>; Mon,  5 Aug 2019 18:09:58 +0200 (CEST)
In-Reply-To: <87sgqt4d0j.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: soc-component: add snd_soc_pcm_component_pointer()

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

>From 0035e2565b93e0902a06320ba1716bc1ddd753b3 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 26 Jul 2019 13:51:47 +0900
Subject: [PATCH] ASoC: soc-component: add snd_soc_pcm_component_pointer()

Current ALSA SoC is directly using component->driver->ops->xxx,
thus, the code nested deeply, and it makes code difficult to read,
and is not good for encapsulation.

We want to implement component related function at soc-component.c,
but, some of them need to care whole snd_soc_pcm_runtime (= rtd)
connected component.

Let's call component related function which need to care with
for_each_rtdcom() loop as snd_soc_pcm_component_xxx().
This patch adds new snd_soc_pcm_component_pointer() and use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/87sgqt4d0j.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc-component.h |  2 ++
 sound/soc/soc-component.c     | 18 ++++++++++++++++++
 sound/soc/soc-pcm.c           | 13 +------------
 3 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/include/sound/soc-component.h b/include/sound/soc-component.h
index 2aaf12bbbed0..38b4be1d99f5 100644
--- a/include/sound/soc-component.h
+++ b/include/sound/soc-component.h
@@ -371,4 +371,6 @@ int snd_soc_component_of_xlate_dai_name(struct snd_soc_component *component,
 					struct of_phandle_args *args,
 					const char **dai_name);
 
+int snd_soc_pcm_component_pointer(struct snd_pcm_substream *substream);
+
 #endif /* __SOC_COMPONENT_H */
diff --git a/sound/soc/soc-component.c b/sound/soc/soc-component.c
index cb63df6e46eb..e2053c8bf1f0 100644
--- a/sound/soc/soc-component.c
+++ b/sound/soc/soc-component.c
@@ -424,3 +424,21 @@ int snd_soc_component_of_xlate_dai_name(struct snd_soc_component *component,
 						     args, dai_name);
 	return -ENOTSUPP;
 }
+
+int snd_soc_pcm_component_pointer(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_component *component;
+	struct snd_soc_rtdcom_list *rtdcom;
+
+	for_each_rtdcom(rtd, rtdcom) {
+		component = rtdcom->component;
+
+		/* FIXME: use 1st pointer */
+		if (component->driver->ops &&
+		    component->driver->ops->pointer)
+			return component->driver->ops->pointer(substream);
+	}
+
+	return 0;
+}
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index cd49c2d688c3..020e1d275076 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1111,8 +1111,6 @@ static int soc_pcm_bespoke_trigger(struct snd_pcm_substream *substream,
 static snd_pcm_uframes_t soc_pcm_pointer(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_component *component;
-	struct snd_soc_rtdcom_list *rtdcom;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	struct snd_soc_dai *codec_dai;
 	struct snd_pcm_runtime *runtime = substream->runtime;
@@ -1124,17 +1122,8 @@ static snd_pcm_uframes_t soc_pcm_pointer(struct snd_pcm_substream *substream)
 	/* clearing the previous total delay */
 	runtime->delay = 0;
 
-	for_each_rtdcom(rtd, rtdcom) {
-		component = rtdcom->component;
+	offset = snd_soc_pcm_component_pointer(substream);
 
-		if (!component->driver->ops ||
-		    !component->driver->ops->pointer)
-			continue;
-
-		/* FIXME: use 1st pointer */
-		offset = component->driver->ops->pointer(substream);
-		break;
-	}
 	/* base delay if assigned in pointer callback */
 	delay = runtime->delay;
 
-- 
2.20.1
