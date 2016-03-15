From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 2/6] ASoC: Intel: Skylake: free codec objects
	on removal
Date: Tue, 15 Mar 2016 15:27:12 +0530
Message-ID: <1458035836-1843-3-git-send-email-vinod.koul@intel.com>
References: <1458035836-1843-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 0312B265474
 for <alsa-devel@alsa-project.org>; Tue, 15 Mar 2016 10:53:09 +0100 (CET)
In-Reply-To: <1458035836-1843-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

On driver removal we should ask the core to remove the device
objects as well, so invoke snd_hdac_ext_bus_device_remove() in
remove.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index ab5e25aaeee3..371df495dd14 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -454,6 +454,14 @@ static int skl_codec_create(struct hdac_ext_bus *ebus)
 	return 0;
 }
 
+/*
+ * codec destructor
+ */
+static void skl_codecs_remove(struct hdac_ext_bus *ebus)
+{
+	snd_hdac_ext_bus_device_remove(ebus);
+}
+
 static const struct hdac_bus_ops bus_core_ops = {
 	.command = snd_hdac_bus_send_cmd,
 	.get_response = snd_hdac_bus_get_response,
@@ -725,6 +733,7 @@ static void skl_remove(struct pci_dev *pci)
 	if (pci_dev_run_wake(pci))
 		pm_runtime_get_noresume(&pci->dev);
 	pci_dev_put(pci);
+	skl_codecs_remove(ebus);
 	skl_platform_unregister(&pci->dev);
 	skl_free_dsp(skl);
 	skl_machine_device_unregister(skl);
-- 
1.9.1
