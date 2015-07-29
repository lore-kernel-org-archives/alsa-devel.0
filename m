From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: haswell: fix initialize 'NULL
	device *' issue" to the asoc tree
Date: Wed, 29 Jul 2015 15:13:14 +0100
Message-ID: <E1ZKS6c-0004b0-GW@finisterre>
References: <1438070466-30008-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7632B265150
 for <alsa-devel@alsa-project.org>; Wed, 29 Jul 2015 16:13:27 +0200 (CEST)
In-Reply-To: <1438070466-30008-1-git-send-email-yang.jie@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jie Yang <yang.jie@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: haswell: fix initialize 'NULL device *' issue

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

>From 4b563ea317c2262987f0675abf15066614f536a1 Mon Sep 17 00:00:00 2001
From: Jie Yang <yang.jie@intel.com>
Date: Tue, 28 Jul 2015 16:01:05 +0800
Subject: [PATCH] ASoC: Intel: haswell: fix initialize 'NULL device *' issue

Add initialization for sst_hsw.dev at init stage, which fix the
'NULL device *' warning issues.

Signed-off-by: Jie Yang <yang.jie@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/haswell/sst-haswell-ipc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/intel/haswell/sst-haswell-ipc.c b/sound/soc/intel/haswell/sst-haswell-ipc.c
index f95f271..f6efa9d 100644
--- a/sound/soc/intel/haswell/sst-haswell-ipc.c
+++ b/sound/soc/intel/haswell/sst-haswell-ipc.c
@@ -2119,6 +2119,8 @@ int sst_hsw_dsp_init(struct device *dev, struct sst_pdata *pdata)
 	if (hsw == NULL)
 		return -ENOMEM;
 
+	hsw->dev = dev;
+
 	ipc = &hsw->ipc;
 	ipc->dev = dev;
 	ipc->ops.tx_msg = hsw_tx_msg;
-- 
2.1.4
