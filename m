From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Fix bit depth when
	querying the NHLT blob" to the asoc tree
Date: Tue, 27 Oct 2015 13:49:22 +0900
Message-ID: <E1ZqwCI-0004v6-4G@finisterre>
References: <1445905380-18167-8-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 52750265838
 for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2015 05:49:32 +0100 (CET)
In-Reply-To: <1445905380-18167-8-git-send-email-vinod.koul@intel.com>
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

   ASoC: Intel: Skylake: Fix bit depth when querying the NHLT blob

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

>From 4dfdd449760654cdedda2f40c23d7f3cb864b02a Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Tue, 27 Oct 2015 09:22:50 +0900
Subject: [PATCH] ASoC: Intel: Skylake: Fix bit depth when querying the NHLT
 blob

Bps calculation is not correct as this needs to be based on valid
bit depth.  16 bit fmt bit depth is 16 bit and for 24 and 32 bit
as it is container size This patch fixes the bps.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-nhlt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-nhlt.c b/sound/soc/intel/skylake/skl-nhlt.c
index b0c7bd1..3ff22eb 100644
--- a/sound/soc/intel/skylake/skl-nhlt.c
+++ b/sound/soc/intel/skylake/skl-nhlt.c
@@ -115,7 +115,7 @@ struct nhlt_specific_cfg
 	struct device *dev = bus->dev;
 	struct nhlt_specific_cfg *sp_config;
 	struct nhlt_acpi_table *nhlt = (struct nhlt_acpi_table *)skl->nhlt;
-	u16 bps = num_ch * s_fmt;
+	u16 bps = (s_fmt == 16) ? 16 : 32;
 	u8 j;
 
 	dump_config(dev, instance, link_type, s_fmt, num_ch, s_rate, dirn, bps);
-- 
2.6.1
