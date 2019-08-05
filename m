From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-component: add
	snd_soc_component_resume()" to the asoc tree
Date: Mon,  5 Aug 2019 17:09:59 +0100 (BST)
Message-ID: <20190805160959.868D82742E44@ypsilon.sirena.org.uk>
References: <875znp5rm2.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A8E68F805F5
 for <alsa-devel@alsa-project.org>; Mon,  5 Aug 2019 18:10:00 +0200 (CEST)
In-Reply-To: <875znp5rm2.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: soc-component: add snd_soc_component_resume()

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

>From 9a840cbac77a90e8406296aaa132ebf2c84ed9e3 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 26 Jul 2019 13:51:08 +0900
Subject: [PATCH] ASoC: soc-component: add snd_soc_component_resume()

Current ALSA SoC is directly using component->driver->xxx,
thus, it is deep nested, and makes code difficult to read,
and is not good for encapsulation.
This patch adds new snd_soc_component_resume() and use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/875znp5rm2.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc-component.h | 1 +
 sound/soc/soc-component.c     | 7 +++++++
 sound/soc/soc-core.c          | 4 +---
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/sound/soc-component.h b/include/sound/soc-component.h
index cdb014f41fd1..1e3b70855ba7 100644
--- a/include/sound/soc-component.h
+++ b/include/sound/soc-component.h
@@ -354,5 +354,6 @@ int snd_soc_component_trigger(struct snd_soc_component *component,
 			      struct snd_pcm_substream *substream,
 			      int cmd);
 void snd_soc_component_suspend(struct snd_soc_component *component);
+void snd_soc_component_resume(struct snd_soc_component *component);
 
 #endif /* __SOC_COMPONENT_H */
diff --git a/sound/soc/soc-component.c b/sound/soc/soc-component.c
index f0e63cd991c8..cbae7672b72d 100644
--- a/sound/soc/soc-component.c
+++ b/sound/soc/soc-component.c
@@ -354,3 +354,10 @@ void snd_soc_component_suspend(struct snd_soc_component *component)
 		component->driver->suspend(component);
 	component->suspended = 1;
 }
+
+void snd_soc_component_resume(struct snd_soc_component *component)
+{
+	if (component->driver->resume)
+		component->driver->resume(component);
+	component->suspended = 0;
+}
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 855b19abc1d2..6cdfe7b2fe06 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -593,9 +593,7 @@ static void soc_resume_deferred(struct work_struct *work)
 
 	for_each_card_components(card, component) {
 		if (component->suspended) {
-			if (component->driver->resume)
-				component->driver->resume(component);
-			component->suspended = 0;
+			snd_soc_component_resume(component);
 		}
 	}
 
-- 
2.20.1
