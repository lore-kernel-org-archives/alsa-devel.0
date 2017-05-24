From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Support for multiple
	data blocks" to the asoc tree
Date: Wed, 24 May 2017 18:41:44 +0100
Message-ID: <E1dDaI4-0002nU-TE@debutante>
References: <1494857671-19257-3-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B6353267376
 for <alsa-devel@alsa-project.org>; Wed, 24 May 2017 19:41:53 +0200 (CEST)
In-Reply-To: <1494857671-19257-3-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shreyas NC <shreyas.nc@intel.com>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, lgirdwood@gmail.com, patches.audio@intel.com, tiwai@suse.de, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Support for multiple data blocks

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 133e6e5c27340fe2205537373e50d43881a0f745 Mon Sep 17 00:00:00 2001
From: Shreyas NC <shreyas.nc@intel.com>
Date: Mon, 15 May 2017 19:44:31 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Support for multiple data blocks

Module init params are additional data block in the module private data.
Skylake driver doesn't yet have support to parse multiple data blocks if
it appears in private data. Add support for parsing of multiple data
blocks and module init params.

Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-topology.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index b28199a5348c..4c3bdff092bd 100644
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
2.11.0
