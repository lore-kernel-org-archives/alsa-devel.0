From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: remove duplicate mutex_unlock
	from snd_soc_unregister_component()" to the asoc tree
Date: Mon, 07 Aug 2017 16:53:02 +0100
Message-ID: <E1dekL0-0005S3-TW@debutante>
References: <877eygjfx2.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0BF5C2672A8
 for <alsa-devel@alsa-project.org>; Mon,  7 Aug 2017 17:53:12 +0200 (CEST)
In-Reply-To: <877eygjfx2.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-core: remove duplicate mutex_unlock from snd_soc_unregister_component()

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 21a035287e28ec225fe7dfd1fffc509efd26a5db Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 7 Aug 2017 02:06:40 +0000
Subject: [PATCH] ASoC: soc-core: remove duplicate mutex_unlock from
 snd_soc_unregister_component()

Current snd_soc_unregister_component() is using multiple mutex_unlock()
for found/non-found cases. But it is unreadable and confusable code.
This patch tidyup current code to be readable.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index b21488972198..3bb8c63564cf 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3328,21 +3328,25 @@ EXPORT_SYMBOL_GPL(snd_soc_register_component);
 void snd_soc_unregister_component(struct device *dev)
 {
 	struct snd_soc_component *component;
+	int found = 0;
 
 	mutex_lock(&client_mutex);
 	list_for_each_entry(component, &component_list, list) {
-		if (dev == component->dev && component->registered_as_component)
-			goto found;
+		if (dev != component->dev ||
+		    !component->registered_as_component)
+			continue;
+
+		snd_soc_tplg_component_remove(component, SND_SOC_TPLG_INDEX_ALL);
+		snd_soc_component_del_unlocked(component);
+		found = 1;
+		break;
 	}
 	mutex_unlock(&client_mutex);
-	return;
 
-found:
-	snd_soc_tplg_component_remove(component, SND_SOC_TPLG_INDEX_ALL);
-	snd_soc_component_del_unlocked(component);
-	mutex_unlock(&client_mutex);
-	snd_soc_component_cleanup(component);
-	kfree(component);
+	if (found) {
+		snd_soc_component_cleanup(component);
+		kfree(component);
+	}
 }
 EXPORT_SYMBOL_GPL(snd_soc_unregister_component);
 
-- 
2.13.3
