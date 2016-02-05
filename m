From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 6/7] ASoC: Intel: Skylake: Add shutdown callback
Date: Fri,  5 Feb 2016 12:19:09 +0530
Message-ID: <1454654950-23091-7-git-send-email-vinod.koul@intel.com>
References: <1454654950-23091-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id C3281266618
 for <alsa-devel@alsa-project.org>; Fri,  5 Feb 2016 07:46:19 +0100 (CET)
In-Reply-To: <1454654950-23091-1-git-send-email-vinod.koul@intel.com>
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

From: Jeeja KP <jeeja.kp@intel.com>

While going to shutdown, we need to bring HW to clean state. This
is done by cleaning up stream descriptor registers. This cleanup
is already done by decoupling of stream and stopping the chip, so
invoke these from shutdown handler.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 092705e73db4..06f4b2c13423 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -634,6 +634,31 @@ out_free:
 	return err;
 }
 
+static void skl_shutdown(struct pci_dev *pci)
+{
+	struct hdac_ext_bus *ebus = pci_get_drvdata(pci);
+	struct hdac_bus *bus = ebus_to_hbus(ebus);
+	struct hdac_stream *s;
+	struct hdac_ext_stream *stream;
+	struct skl *skl;
+
+	if (ebus == NULL)
+		return;
+
+	skl = ebus_to_skl(ebus);
+
+	if (skl->init_failed)
+		return;
+
+	snd_hdac_ext_stop_streams(ebus);
+	list_for_each_entry(s, &bus->stream_list, list) {
+		stream = stream_to_hdac_ext_stream(s);
+		snd_hdac_ext_stream_decouple(ebus, stream, false);
+	}
+
+	snd_hdac_bus_stop_chip(bus);
+}
+
 static void skl_remove(struct pci_dev *pci)
 {
 	struct hdac_ext_bus *ebus = pci_get_drvdata(pci);
@@ -677,6 +702,7 @@ static struct pci_driver skl_driver = {
 	.id_table = skl_ids,
 	.probe = skl_probe,
 	.remove = skl_remove,
+	.shutdown = skl_shutdown,
 	.driver = {
 		.pm = &skl_pm,
 	},
-- 
1.9.1
