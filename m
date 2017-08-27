From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Parse multiple manifest
	data blocks" to the asoc tree
Date: Sun, 27 Aug 2017 14:39:13 +0100 (BST)
Message-ID: <20170827133913.B0EC84400E7@finisterre.ee.mobilebroadband>
References: <20170821084646.6525-2-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E8D92674F7
 for <alsa-devel@alsa-project.org>; Sun, 27 Aug 2017 15:39:14 +0200 (CEST)
In-Reply-To: <20170821084646.6525-2-guneshwor.o.singh@intel.com>
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
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Patches Audio <patches.audio@intel.com>, Mark Brown <broonie@kernel.org>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Parse multiple manifest data blocks

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

>From 9fc129f6e5de01ce5fccf033485e40dfa429b45c Mon Sep 17 00:00:00 2001
From: Shreyas NC <shreyas.nc@intel.com>
Date: Wed, 23 Aug 2017 19:33:48 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Parse multiple manifest data blocks

Currently we can parse a single manifest data block. But manifest
private data can have multiple data blocks.

So, fix the parsing logic to parse multiple data blocks by returning
offset of each parsed data block.

Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.13.2
