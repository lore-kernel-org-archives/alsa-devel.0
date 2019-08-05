From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-component: add
	snd_soc_component_is_suspended()" to the asoc tree
Date: Mon,  5 Aug 2019 17:09:59 +0100 (BST)
Message-ID: <20190805160959.4B5E42742D06@ypsilon.sirena.org.uk>
References: <874l395rlx.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3B79DF805E2
 for <alsa-devel@alsa-project.org>; Mon,  5 Aug 2019 18:10:00 +0200 (CEST)
In-Reply-To: <874l395rlx.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: soc-component: add snd_soc_component_is_suspended()

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

>From e40fadbcef583808c11d2e86b8ac1c652731468e Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 26 Jul 2019 13:51:13 +0900
Subject: [PATCH] ASoC: soc-component: add snd_soc_component_is_suspended()

Current ALSA SoC is directly using component->xxx,
But, it is not good for encapsulation.
This patch adds new snd_soc_component_is_suspended() and use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/874l395rlx.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc-component.h | 1 +
 sound/soc/soc-component.c     | 5 +++++
 sound/soc/soc-core.c          | 5 ++---
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/sound/soc-component.h b/include/sound/soc-component.h
index 1e3b70855ba7..9600dc4ca6b4 100644
--- a/include/sound/soc-component.h
+++ b/include/sound/soc-component.h
@@ -355,5 +355,6 @@ int snd_soc_component_trigger(struct snd_soc_component *component,
 			      int cmd);
 void snd_soc_component_suspend(struct snd_soc_component *component);
 void snd_soc_component_resume(struct snd_soc_component *component);
+int snd_soc_component_is_suspended(struct snd_soc_component *component);
 
 #endif /* __SOC_COMPONENT_H */
diff --git a/sound/soc/soc-component.c b/sound/soc/soc-component.c
index cbae7672b72d..0a9ca84d7ac6 100644
--- a/sound/soc/soc-component.c
+++ b/sound/soc/soc-component.c
@@ -361,3 +361,8 @@ void snd_soc_component_resume(struct snd_soc_component *component)
 		component->driver->resume(component);
 	component->suspended = 0;
 }
+
+int snd_soc_component_is_suspended(struct snd_soc_component *component)
+{
+	return component->suspended;
+}
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 6cdfe7b2fe06..ea93edd328a2 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -503,7 +503,7 @@ int snd_soc_suspend(struct device *dev)
 		 * If there are paths active then the COMPONENT will be held
 		 * with bias _ON and should not be suspended.
 		 */
-		if (!component->suspended) {
+		if (!snd_soc_component_is_suspended(component)) {
 			switch (snd_soc_dapm_get_bias_level(dapm)) {
 			case SND_SOC_BIAS_STANDBY:
 				/*
@@ -592,9 +592,8 @@ static void soc_resume_deferred(struct work_struct *work)
 	}
 
 	for_each_card_components(card, component) {
-		if (component->suspended) {
+		if (snd_soc_component_is_suspended(component))
 			snd_soc_component_resume(component);
-		}
 	}
 
 	for_each_card_rtds(card, rtd) {
-- 
2.20.1
