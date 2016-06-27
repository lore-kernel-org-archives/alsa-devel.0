From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [RFC 06/11] ASoC: dapm: Create API to add a single
	route element
Date: Mon, 27 Jun 2016 09:17:59 +0530
Message-ID: <1466999284-14782-7-git-send-email-subhransu.s.prusty@intel.com>
References: <1466999284-14782-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id CC7EC2664E9
 for <alsa-devel@alsa-project.org>; Mon, 27 Jun 2016 05:51:45 +0200 (CEST)
In-Reply-To: <1466999284-14782-1-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, patches.audio@intel.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

This is useful when one route element is added at a time.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
---
 include/sound/soc-dapm.h |  2 ++
 sound/soc/soc-dapm.c     | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 9706946..fffd1f1 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -396,6 +396,8 @@ int snd_soc_dapm_new_widgets(struct snd_soc_card *card);
 void snd_soc_dapm_free(struct snd_soc_dapm_context *dapm);
 int snd_soc_dapm_add_routes(struct snd_soc_dapm_context *dapm,
 			    const struct snd_soc_dapm_route *route, int num);
+int snd_soc_dapm_add_route_single(struct snd_soc_dapm_context *dapm,
+			    const struct snd_soc_dapm_route *route);
 int snd_soc_dapm_del_routes(struct snd_soc_dapm_context *dapm,
 			    const struct snd_soc_dapm_route *route, int num);
 int snd_soc_dapm_weak_routes(struct snd_soc_dapm_context *dapm,
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index c446485..ad67647 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2802,6 +2802,27 @@ int snd_soc_dapm_add_routes(struct snd_soc_dapm_context *dapm,
 EXPORT_SYMBOL_GPL(snd_soc_dapm_add_routes);
 
 /**
+ * snd_soc_dapm_add_route_single - Add a single route
+ * @dapm: DAPM context
+ * @route: audio route element
+ *
+ * Connects 2 dapm widgets together via a named audio path.
+ * xxx_add_route is already managed through dapm lock.
+ */
+int snd_soc_dapm_add_route_single(struct snd_soc_dapm_context *dapm,
+			    const struct snd_soc_dapm_route *route)
+{
+	int ret;
+
+	mutex_lock_nested(&dapm->card->dapm_mutex, SND_SOC_DAPM_CLASS_INIT);
+	ret = snd_soc_dapm_add_route(dapm, route);
+	mutex_unlock(&dapm->card->dapm_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snd_soc_dapm_add_route_single);
+
+/**
  * snd_soc_dapm_del_routes - Remove routes between DAPM widgets
  * @dapm: DAPM context
  * @route: audio routes
-- 
1.9.1
