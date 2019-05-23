From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: [PATCH] ASoC: core: lock client_mutex while removing
	link components
Date: Thu, 23 May 2019 10:12:01 -0700
Message-ID: <20190523171201.31104-1-ranjani.sridharan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CE7C9F80C0F
 for <alsa-devel@alsa-project.org>; Thu, 23 May 2019 19:12:05 +0200 (CEST)
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
Cc: tiwai@suse.de, broonie@kernel.org, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Removing link components results in topology unloading. So,
acquire the client_mutex before removing components in
soc_remove_link_components. This will prevent the lockdep warning
seen when dai links are removed during topology removal.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/soc-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index ce8c057bcd5b..bbb52fbd195e 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1010,12 +1010,14 @@ static void soc_remove_link_components(struct snd_soc_card *card,
 	struct snd_soc_component *component;
 	struct snd_soc_rtdcom_list *rtdcom;
 
+	mutex_lock(&client_mutex);
 	for_each_rtdcom(rtd, rtdcom) {
 		component = rtdcom->component;
 
 		if (component->driver->remove_order == order)
 			soc_remove_component(component);
 	}
+	mutex_unlock(&client_mutex);
 }
 
 static void soc_remove_dai_links(struct snd_soc_card *card)
-- 
2.17.1
