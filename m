From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-component: add
	snd_soc_component_open()" to the asoc tree
Date: Mon,  5 Aug 2019 17:10:01 +0100 (BST)
Message-ID: <20190805161001.3A99A2742EB0@ypsilon.sirena.org.uk>
References: <87ftmt5rnx.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1E067F805FF
 for <alsa-devel@alsa-project.org>; Mon,  5 Aug 2019 18:10:03 +0200 (CEST)
In-Reply-To: <87ftmt5rnx.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: soc-component: add snd_soc_component_open()

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

>From ae2f4849286eed48a3aa79a7b73bb5bcd0c9213b Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 26 Jul 2019 13:50:01 +0900
Subject: [PATCH] ASoC: soc-component: add snd_soc_component_open()

Current ALSA SoC is directly using component->driver->ops->xxx,
thus, it is deep nested, and makes code difficult to read,
and is not good for encapsulation.
This patch adds new snd_soc_component_open() and use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/87ftmt5rnx.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc-component.h |  4 ++++
 sound/soc/soc-component.c     | 10 ++++++++++
 sound/soc/soc-pcm.c           |  6 +-----
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/include/sound/soc-component.h b/include/sound/soc-component.h
index a76cadf49a16..156b1a5b6ddd 100644
--- a/include/sound/soc-component.h
+++ b/include/sound/soc-component.h
@@ -338,4 +338,8 @@ int snd_soc_component_force_enable_pin_unlocked(
 	struct snd_soc_component *component,
 	const char *pin);
 
+/* component driver ops */
+int snd_soc_component_open(struct snd_soc_component *component,
+			   struct snd_pcm_substream *substream);
+
 #endif /* __SOC_COMPONENT_H */
diff --git a/sound/soc/soc-component.c b/sound/soc/soc-component.c
index ac2d7bd5d844..ada46f9729b2 100644
--- a/sound/soc/soc-component.c
+++ b/sound/soc/soc-component.c
@@ -285,3 +285,13 @@ void snd_soc_component_module_put(struct snd_soc_component *component,
 	if (component->driver->module_get_upon_open == !!upon_open)
 		module_put(component->dev->driver->owner);
 }
+
+int snd_soc_component_open(struct snd_soc_component *component,
+			   struct snd_pcm_substream *substream)
+{
+	if (component->driver->ops &&
+	    component->driver->ops->open)
+		return component->driver->ops->open(substream);
+
+	return 0;
+}
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 5fef18507286..caf7028cee62 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -447,11 +447,7 @@ static int soc_pcm_components_open(struct snd_pcm_substream *substream,
 			return ret;
 		}
 
-		if (!component->driver->ops ||
-		    !component->driver->ops->open)
-			continue;
-
-		ret = component->driver->ops->open(substream);
+		ret = snd_soc_component_open(component, substream);
 		if (ret < 0) {
 			dev_err(component->dev,
 				"ASoC: can't open component %s: %d\n",
-- 
2.20.1
