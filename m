From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 5/6] ASoC: Intel: Skylake: Call i915 exit last
Date: Tue, 15 Mar 2016 15:27:15 +0530
Message-ID: <1458035836-1843-6-git-send-email-vinod.koul@intel.com>
References: <1458035836-1843-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id AC8AD261298
 for <alsa-devel@alsa-project.org>; Tue, 15 Mar 2016 10:53:17 +0100 (CET)
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

The Skylake driver uses i915 component APIs to talk to display.
On remove we should free up by invoking snd_hdac_i915_exit() but
that should be last thing in remove routine, so move it to last
in skl_free()

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 06887eacffa7..fdf345b1ace5 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -328,6 +328,8 @@ static int skl_free(struct hdac_ext_bus *ebus)
 
 	snd_hdac_ext_bus_exit(ebus);
 
+	if (IS_ENABLED(CONFIG_SND_SOC_HDAC_HDMI))
+		snd_hdac_i915_exit(&ebus->bus);
 	return 0;
 }
 
@@ -728,9 +730,6 @@ static void skl_remove(struct pci_dev *pci)
 	if (skl->tplg)
 		release_firmware(skl->tplg);
 
-	if (IS_ENABLED(CONFIG_SND_SOC_HDAC_HDMI))
-		snd_hdac_i915_exit(&ebus->bus);
-
 	if (pci_dev_run_wake(pci))
 		pm_runtime_get_noresume(&pci->dev);
 	pci_dev_put(pci);
-- 
1.9.1
