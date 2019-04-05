From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: [RFC PATCH 3/3] ASoC: core: remove link components
	before cleaning up card resources
Date: Thu,  4 Apr 2019 17:30:40 -0700
Message-ID: <20190405003040.8709-4-ranjani.sridharan@linux.intel.com>
References: <20190405003040.8709-1-ranjani.sridharan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BB819F8968A
 for <alsa-devel@alsa-project.org>; Fri,  5 Apr 2019 02:30:59 +0200 (CEST)
In-Reply-To: <20190405003040.8709-1-ranjani.sridharan@linux.intel.com>
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, broonie@kernel.org, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

When the card is registered by the machine driver,
dai link components are probed after the snd_card is
created. This is done in snd_soc_bind_card() which calls
snd_soc_instantiate_card() to first create the snd_card
and then probes the link components by calling
soc_probe_link_components(). The snd_card is used by the
component driver to add the kcontrols associated
with dapm widgets to the card.

When the machine driver is unregistered, the snd_card
is freed when the card resources are cleaned up.
But the snd_card needs to be valid while unloading the
topology dapm widgets in order to remove the kcontrols
from the card.

Since, unloading topology is done when the component
driver is removed, the link components should be removed
in snd_soc_unbind_card(). This will ensure that the kcontrols
are removed before the card resources are cleaned up and
the snd_card itself is freed.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/soc-core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index ffd4db97a2ee..6277b2da68b7 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2831,10 +2831,21 @@ EXPORT_SYMBOL_GPL(snd_soc_register_card);
 
 static void snd_soc_unbind_card(struct snd_soc_card *card, bool unregister)
 {
+	struct snd_soc_pcm_runtime *rtd;
+	int order;
+
 	if (card->instantiated) {
 		card->instantiated = false;
 		snd_soc_dapm_shutdown(card);
 		snd_soc_flush_all_delayed_work(card);
+
+		/* remove all components used by DAI links on this card */
+		for_each_comp_order(order) {
+			for_each_card_rtds(card, rtd) {
+				soc_remove_link_components(card, rtd, order);
+			}
+		}
+
 		soc_cleanup_card_resources(card);
 		if (!unregister)
 			list_add(&card->list, &unbind_card_list);
-- 
2.17.1
