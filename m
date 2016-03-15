From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 5/6] ASoC: Intel: Skylake: Call i915 exit
	last
Date: Tue, 15 Mar 2016 16:39:27 +0530
Message-ID: <1458040168-3769-6-git-send-email-vinod.koul@intel.com>
References: <1458040168-3769-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 92D3B2659EA
 for <alsa-devel@alsa-project.org>; Tue, 15 Mar 2016 12:05:55 +0100 (CET)
In-Reply-To: <1458040168-3769-1-git-send-email-vinod.koul@intel.com>
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
1.9.1
