From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: fix swapped order of
	function arguments dir and pin_index" to the asoc tree
Date: Mon, 25 Sep 2017 17:00:54 +0100 (BST)
Message-ID: <20170925160054.22C67440053@finisterre.ee.mobilebroadband>
References: <20170920130125.12984-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 25A53266F4E
 for <alsa-devel@alsa-project.org>; Mon, 25 Sep 2017 18:35:34 +0200 (CEST)
In-Reply-To: <20170920130125.12984-1-colin.king@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Colin Ian King <colin.king@canonical.com>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Ramesh Babu <ramesh.babu@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: fix swapped order of function arguments dir and pin_index

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

>From 2b79b15c258a90c216efc14f0a5d4b88b4b2494d Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Wed, 20 Sep 2017 14:01:25 +0100
Subject: [PATCH] ASoC: Intel: Skylake: fix swapped order of function arguments
 dir and pin_index

The call to slk_tplg_fill_res_tkn is passing dir and pin_index in the
wrong order, they need to be in pin_index, dir order to match the function
slk_tplg_fill_res_tkn  correctly.

Detected by CoveritScan, CID#1454992 ("Arguments in wrong order")

Fixes: f6fa56e22559 ("ASoC: Intel: Skylake: Parse and update module config structure")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Tested-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 22f768ca3c73..27bcb62568fb 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -2382,7 +2382,7 @@ static int skl_tplg_get_token(struct device *dev,
 	case SKL_TKN_U32_MAX_MCPS:
 	case SKL_TKN_U32_OBS:
 	case SKL_TKN_U32_IBS:
-		ret = skl_tplg_fill_res_tkn(dev, tkn_elem, res, dir, pin_index);
+		ret = skl_tplg_fill_res_tkn(dev, tkn_elem, res, pin_index, dir);
 		if (ret < 0)
 			return ret;
 
-- 
2.14.1
