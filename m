From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Reset the controller in
	probe" to the asoc tree
Date: Tue, 01 Aug 2017 15:16:45 +0100
Message-ID: <E1dcXyX-0008QO-Ax@debutante>
References: <20170728104216.26859-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9EC7926717C
 for <alsa-devel@alsa-project.org>; Tue,  1 Aug 2017 16:16:54 +0200 (CEST)
In-Reply-To: <20170728104216.26859-1-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Patches Audio <patches.audio@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Reset the controller in probe

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

>From 60767abcea3dd1d47a4bd38398e1e8c1864975eb Mon Sep 17 00:00:00 2001
From: "guneshwor.o.singh@intel.com" <guneshwor.o.singh@intel.com>
Date: Fri, 28 Jul 2017 16:12:13 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Reset the controller in probe

Controller can be in reset state by default. Capability structure
traversal requires the controller to be out of reset else it
results in broken capability parsing. Hence make sure that controller is
out of reset before parsing capabilities by doing a full reset.

Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 01a2dd6518a4..b9e1310673f0 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -702,6 +702,8 @@ static int skl_first_init(struct hdac_ext_bus *ebus)
 		return -ENXIO;
 	}
 
+	skl_init_chip(bus, true);
+
 	snd_hdac_bus_parse_capabilities(bus);
 
 	if (skl_acquire_irq(ebus, 0) < 0)
-- 
2.13.2
