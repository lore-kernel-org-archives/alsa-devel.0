From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: [RFC PATCH 2/3] ASoC: intel: skylake: add remove()
	callback for component driver
Date: Thu,  4 Apr 2019 17:30:39 -0700
Message-ID: <20190405003040.8709-3-ranjani.sridharan@linux.intel.com>
References: <20190405003040.8709-1-ranjani.sridharan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 322D0F8071D
 for <alsa-devel@alsa-project.org>; Fri,  5 Apr 2019 02:30:58 +0200 (CEST)
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

Topology is not unloaded in the core during unregister_component()
anymore. So, add the remove() callback that will unload the
topology.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/intel/skylake/skl-pcm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 56099db8f86d..57031b6d4d45 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -1462,9 +1462,16 @@ static int skl_platform_soc_probe(struct snd_soc_component *component)
 	return 0;
 }
 
+static void skl_pcm_remove(struct snd_soc_component *component)
+{
+	/* remove topology */
+	snd_soc_tplg_component_remove(component, SND_SOC_TPLG_INDEX_ALL);
+}
+
 static const struct snd_soc_component_driver skl_component  = {
 	.name		= "pcm",
 	.probe		= skl_platform_soc_probe,
+	.remove		= skl_pcm_remove,
 	.ops		= &skl_platform_ops,
 	.pcm_new	= skl_pcm_new,
 	.pcm_free	= skl_pcm_free,
-- 
2.17.1
