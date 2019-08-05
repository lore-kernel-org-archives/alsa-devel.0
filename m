From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-component: add
	snd_soc_component_of_xlate_dai_id()" to the asoc tree
Date: Mon,  5 Aug 2019 17:09:58 +0100 (BST)
Message-ID: <20190805160958.9006E2742D06@ypsilon.sirena.org.uk>
References: <87zhl14d14.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 88F3DF8011B
 for <alsa-devel@alsa-project.org>; Mon,  5 Aug 2019 18:09:59 +0200 (CEST)
In-Reply-To: <87zhl14d14.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: soc-component: add snd_soc_component_of_xlate_dai_id()

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

>From 2c7b1704819435d188c7697c6815f788bf9e6200 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 26 Jul 2019 13:51:26 +0900
Subject: [PATCH] ASoC: soc-component: add snd_soc_component_of_xlate_dai_id()

Current ALSA SoC is directly using component->driver->xxx,
thus, it is deep nested, and makes code difficult to read,
and is not good for encapsulation.
This patch adds new snd_soc_component_of_xlate_dai_id() and use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/87zhl14d14.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc-component.h | 2 ++
 sound/soc/soc-component.c     | 9 +++++++++
 sound/soc/soc-core.c          | 5 ++---
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/sound/soc-component.h b/include/sound/soc-component.h
index b8480d947901..3f4acd337c4a 100644
--- a/include/sound/soc-component.h
+++ b/include/sound/soc-component.h
@@ -358,5 +358,7 @@ void snd_soc_component_resume(struct snd_soc_component *component);
 int snd_soc_component_is_suspended(struct snd_soc_component *component);
 int snd_soc_component_probe(struct snd_soc_component *component);
 void snd_soc_component_remove(struct snd_soc_component *component);
+int snd_soc_component_of_xlate_dai_id(struct snd_soc_component *component,
+				      struct device_node *ep);
 
 #endif /* __SOC_COMPONENT_H */
diff --git a/sound/soc/soc-component.c b/sound/soc/soc-component.c
index eba77ea2b62d..faf49992f661 100644
--- a/sound/soc/soc-component.c
+++ b/sound/soc/soc-component.c
@@ -380,3 +380,12 @@ void snd_soc_component_remove(struct snd_soc_component *component)
 	if (component->driver->remove)
 		component->driver->remove(component);
 }
+
+int snd_soc_component_of_xlate_dai_id(struct snd_soc_component *component,
+				      struct device_node *ep)
+{
+	if (component->driver->of_xlate_dai_id)
+		return component->driver->of_xlate_dai_id(component, ep);
+
+	return -ENOTSUPP;
+}
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 6a6403ddf62d..f63d09dd55f4 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3334,9 +3334,8 @@ int snd_soc_get_dai_id(struct device_node *ep)
 	ret = -ENOTSUPP;
 	mutex_lock(&client_mutex);
 	component = soc_find_component(&dlc);
-	if (component &&
-	    component->driver->of_xlate_dai_id)
-		ret = component->driver->of_xlate_dai_id(component, ep);
+	if (component)
+		ret = snd_soc_component_of_xlate_dai_id(component, ep);
 	mutex_unlock(&client_mutex);
 
 	of_node_put(dlc.of_node);
-- 
2.20.1
