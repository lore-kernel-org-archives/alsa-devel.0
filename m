From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: common: increase the loglevel of
	"FW Poll Status"." to the asoc tree
Date: Mon, 27 Jun 2016 17:40:24 +0100
Message-ID: <E1bHZaC-0005Da-BT@debutante>
References: <1460498902-30454-3-git-send-email-vedang.patel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C9E18266E79
 for <alsa-devel@alsa-project.org>; Mon, 27 Jun 2016 18:40:29 +0200 (CEST)
In-Reply-To: <1460498902-30454-3-git-send-email-vedang.patel@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vedang Patel <vedang.patel@intel.com>
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, marc.herbert@intel.com, Mark Brown <broonie@kernel.org>, liam.r.girdwood@intel.com, jeeja.kp@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: common: increase the loglevel of "FW Poll Status".

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

>From ef06b6f3912f4438f9275922dae17c11360ceefc Mon Sep 17 00:00:00 2001
From: Vedang Patel <vedang.patel@intel.com>
Date: Fri, 24 Jun 2016 17:37:10 -0700
Subject: [PATCH] ASoC: Intel: common: increase the loglevel of "FW Poll
 Status".

For consistency with other log statements, change dev_info to dev_dbg
for a kernel print which is frequently printed by the driver.

Signed-off-by: Vedang Patel <vedang.patel@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/common/sst-dsp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/common/sst-dsp.c b/sound/soc/intel/common/sst-dsp.c
index b5bbdf4fe93a..ff2196ef359f 100644
--- a/sound/soc/intel/common/sst-dsp.c
+++ b/sound/soc/intel/common/sst-dsp.c
@@ -285,7 +285,7 @@ int sst_dsp_register_poll(struct sst_dsp *ctx, u32 offset, u32 mask,
 	}
 
 	reg = sst_dsp_shim_read_unlocked(ctx, offset);
-	dev_info(ctx->dev, "FW Poll Status: reg=%#x %s %s\n", reg, operation,
+	dev_dbg(ctx->dev, "FW Poll Status: reg=%#x %s %s\n", reg, operation,
 			(time < timeout) ? "successful" : "timedout");
 	ret = time < timeout ? 0 : -ETIME;
 
-- 
2.8.1
