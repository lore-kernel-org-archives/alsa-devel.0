From: bgoswami@codeaurora.org
Subject: [PATCH] ASoC: soc-core: export function to find
	components
Date: Tue, 18 Jun 2019 00:47:38 -0700
Message-ID: <1560844059-5897-1-git-send-email-bgoswami@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3F8AAF89682
 for <alsa-devel@alsa-project.org>; Tue, 18 Jun 2019 09:47:45 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, srinivas.kandagatla@linaro.org, plai@codeaurora.org
List-Id: alsa-devel@alsa-project.org

From: Banajit Goswami <bgoswami@codeaurora.org>

Drivers may need to use the ASoC core function to
find out whether a particular component is already
registered with ASoC core or not.
Export the function so that drivers can use it outside
of the file.

Signed-off-by: Banajit Goswami <bgoswami@codeaurora.org>
---
 include/sound/soc.h  |  2 ++
 sound/soc/soc-core.c | 13 ++++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 482b4ea..def975f 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1405,6 +1405,8 @@ int snd_soc_component_update_bits_async(struct snd_soc_component *component,
 void snd_soc_component_async_complete(struct snd_soc_component *component);
 int snd_soc_component_test_bits(struct snd_soc_component *component,
 	unsigned int reg, unsigned int mask, unsigned int value);
+struct snd_soc_component *soc_find_component(
+	const struct device_node *of_node, const char *name);
 
 /* component wide operations */
 int snd_soc_component_set_sysclk(struct snd_soc_component *component,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 41c0cfa..50a9977 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -741,7 +741,17 @@ int snd_soc_resume(struct device *dev)
 static const struct snd_soc_dai_ops null_dai_ops = {
 };
 
-static struct snd_soc_component *soc_find_component(
+/**
+ * soc_find_component: find a component from component_list in ASoC core
+ *
+ * @of_node: of_node of the component to query.
+ * @name: name of the component to query.
+ *
+ * function to find out if a component is already registered with ASoC core.
+ *
+ * Returns component handle for success, else NULL error.
+ */
+struct snd_soc_component *soc_find_component(
 	const struct device_node *of_node, const char *name)
 {
 	struct snd_soc_component *component;
@@ -764,6 +774,7 @@ static struct snd_soc_component *soc_find_component(
 
 	return NULL;
 }
+EXPORT_SYMBOL(soc_find_component);
 
 static int snd_soc_is_matching_component(
 	const struct snd_soc_dai_link_component *dlc,
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
