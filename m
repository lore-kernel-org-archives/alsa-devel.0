From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Reset stream to link
	mapping" to the asoc tree
Date: Tue, 17 Apr 2018 12:28:40 +0100
Message-ID: <E1f8Omu-0000J9-8d@debutante>
References: <20180401094323.20864-1-sanyog.r.kale@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 4AB9B267600
 for <alsa-devel@alsa-project.org>; Tue, 17 Apr 2018 13:28:47 +0200 (CEST)
In-Reply-To: <20180401094323.20864-1-sanyog.r.kale@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
Cc: alsa-devel@alsa-project.org, abhijeet.kumar@intel.com, tiwai@suse.de, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Sanyog Kale <sanyog.r.kale@intel.com>, vinod.koul@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Reset stream to link mapping

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 112c60b333ec9ddc7e940116f5e9fdc0d1a9706a Mon Sep 17 00:00:00 2001
From: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
Date: Sun, 1 Apr 2018 15:13:23 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Reset stream to link mapping

By default all the streams are mapped to all links after controller is
reset which causes stream to be broadcast on all the links.

This patch resets the stream-link mapping after controller reset. The
stream is mapped later to the appropriate link as part of stream setup.

Tested-by: Abhijeet Kumar <abhijeet.kumar@intel.com>
Signed-off-by: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index abf324747b29..f0d9793f872a 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -127,10 +127,17 @@ static void skl_clock_power_gating(struct device *dev, bool enable)
  */
 static int skl_init_chip(struct hdac_bus *bus, bool full_reset)
 {
+	struct hdac_ext_bus *ebus = hbus_to_ebus(bus);
+	struct hdac_ext_link *hlink;
 	int ret;
 
 	skl_enable_miscbdcge(bus->dev, false);
 	ret = snd_hdac_bus_init_chip(bus, full_reset);
+
+	/* Reset stream-to-link mapping */
+	list_for_each_entry(hlink, &ebus->hlink_list, list)
+		bus->io_ops->reg_writel(0, hlink->ml_addr + AZX_REG_ML_LOSIDV);
+
 	skl_enable_miscbdcge(bus->dev, true);
 
 	return ret;
-- 
2.17.0
