From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ASoC: Intel: Skylake: Fix a shift wrapping bug
Date: Thu, 13 Oct 2016 11:55:48 +0300
Message-ID: <20161013085548.GK16198@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Dharageswari R <dharageswari.r@intel.com>
Cc: Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Vinod Koul <vinod.koul@intel.com>, Shreyas NC <shreyas.nc@intel.com>, Senthilnathan Veppur <senthilnathanx.veppur@intel.com>, Ramesh Babu <ramesh.babu@intel.com>, Colin Ian King <colin.king@canonical.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

"*val" is a u64.  It definitely looks like we intend to use the high 32
bits as well.

Fixes: 700a9a63f9c1 ("ASoC: Intel: Skylake: Add module instance id generation APIs")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/soc/intel/skylake/skl-sst-utils.c b/sound/soc/intel/skylake/skl-sst-utils.c
index 8dc0303..ea162fb 100644
--- a/sound/soc/intel/skylake/skl-sst-utils.c
+++ b/sound/soc/intel/skylake/skl-sst-utils.c
@@ -179,7 +179,7 @@ static inline int skl_getid_32(struct uuid_module *module, u64 *val,
 		index = ffz(mask_val);
 		pvt_id = index + word1_mask + word2_mask;
 		if (pvt_id <= (max_inst - 1)) {
-			*val |= 1 << (index + word1_mask);
+			*val |= 1ULL << (index + word1_mask);
 			return pvt_id;
 		}
 	}
