From: mengdong.lin@linux.intel.com
Subject: [PATCH 1/4] ASoC: Export snd_soc_find_dai()
Date: Tue, 19 Apr 2016 13:12:25 +0800
Message-ID: <5e7147f76b2c54d2d23eb1f6a1146a3716bd5172.1461042239.git.mengdong.lin@linux.intel.com>
References: <cover.1461042239.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C15D265C99
 for <alsa-devel@alsa-project.org>; Tue, 19 Apr 2016 07:09:55 +0200 (CEST)
In-Reply-To: <cover.1461042239.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, vinod.koul@intel.com, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, rakesh.a.ughreja@intel.com, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

This API can be used by topology to find an existing BE dai by name
and further configure it.

Topology will also check DAI ID to avoid wrong match.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 02b4a21..7687e2d 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1683,6 +1683,9 @@ void snd_soc_remove_dai_link(struct snd_soc_card *card,
 int snd_soc_register_dai(struct snd_soc_component *component,
 	struct snd_soc_dai_driver *dai_drv);
 
+struct snd_soc_dai *snd_soc_find_dai(
+	const struct snd_soc_dai_link_component *dlc);
+
 #include <sound/soc-dai.h>
 
 #ifdef CONFIG_DEBUG_FS
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index d2e62b15..07663de 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -930,7 +930,7 @@ static struct snd_soc_component *soc_find_component(
 	return NULL;
 }
 
-static struct snd_soc_dai *snd_soc_find_dai(
+struct snd_soc_dai *snd_soc_find_dai(
 	const struct snd_soc_dai_link_component *dlc)
 {
 	struct snd_soc_component *component;
@@ -959,6 +959,7 @@ static struct snd_soc_dai *snd_soc_find_dai(
 
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(snd_soc_find_dai);
 
 static bool soc_is_dai_link_bound(struct snd_soc_card *card,
 		struct snd_soc_dai_link *dai_link)
-- 
2.5.0
