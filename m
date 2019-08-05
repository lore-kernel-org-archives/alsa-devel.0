From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-component: add
	snd_soc_component_trigger()" to the asoc tree
Date: Mon,  5 Aug 2019 17:09:59 +0100 (BST)
Message-ID: <20190805161000.06B7C2742D06@ypsilon.sirena.org.uk>
References: <878ssl5rn5.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 90453F80529
 for <alsa-devel@alsa-project.org>; Mon,  5 Aug 2019 18:10:01 +0200 (CEST)
In-Reply-To: <878ssl5rn5.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: soc-component: add snd_soc_component_trigger()

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

>From 5693d50c830272cb3c4a04d2ce4db502debd1259 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 26 Jul 2019 13:50:29 +0900
Subject: [PATCH] ASoC: soc-component: add snd_soc_component_trigger()

Current ALSA SoC is directly using component->driver->ops->xxx,
thus, it is deep nested, and makes code difficult to read,
and is not good for encapsulation.
This patch adds new snd_soc_component_trigger() and use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/878ssl5rn5.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc-component.h |  3 +++
 sound/soc/soc-component.c     | 11 +++++++++++
 sound/soc/soc-pcm.c           |  6 +-----
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/include/sound/soc-component.h b/include/sound/soc-component.h
index fbcd911ac25e..302e27a89d47 100644
--- a/include/sound/soc-component.h
+++ b/include/sound/soc-component.h
@@ -350,5 +350,8 @@ int snd_soc_component_hw_params(struct snd_soc_component *component,
 				struct snd_pcm_hw_params *params);
 int snd_soc_component_hw_free(struct snd_soc_component *component,
 			      struct snd_pcm_substream *substream);
+int snd_soc_component_trigger(struct snd_soc_component *component,
+			      struct snd_pcm_substream *substream,
+			      int cmd);
 
 #endif /* __SOC_COMPONENT_H */
diff --git a/sound/soc/soc-component.c b/sound/soc/soc-component.c
index e2bc34efe547..cf0d20a877e6 100644
--- a/sound/soc/soc-component.c
+++ b/sound/soc/soc-component.c
@@ -336,3 +336,14 @@ int snd_soc_component_hw_free(struct snd_soc_component *component,
 
 	return 0;
 }
+
+int snd_soc_component_trigger(struct snd_soc_component *component,
+			      struct snd_pcm_substream *substream,
+			      int cmd)
+{
+	if (component->driver->ops &&
+	    component->driver->ops->trigger)
+		return component->driver->ops->trigger(substream, cmd);
+
+	return 0;
+}
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 8c5289904f20..cd49c2d688c3 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1065,11 +1065,7 @@ static int soc_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	for_each_rtdcom(rtd, rtdcom) {
 		component = rtdcom->component;
 
-		if (!component->driver->ops ||
-		    !component->driver->ops->trigger)
-			continue;
-
-		ret = component->driver->ops->trigger(substream, cmd);
+		ret = snd_soc_component_trigger(component, substream, cmd);
 		if (ret < 0)
 			return ret;
 	}
-- 
2.20.1
