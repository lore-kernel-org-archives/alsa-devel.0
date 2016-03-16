From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Call i915 exit last" to
	the asoc tree
Date: Wed, 16 Mar 2016 10:09:17 +0000
Message-ID: <E1ag8OD-00061K-Ge@debutante>
References: <1458035836-1843-6-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 72934265DEA
 for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2016 11:09:26 +0100 (CET)
In-Reply-To: <1458035836-1843-6-git-send-email-vinod.koul@intel.com>
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

   ASoC: Intel: Skylake: Call i915 exit last

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

>From 5b2fe89856b2d0faaaea9e4b4b2c4920de7a600c Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Tue, 15 Mar 2016 16:39:27 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Call i915 exit last

The Skylake driver uses i915 component APIs to talk to display.
On remove we should free up by invoking snd_hdac_i915_exit() but
that should be last thing in remove routine, so move it to last
in skl_free()

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 6e916c3c3a4b..72971dc55c52 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -328,6 +328,8 @@ static int skl_free(struct hdac_ext_bus *ebus)
 
 	snd_hdac_ext_bus_exit(ebus);
 
+	if (IS_ENABLED(CONFIG_SND_SOC_HDAC_HDMI))
+		snd_hdac_i915_exit(&ebus->bus);
 	return 0;
 }
 
@@ -720,9 +722,6 @@ static void skl_remove(struct pci_dev *pci)
 	if (skl->tplg)
 		release_firmware(skl->tplg);
 
-	if (IS_ENABLED(CONFIG_SND_SOC_HDAC_HDMI))
-		snd_hdac_i915_exit(&ebus->bus);
-
 	if (pci_dev_run_wake(pci))
 		pm_runtime_get_noresume(&pci->dev);
 	pci_dev_put(pci);
-- 
2.7.0
