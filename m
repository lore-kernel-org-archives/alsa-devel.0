From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 4/6] ASoC: Intel: Skylake: Unmap the address
	last
Date: Tue, 15 Mar 2016 15:27:14 +0530
Message-ID: <1458035836-1843-5-git-send-email-vinod.koul@intel.com>
References: <1458035836-1843-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 189932657B0
 for <alsa-devel@alsa-project.org>; Tue, 15 Mar 2016 10:53:14 +0100 (CET)
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

In Skylake destructor we unmap the hardware address and then free
links and streams. The stream free accesses hardware to write to
registers and predictably causes oops.

So change the order and unmap last in destructor.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 371df495dd14..06887eacffa7 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -316,12 +316,13 @@ static int skl_free(struct hdac_ext_bus *ebus)
 
 	if (bus->irq >= 0)
 		free_irq(bus->irq, (void *)bus);
-	if (bus->remap_addr)
-		iounmap(bus->remap_addr);
-
 	snd_hdac_bus_free_stream_pages(bus);
 	snd_hdac_stream_free_all(ebus);
 	snd_hdac_link_free_all(ebus);
+
+	if (bus->remap_addr)
+		iounmap(bus->remap_addr);
+
 	pci_release_regions(skl->pci);
 	pci_disable_device(skl->pci);
 
-- 
1.9.1
