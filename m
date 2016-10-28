From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Fix to turn off hdmi
	power on probe failure" to the asoc tree
Date: Fri, 28 Oct 2016 18:03:21 +0100
Message-ID: <E1c0AYr-0003Yl-1P@finisterre>
References: <1477654181-10035-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EA655266703
 for <alsa-devel@alsa-project.org>; Fri, 28 Oct 2016 19:03:45 +0200 (CEST)
In-Reply-To: <1477654181-10035-1-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sodhi@sirena.org.uk
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, lgirdwood@gmail.com, Takashi Sakamoto <o-takashi@sakamocchi.jp>, patches.audio@intel.com, broonie@kernel.org, "Sodhi, VunnyX" <vunnyx.sodhi@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Fix to turn off hdmi power on probe failure

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

>From 7a5857c3c282c12a8bd0cfd2dd4a17a9252c2b4d Mon Sep 17 00:00:00 2001
From: "Sodhi, VunnyX" <vunnyx.sodhi@intel.com>
Date: Fri, 28 Oct 2016 16:59:41 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Fix to turn off hdmi power on probe
 failure

HDMI codec is required to be powered up before controller initialization
for successful enumeration of codec. If the probe fails it needs to be
powered off to balance the power state of HDMI codec.

This fix balances the reference count in the error path before turning
off the codec.

Reported-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Signed-off-by: Sodhi, VunnyX <vunnyx.sodhi@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 7b7a380b1245..3fc30cbe83c1 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -674,7 +674,7 @@ static int skl_probe(struct pci_dev *pci,
 
 	if (skl->nhlt == NULL) {
 		err = -ENODEV;
-		goto out_free;
+		goto out_display_power_off;
 	}
 
 	skl_nhlt_update_topology_bin(skl);
@@ -746,6 +746,9 @@ out_mach_free:
 	skl_machine_device_unregister(skl);
 out_nhlt_free:
 	skl_nhlt_free(skl->nhlt);
+out_display_power_off:
+	if (IS_ENABLED(CONFIG_SND_SOC_HDAC_HDMI))
+		snd_hdac_display_power(bus, false);
 out_free:
 	skl->init_failed = 1;
 	skl_free(ebus);
-- 
2.10.1
