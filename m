From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: [PATCH] ASoC: core: Fix deadlock in
	snd_soc_instantiate_card()
Date: Fri,  7 Jun 2019 22:07:06 -0700
Message-ID: <20190608050706.14837-1-ranjani.sridharan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9EE5DF80709
 for <alsa-devel@alsa-project.org>; Sat,  8 Jun 2019 07:07:11 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: guillaume.tucker@collabora.com, broonie@kernel.org, tiwai@suse.com, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Move the client_mutex lock to snd_soc_unbind_card() before
removing link components. This prevents the deadlock
in the error path in snd_soc_instantiate_card().

Fixes: 34ac3c3eb8 (ASoC: core: lock client_mutex while removing
link components)
Reported-by: kernelci.org bot <bot@kernelci.org>
Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/soc-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index f0fa289c90d8..23538868ed76 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1018,14 +1018,12 @@ static void soc_remove_link_components(struct snd_soc_card *card,
 	struct snd_soc_component *component;
 	struct snd_soc_rtdcom_list *rtdcom;
 
-	mutex_lock(&client_mutex);
 	for_each_rtdcom(rtd, rtdcom) {
 		component = rtdcom->component;
 
 		if (component->driver->remove_order == order)
 			soc_remove_component(component);
 	}
-	mutex_unlock(&client_mutex);
 }
 
 static void soc_remove_dai_links(struct snd_soc_card *card)
@@ -2749,12 +2747,14 @@ static void snd_soc_unbind_card(struct snd_soc_card *card, bool unregister)
 		snd_soc_dapm_shutdown(card);
 		snd_soc_flush_all_delayed_work(card);
 
+		mutex_lock(&client_mutex);
 		/* remove all components used by DAI links on this card */
 		for_each_comp_order(order) {
 			for_each_card_rtds(card, rtd) {
 				soc_remove_link_components(card, rtd, order);
 			}
 		}
+		mutex_unlock(&client_mutex);
 
 		soc_cleanup_card_resources(card);
 		if (!unregister)
-- 
2.17.1
