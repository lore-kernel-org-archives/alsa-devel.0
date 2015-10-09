From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: power down all link in
	suspend" to the asoc tree
Date: Fri, 09 Oct 2015 12:21:26 +0100
Message-ID: <E1ZkVjq-0006Zq-0x@finisterre>
References: <1444377711-9720-5-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 33F0C265011
 for <alsa-devel@alsa-project.org>; Fri,  9 Oct 2015 13:21:45 +0200 (CEST)
In-Reply-To: <1444377711-9720-5-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: power down all link in suspend

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

>From 01bb84b5001e4a6221582b163b34e90b3095f451 Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Fri, 9 Oct 2015 09:01:51 +0100
Subject: [PATCH] ASoC: Intel: Skylake: power down all link in suspend

This ensures that the link is not requesting any clock and the
PLL can turn off. The link is powered when controller is brought
out of reset.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index ca135b8..5319529 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -173,6 +173,9 @@ static int skl_runtime_suspend(struct device *dev)
 
 	/* enable controller wake up event */
 	snd_hdac_chip_updatew(bus, WAKEEN, 0, STATESTS_INT_MASK);
+
+	snd_hdac_ext_bus_link_power_down_all(ebus);
+
 	ret = skl_suspend_dsp(skl);
 	if (ret < 0)
 		return ret;
-- 
2.5.0
