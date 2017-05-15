From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH 3/3] ASoC: Intel: Skylake: Support for multiple
	data blocks
Date: Mon, 15 May 2017 19:44:31 +0530
Message-ID: <1494857671-19257-3-git-send-email-subhransu.s.prusty@intel.com>
References: <1494857671-19257-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id EA02026743D
 for <alsa-devel@alsa-project.org>; Mon, 15 May 2017 16:28:41 +0200 (CEST)
In-Reply-To: <1494857671-19257-1-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: tiwai@suse.de, lgirdwood@gmail.com, patches.audio@intel.com, broonie@kernel.org, Shreyas NC <shreyas.nc@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Shreyas NC <shreyas.nc@intel.com>

Module init params are additional data block in the module private data.
Skylake driver doesn't yet have support to parse multiple data blocks if
it appears in private data. Add support for parsing of multiple data
blocks and module init params.

Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
---
 sound/soc/intel/skylake/skl-topology.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 43ca39d61559..b687ae455a61 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -2070,6 +2070,16 @@ static int skl_tplg_get_token(struct device *dev,
 
 		break;
 
+	case SKL_TKN_U32_CAPS_SET_PARAMS:
+		mconfig->formats_config.set_params =
+				tkn_elem->value;
+		break;
+
+	case SKL_TKN_U32_CAPS_PARAMS_ID:
+		mconfig->formats_config.param_id =
+				tkn_elem->value;
+		break;
+
 	case SKL_TKN_U32_PROC_DOMAIN:
 		mconfig->domain =
 			tkn_elem->value;
@@ -2147,7 +2157,7 @@ static int skl_tplg_get_tokens(struct device *dev,
 		tuple_size += tkn_count * sizeof(*tkn_elem);
 	}
 
-	return 0;
+	return off;
 }
 
 /*
@@ -2198,10 +2208,11 @@ static int skl_tplg_get_pvt_data(struct snd_soc_tplg_dapm_widget *tplg_w,
 	num_blocks = ret;
 
 	off += array->size;
-	array = (struct snd_soc_tplg_vendor_array *)(tplg_w->priv.data + off);
-
 	/* Read the BLOCK_TYPE and BLOCK_SIZE descriptor */
 	while (num_blocks > 0) {
+		array = (struct snd_soc_tplg_vendor_array *)
+				(tplg_w->priv.data + off);
+
 		ret = skl_tplg_get_desc_blocks(dev, array);
 
 		if (ret < 0)
@@ -2237,7 +2248,9 @@ static int skl_tplg_get_pvt_data(struct snd_soc_tplg_dapm_widget *tplg_w,
 				memcpy(mconfig->formats_config.caps, data,
 					mconfig->formats_config.caps_size);
 			--num_blocks;
+			ret = mconfig->formats_config.caps_size;
 		}
+		off += ret;
 	}
 
 	return 0;
-- 
1.9.1
