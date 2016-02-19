From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 3/3] ASoC: Intel: Skylake: Generate topology
	name for NHLT table header
Date: Fri, 19 Feb 2016 11:42:34 +0530
Message-ID: <1455862354-6455-3-git-send-email-vinod.koul@intel.com>
References: <1455862354-6455-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 069FB2665F6
 for <alsa-devel@alsa-project.org>; Fri, 19 Feb 2016 07:08:56 +0100 (CET)
In-Reply-To: <1455862354-6455-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Yang A Fang <yang.a.fang@intel.com>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

NHLT table [1] header has fields like oem_id, oem_table_id and
oem_revision. Use that to load a unique topology binary specific
to that platform

NHLT Table is documented at:
[1]: https://01.org/blogs/2016/intel-smart-sound-technology-audio-dsp

Signed-off-by: Yang A Fang <yang.a.fang@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-nhlt.c     | 34 ++++++++++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl-topology.c | 11 ++++++++---
 sound/soc/intel/skylake/skl.c          |  4 ++++
 sound/soc/intel/skylake/skl.h          |  3 +++
 4 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-nhlt.c b/sound/soc/intel/skylake/skl-nhlt.c
index 6e4b21cdb1bd..14d1916ea9f8 100644
--- a/sound/soc/intel/skylake/skl-nhlt.c
+++ b/sound/soc/intel/skylake/skl-nhlt.c
@@ -145,3 +145,37 @@ struct nhlt_specific_cfg
 
 	return NULL;
 }
+
+static void skl_nhlt_trim_space(struct skl *skl)
+{
+	char *s = skl->tplg_name;
+	int cnt;
+	int i;
+
+	cnt = 0;
+	for (i = 0; s[i]; i++) {
+		if (!isspace(s[i]))
+			s[cnt++] = s[i];
+	}
+
+	s[cnt] = '\0';
+}
+
+int skl_nhlt_update_topology_bin(struct skl *skl)
+{
+	struct nhlt_acpi_table *nhlt = (struct nhlt_acpi_table *)skl->nhlt;
+	struct hdac_bus *bus = ebus_to_hbus(&skl->ebus);
+	struct device *dev = bus->dev;
+
+	dev_dbg(dev, "oem_id %.6s, oem_table_id %8s oem_revision %d\n",
+		nhlt->header.oem_id, nhlt->header.oem_table_id,
+		nhlt->header.oem_revision);
+
+	snprintf(skl->tplg_name, sizeof(skl->tplg_name), "%x-%.6s-%.8s-%d%s",
+		skl->pci_id, nhlt->header.oem_id, nhlt->header.oem_table_id,
+		nhlt->header.oem_revision, "-tplg.bin");
+
+	skl_nhlt_trim_space(skl);
+
+	return 0;
+}
diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 216d7a8e5680..ba0d02d1613e 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -1716,11 +1716,16 @@ int skl_tplg_init(struct snd_soc_platform *platform, struct hdac_ext_bus *ebus)
 	struct hdac_bus *bus = ebus_to_hbus(ebus);
 	struct skl *skl = ebus_to_skl(ebus);
 
-	ret = request_firmware(&fw, "dfw_sst.bin", bus->dev);
+	ret = request_firmware(&fw, skl->tplg_name, bus->dev);
 	if (ret < 0) {
 		dev_err(bus->dev, "tplg fw %s load failed with %d\n",
-				"dfw_sst.bin", ret);
-		return ret;
+				skl->tplg_name, ret);
+		ret = request_firmware(&fw, "dfw_sst.bin", bus->dev);
+		if (ret < 0) {
+			dev_err(bus->dev, "Fallback tplg fw %s load failed with %d\n",
+					"dfw_sst.bin", ret);
+			return ret;
+		}
 	}
 
 	/*
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 60dfe28ee1da..643c877d272c 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -624,11 +624,15 @@ static int skl_probe(struct pci_dev *pci,
 	if (err < 0)
 		goto out_free;
 
+	skl->pci_id = pci->device;
+
 	skl->nhlt = skl_nhlt_init(bus->dev);
 
 	if (skl->nhlt == NULL)
 		goto out_free;
 
+	skl_nhlt_update_topology_bin(skl);
+
 	pci_set_drvdata(skl->pci, ebus);
 
 	/* check if dsp is there */
diff --git a/sound/soc/intel/skylake/skl.h b/sound/soc/intel/skylake/skl.h
index 4d18293b5537..1ca1911f1587 100644
--- a/sound/soc/intel/skylake/skl.h
+++ b/sound/soc/intel/skylake/skl.h
@@ -73,6 +73,8 @@ struct skl {
 	struct list_head ppl_list;
 
 	const char *fw_name;
+	char tplg_name[64];
+	unsigned short pci_id;
 	const struct firmware *tplg;
 
 	int supend_active;
@@ -96,6 +98,7 @@ void skl_nhlt_free(void *addr);
 struct nhlt_specific_cfg *skl_get_ep_blob(struct skl *skl, u32 instance,
 			u8 link_type, u8 s_fmt, u8 no_ch, u32 s_rate, u8 dirn);
 
+int skl_nhlt_update_topology_bin(struct skl *skl);
 int skl_init_dsp(struct skl *skl);
 void skl_free_dsp(struct skl *skl);
 int skl_suspend_dsp(struct skl *skl);
-- 
1.9.1
