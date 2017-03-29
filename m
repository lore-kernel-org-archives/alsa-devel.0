From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Don't unload module
	when in use" to the asoc tree
Date: Wed, 29 Mar 2017 12:54:27 +0100
Message-ID: <E1ctCBH-0001YN-3b@debutante>
References: <1490275926-2270-6-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 73203266F88
 for <alsa-devel@alsa-project.org>; Wed, 29 Mar 2017 13:54:36 +0200 (CEST)
In-Reply-To: <1490275926-2270-6-git-send-email-jeeja.kp@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, patches.audio@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Don't unload module when in use

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

>From f7ea77772dfaa404ac0bcdea5c262c24e8b860db Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Fri, 24 Mar 2017 23:10:28 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Don't unload module when in use

A module may have multiple instances in DSP, so unload only when usage
count is zero.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-sst.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-sst.c b/sound/soc/intel/skylake/skl-sst.c
index 39d4aaac73bf..539529729e3f 100644
--- a/sound/soc/intel/skylake/skl-sst.c
+++ b/sound/soc/intel/skylake/skl-sst.c
@@ -417,6 +417,11 @@ static int skl_unload_module(struct sst_dsp *ctx, u16 mod_id)
 		dev_err(ctx->dev, "Module bad usage cnt!:%d\n", usage_cnt);
 		return -EIO;
 	}
+
+	/* if module is used by others return, no need to unload */
+	if (usage_cnt > 0)
+		return 0;
+
 	ret = skl_ipc_unload_modules(&skl->ipc,
 			SKL_NUM_MODULES, &mod_id);
 	if (ret < 0) {
-- 
2.11.0
