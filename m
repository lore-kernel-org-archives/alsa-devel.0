From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: [RFC PATCH 1/3] ASoC: core: do not unload topology in
	unregister_component()
Date: Thu,  4 Apr 2019 17:30:38 -0700
Message-ID: <20190405003040.8709-2-ranjani.sridharan@linux.intel.com>
References: <20190405003040.8709-1-ranjani.sridharan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 467C2F8968A
 for <alsa-devel@alsa-project.org>; Fri,  5 Apr 2019 02:30:56 +0200 (CEST)
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

Typically, topology is loaded when the card is registered
by the machine driver and the link components are probed.
Therefore, it should be unloaded when the link components
are removed. This will make the register/unregister component
methods balanced.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/soc-core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 6f4842977b8d..ffd4db97a2ee 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3327,8 +3327,6 @@ static int __snd_soc_unregister_component(struct device *dev)
 		if (dev != component->dev)
 			continue;
 
-		snd_soc_tplg_component_remove(component,
-					      SND_SOC_TPLG_INDEX_ALL);
 		snd_soc_component_del_unlocked(component);
 		found = 1;
 		break;
-- 
2.17.1
