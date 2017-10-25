From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Decrease loglevel for
	topology loading" to the asoc tree
Date: Wed, 25 Oct 2017 13:03:15 +0100 (BST)
Message-ID: <20171025120315.1D4FD44005B@finisterre.ee.mobilebroadband>
References: <1505253585-13487-1-git-send-email-chintan.m.patel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C7F3B267092
 for <alsa-devel@alsa-project.org>; Wed, 25 Oct 2017 14:03:21 +0200 (CEST)
In-Reply-To: <1505253585-13487-1-git-send-email-chintan.m.patel@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Chintan Patel <chintan.m.patel@intel.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Decrease loglevel for topology loading

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

>From 19de7179974ff6cf43e8a893028d3aef06cdb0bf Mon Sep 17 00:00:00 2001
From: Chintan Patel <chintan.m.patel@intel.com>
Date: Thu, 12 Oct 2017 09:44:37 -0700
Subject: [PATCH] ASoC: Intel: Skylake: Decrease loglevel for topology loading

In case of failure in loading customize topology firmware, dfw_sst.bin
gets loaded. However, current log provides this message as error even
after successfully falling back to default topology "dfw_sst.bin".

Hence to convey proper message, changing log level and message.

Signed-off-by: Chintan Patel <chintan.m.patel@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index ff4f53cdc0a1..1200b7c6af56 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -3405,7 +3405,7 @@ int skl_tplg_init(struct snd_soc_platform *platform, struct hdac_ext_bus *ebus)
 
 	ret = request_firmware(&fw, skl->tplg_name, bus->dev);
 	if (ret < 0) {
-		dev_err(bus->dev, "tplg fw %s load failed with %d\n",
+		dev_info(bus->dev, "tplg fw %s load failed with %d, falling back to dfw_sst.bin",
 				skl->tplg_name, ret);
 		ret = request_firmware(&fw, "dfw_sst.bin", bus->dev);
 		if (ret < 0) {
-- 
2.14.1
