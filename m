From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-component: add
	snd_soc_component_prepare()" to the asoc tree
Date: Mon,  5 Aug 2019 17:10:00 +0100 (BST)
Message-ID: <20190805161000.B449E2742EB3@ypsilon.sirena.org.uk>
References: <87d0hx5rnm.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 02815F805F9
 for <alsa-devel@alsa-project.org>; Mon,  5 Aug 2019 18:10:01 +0200 (CEST)
In-Reply-To: <87d0hx5rnm.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: soc-component: add snd_soc_component_prepare()

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

>From 6d53723380ed73a2ced648d6e92774b39e5af1bd Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 26 Jul 2019 13:50:13 +0900
Subject: [PATCH] ASoC: soc-component: add snd_soc_component_prepare()

Current ALSA SoC is directly using component->driver->ops->xxx,
thus, it is deep nested, and makes code difficult to read,
and is not good for encapsulation.
This patch adds new snd_soc_component_prepare() and use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/87d0hx5rnm.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc-component.h |  2 ++
 sound/soc/soc-component.c     | 10 ++++++++++
 sound/soc/soc-pcm.c           |  6 +-----
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/include/sound/soc-component.h b/include/sound/soc-component.h
index 8dacac953884..ff8233014444 100644
--- a/include/sound/soc-component.h
+++ b/include/sound/soc-component.h
@@ -343,5 +343,7 @@ int snd_soc_component_open(struct snd_soc_component *component,
 			   struct snd_pcm_substream *substream);
 int snd_soc_component_close(struct snd_soc_component *component,
 			    struct snd_pcm_substream *substream);
+int snd_soc_component_prepare(struct snd_soc_component *component,
+			      struct snd_pcm_substream *substream);
 
 #endif /* __SOC_COMPONENT_H */
diff --git a/sound/soc/soc-component.c b/sound/soc/soc-component.c
index cee66183470d..733d7139d875 100644
--- a/sound/soc/soc-component.c
+++ b/sound/soc/soc-component.c
@@ -305,3 +305,13 @@ int snd_soc_component_close(struct snd_soc_component *component,
 
 	return 0;
 }
+
+int snd_soc_component_prepare(struct snd_soc_component *component,
+			      struct snd_pcm_substream *substream)
+{
+	if (component->driver->ops &&
+	    component->driver->ops->prepare)
+		return component->driver->ops->prepare(substream);
+
+	return 0;
+}
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 4848642ef159..c7fee67bc0dc 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -785,11 +785,7 @@ static int soc_pcm_prepare(struct snd_pcm_substream *substream)
 	for_each_rtdcom(rtd, rtdcom) {
 		component = rtdcom->component;
 
-		if (!component->driver->ops ||
-		    !component->driver->ops->prepare)
-			continue;
-
-		ret = component->driver->ops->prepare(substream);
+		ret = snd_soc_component_prepare(component, substream);
 		if (ret < 0) {
 			dev_err(component->dev,
 				"ASoC: platform prepare error: %d\n", ret);
-- 
2.20.1
