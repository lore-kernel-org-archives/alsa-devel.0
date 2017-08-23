From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Subject: [PATCH v2 1/7] ASoC: Intel: Skylake: Parse multiple
	manifest data blocks
Date: Wed, 23 Aug 2017 19:33:48 +0530
Message-ID: <20170823140354.792-2-guneshwor.o.singh@intel.com>
References: <20170823140354.792-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 101B0267765
 for <alsa-devel@alsa-project.org>; Wed, 23 Aug 2017 16:04:12 +0200 (CEST)
In-Reply-To: <20170823140354.792-1-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Patches Audio <patches.audio@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Shreyas NC <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Shreyas NC <shreyas.nc@intel.com>

Currently we can parse a single manifest data block. But manifest
private data can have multiple data blocks.

So, fix the parsing logic to parse multiple data blocks by returning
offset of each parsed data block.

Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
---
 sound/soc/intel/skylake/skl-topology.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 350d2387f737..f14b373f65d7 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -2721,14 +2721,12 @@ static int skl_tplg_get_manifest_tkn(struct device *dev,
 
 			tkn_count = tkn_count + ret;
 			tkn_elem++;
-			tuple_size += tkn_count *
-				sizeof(struct snd_soc_tplg_vendor_value_elem);
-			break;
 		}
+		tuple_size += (tkn_count * sizeof(*tkn_elem));
 		tkn_count = 0;
 	}
 
-	return 0;
+	return off;
 }
 
 /*
@@ -2751,11 +2749,10 @@ static int skl_tplg_get_manifest_data(struct snd_soc_tplg_manifest *manifest,
 	num_blocks = ret;
 
 	off += array->size;
-	array = (struct snd_soc_tplg_vendor_array *)
-			(manifest->priv.data + off);
-
 	/* Read the BLOCK_TYPE and BLOCK_SIZE descriptor */
 	while (num_blocks > 0) {
+		array = (struct snd_soc_tplg_vendor_array *)
+				(manifest->priv.data + off);
 		ret = skl_tplg_get_desc_blocks(dev, array);
 
 		if (ret < 0)
@@ -2789,6 +2786,7 @@ static int skl_tplg_get_manifest_data(struct snd_soc_tplg_manifest *manifest,
 		} else {
 			return -EINVAL;
 		}
+		off += ret;
 	}
 
 	return 0;
-- 
2.14.1
