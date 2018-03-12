From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Add snd_soc_of_put_dai_link_codecs()
	helper function" to the asoc tree
Date: Mon, 12 Mar 2018 17:58:55 +0000 (GMT)
Message-ID: <20180312175855.1D2B2440079@finisterre.ee.mobilebroadband>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id DD804266E43
 for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2018 18:58:59 +0100 (CET)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Add snd_soc_of_put_dai_link_codecs() helper function

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

>From 946857636d279486eaa47c930930185631f28fce Mon Sep 17 00:00:00 2001
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Date: Fri, 9 Mar 2018 18:48:54 +0100
Subject: [PATCH] ASoC: Add snd_soc_of_put_dai_link_codecs() helper function

The code for dereferencing device nodes in the 'codecs' array is moved
to a separate function so we can avoid open coding that in drivers.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h  |  1 +
 sound/soc/soc-core.c | 32 +++++++++++++++++++++++---------
 2 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 747fd583b9dc..4a387f0b3d56 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1807,6 +1807,7 @@ int snd_soc_of_get_dai_name(struct device_node *of_node,
 int snd_soc_of_get_dai_link_codecs(struct device *dev,
 				   struct device_node *of_node,
 				   struct snd_soc_dai_link *dai_link);
+void snd_soc_of_put_dai_link_codecs(struct snd_soc_dai_link *dai_link);
 
 int snd_soc_add_dai_link(struct snd_soc_card *card,
 				struct snd_soc_dai_link *dai_link);
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 96c44f6576c9..a1f86e85bff9 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -4397,6 +4397,26 @@ int snd_soc_of_get_dai_name(struct device_node *of_node,
 }
 EXPORT_SYMBOL_GPL(snd_soc_of_get_dai_name);
 
+/*
+ * snd_soc_of_put_dai_link_codecs - Dereference device nodes in the codecs array
+ * @dai_link: DAI link
+ *
+ * Dereference device nodes acquired by snd_soc_of_get_dai_link_codecs().
+ */
+void snd_soc_of_put_dai_link_codecs(struct snd_soc_dai_link *dai_link)
+{
+	struct snd_soc_dai_link_component *component = dai_link->codecs;
+	int index;
+
+	for (index = 0; index < dai_link->num_codecs; index++, component++) {
+		if (!component->of_node)
+			break;
+		of_node_put(component->of_node);
+		component->of_node = NULL;
+	}
+}
+EXPORT_SYMBOL_GPL(snd_soc_of_put_dai_link_codecs);
+
 /*
  * snd_soc_of_get_dai_link_codecs - Parse a list of CODECs in the devicetree
  * @dev: Card device
@@ -4406,7 +4426,8 @@ EXPORT_SYMBOL_GPL(snd_soc_of_get_dai_name);
  * Builds an array of CODEC DAI components from the DAI link property
  * 'sound-dai'.
  * The array is set in the DAI link and the number of DAIs is set accordingly.
- * The device nodes in the array (of_node) must be dereferenced by the caller.
+ * The device nodes in the array (of_node) must be dereferenced by calling
+ * snd_soc_of_put_dai_link_codecs() on @dai_link.
  *
  * Returns 0 for success
  */
@@ -4454,14 +4475,7 @@ int snd_soc_of_get_dai_link_codecs(struct device *dev,
 	}
 	return 0;
 err:
-	for (index = 0, component = dai_link->codecs;
-	     index < dai_link->num_codecs;
-	     index++, component++) {
-		if (!component->of_node)
-			break;
-		of_node_put(component->of_node);
-		component->of_node = NULL;
-	}
+	snd_soc_of_put_dai_link_codecs(dai_link);
 	dai_link->codecs = NULL;
 	dai_link->num_codecs = 0;
 	return ret;
-- 
2.16.2
