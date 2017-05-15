From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: intel: atom: localize variable without
	external linkage" to the asoc tree
Date: Mon, 15 May 2017 17:02:27 +0900
Message-ID: <E1dAAxY-0002P1-09@finisterre>
References: <20170502133303.19622-5-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9062C2672B1
 for <alsa-devel@alsa-project.org>; Mon, 15 May 2017 10:02:38 +0200 (CEST)
In-Reply-To: <20170502133303.19622-5-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: Vinod Koul <vinod.koul@intel.com>, tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org, Sebastien Guiriec <sebastien.guiriec@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: intel: atom: localize variable without external linkage

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

>From 65db85fba1df213ff80d6f3cbafee244c58f6ec3 Mon Sep 17 00:00:00 2001
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Date: Tue, 2 May 2017 22:33:03 +0900
Subject: [PATCH] ASoC: intel: atom: localize variable without external linkage

A driver for Intel SST driver for old atom platform includes a variable
which has no external linkage. These functions should have static
qualifier.

This commit adds the qualifier to localize the variable. This issue is
detected by sparse:

sst.c:261:1: warning: symbol 'dev_attr_firmware_version' was not declared. Should it be static?

Cc: Sebastien Guiriec <sebastien.guiriec@intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/atom/sst/sst.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/atom/sst/sst.c b/sound/soc/intel/atom/sst/sst.c
index f9ba71315e33..d97556a3772c 100644
--- a/sound/soc/intel/atom/sst/sst.c
+++ b/sound/soc/intel/atom/sst/sst.c
@@ -258,7 +258,7 @@ static ssize_t firmware_version_show(struct device *dev,
 
 }
 
-DEVICE_ATTR_RO(firmware_version);
+static DEVICE_ATTR_RO(firmware_version);
 
 static const struct attribute *sst_fw_version_attrs[] = {
 	&dev_attr_firmware_version.attr,
-- 
2.11.0
