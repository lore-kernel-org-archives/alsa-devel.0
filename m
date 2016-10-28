From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH] ASoC: Intel: Skylake: Fix to turn off hdmi
	power on probe failure
Date: Fri, 28 Oct 2016 16:59:41 +0530
Message-ID: <1477654181-10035-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 37640266B2C
 for <alsa-devel@alsa-project.org>; Fri, 28 Oct 2016 13:37:09 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, lgirdwood@gmail.com, patches.audio@intel.com, broonie@kernel.org, "Sodhi, VunnyX" <vunnyx.sodhi@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Sodhi, VunnyX" <vunnyx.sodhi@intel.com>

HDMI codec is required to be powered up before controller initialization
for successful enumeration of codec. If the probe fails it needs to be
powered off to balance the power state of HDMI codec.

This fix balances the reference count in the error path before turning
off the codec.

Reported-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Signed-off-by: Sodhi, VunnyX <vunnyx.sodhi@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
---
 sound/soc/intel/skylake/skl.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 61a4848..1c47f4d 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -729,7 +729,7 @@ static int skl_probe(struct pci_dev *pci,
 
 	if (skl->nhlt == NULL) {
 		err = -ENODEV;
-		goto out_free;
+		goto out_display_power_off;
 	}
 
 	skl_nhlt_update_topology_bin(skl);
@@ -801,6 +801,9 @@ out_mach_free:
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
1.9.1
