From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 08/14] ASoC: Intel: Skylake: fix reset
	controller sequencing
Date: Fri, 11 Dec 2015 12:14:21 +0530
Message-ID: <1449816267-11910-9-git-send-email-vinod.koul@intel.com>
References: <1449816267-11910-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id BF282265914
 for <alsa-devel@alsa-project.org>; Fri, 11 Dec 2015 07:41:47 +0100 (CET)
In-Reply-To: <1449816267-11910-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, Jayachandran B <jayachandran.b@intel.com>, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

From: Jayachandran B <jayachandran.b@intel.com>

HW recommends that we reset with CGCTL.MISCBDCGE disabled, so add
that while doing init chip and reset sequence.

Signed-off-by: Jayachandran B <jayachandran.b@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 2c16325d1ce1..4696254c6743 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -58,6 +58,22 @@ static void skl_init_pci(struct skl *skl)
 	skl_update_pci_byte(skl->pci, AZX_PCIREG_TCSEL, 0x07, 0);
 }
 
+/*
+ * While performing reset, controller may not come back properly causing
+ * issues, so recommendation is to set CGCTL.MISCBDCGE to 0 then do reset
+ * (init chip) and then again set CGCTL.MISCBDCGE to 1
+ */
+static int skl_init_chip(struct hdac_bus *bus, bool full_reset)
+{
+	int ret;
+
+	snd_hdac_ext_bus_enable_miscbdcge(bus->dev, false);
+	ret = snd_hdac_bus_init_chip(bus, full_reset);
+	snd_hdac_ext_bus_enable_miscbdcge(bus->dev, true);
+
+	return ret;
+}
+
 /* called from IRQ */
 static void skl_stream_update(struct hdac_bus *bus, struct hdac_stream *hstr)
 {
@@ -144,7 +160,9 @@ static int _skl_suspend(struct hdac_ext_bus *ebus)
 		return ret;
 
 	snd_hdac_bus_stop_chip(bus);
+	snd_hdac_ext_bus_enable_miscbdcge(bus->dev, false);
 	snd_hdac_bus_enter_link_reset(bus);
+	snd_hdac_ext_bus_enable_miscbdcge(bus->dev, true);
 
 	return 0;
 }
@@ -155,7 +173,7 @@ static int _skl_resume(struct hdac_ext_bus *ebus)
 	struct hdac_bus *bus = ebus_to_hbus(ebus);
 
 	skl_init_pci(skl);
-	snd_hdac_bus_init_chip(bus, true);
+	skl_init_chip(bus, true);
 
 	return skl_resume_dsp(skl);
 }
@@ -379,7 +397,7 @@ static int skl_codec_create(struct hdac_ext_bus *ebus)
 				 * back to the sanity state.
 				 */
 				snd_hdac_bus_stop_chip(bus);
-				snd_hdac_bus_init_chip(bus, true);
+				skl_init_chip(bus, true);
 			}
 		}
 	}
@@ -489,7 +507,7 @@ static int skl_first_init(struct hdac_ext_bus *ebus)
 	/* initialize chip */
 	skl_init_pci(skl);
 
-	snd_hdac_bus_init_chip(bus, true);
+	skl_init_chip(bus, true);
 
 	/* codec detection */
 	if (!bus->codec_mask) {
-- 
1.9.1
