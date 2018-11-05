From: "He, Bo" <bo.he@intel.com>
Subject: [PATCH] fix the kernel panic due to wrong use the dev memory API
Date: Mon, 5 Nov 2018 08:29:14 +0000
Message-ID: <CD6925E8781EFD4D8E11882D20FC406D529FE3B6@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>, "Singh, Guneshwor O" <guneshwor.o.singh@intel.com>, "Periyasamy, SriramX" <sriramx.periyasamy@intel.com>, "Kale, Sanyog R" <sanyog.r.kale@intel.com>, "Kesapragada, Pardha Saradhi" <pardha.saradhi.kesapragada@intel.com>, "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>, "guruprasadx.pawse@intel.com" <guruprasadx.pawse@intel.com>, "Ughreja, Rakesh A" <rakesh.a.ughreja@intel.com>, "Prakash, Divya1" <divya1.prakash@intel.com>, "Diwakar, Praveen" <praveen.diwakar@intel.com>, "Zhang, Yanmin" <yanmin.zhang@intel.com>
List-Id: alsa-devel@alsa-project.org

skl->dais is allocated with devm_kcalloc, can't free with
the krealloc. Memory allocated with devm API is automatically freed
on driver detach, Like all other devres resources.

Refer to drivers/base/devres.c devm_kmalloc for more details.

Signed-off-by: he, bo <bo.he@intel.com>
---
 sound/soc/intel/skylake/skl-pcm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 823e391..928d314 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -1438,7 +1438,8 @@ int skl_platform_register(struct device *dev)
 	}
 
 	if (!skl->use_tplg_pcm) {
-		dais = krealloc(skl->dais, sizeof(skl_fe_dai) +
+		devm_kfree(dev, skl->dais);
+		dais = devm_kcalloc(dev, skl->dais, sizeof(skl_fe_dai) +
 				sizeof(skl_platform_dai), GFP_KERNEL);
 		if (!dais) {
 			ret = -ENOMEM;
@@ -1472,7 +1473,5 @@ int skl_platform_unregister(struct device *dev)
 		}
 	}
 
-	kfree(skl->dais);
-
 	return 0;
 }
-- 
2.7.4
