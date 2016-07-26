From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 05/12] ASoC: Intel: Skylake: add support for
	tplg manifest load
Date: Tue, 26 Jul 2016 18:06:43 +0530
Message-ID: <1469536610-27606-6-git-send-email-vinod.koul@intel.com>
References: <1469536610-27606-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 3BDF926699C
 for <alsa-devel@alsa-project.org>; Tue, 26 Jul 2016 14:29:49 +0200 (CEST)
In-Reply-To: <1469536610-27606-1-git-send-email-vinod.koul@intel.com>
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
Cc: Kranthi G <gudishax.kranthikumar@intel.com>, patches.audio@intel.com, Ramesh Babu <ramesh.babu@intel.com>, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Kranthi G <gudishax.kranthikumar@intel.com>

Topology manifest gives information about the libraries to be
loaded. Implement the topology manifest load callback to get
this.

Signed-off-by: Kranthi G <gudishax.kranthikumar@intel.com>
Signed-off-by: Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
Signed-off-by: Ramesh Babu <ramesh.babu@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-sst-ipc.h        |  3 +++
 sound/soc/intel/skylake/skl-topology.c       | 22 ++++++++++++++++++++++
 sound/soc/intel/skylake/skl-tplg-interface.h | 12 ++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-sst-ipc.h b/sound/soc/intel/skylake/skl-sst-ipc.h
index 0a0d09cde99d..31e5bc356aa2 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.h
+++ b/sound/soc/intel/skylake/skl-sst-ipc.h
@@ -80,6 +80,9 @@ struct skl_sst {
 
 	/* multi-core */
 	struct skl_dsp_cores cores;
+
+	/* tplg manifest */
+	struct skl_dfw_manifest manifest;
 };
 
 struct skl_ipc_init_instance_msg {
diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 904103056d62..a1d9f84d9674 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -1789,11 +1789,33 @@ static int skl_tplg_control_load(struct snd_soc_component *cmpnt,
 	return 0;
 }
 
+static int skl_manifest_load(struct snd_soc_component *cmpnt,
+				struct snd_soc_tplg_manifest *manifest)
+{
+	struct skl_dfw_manifest *minfo;
+	struct hdac_ext_bus *ebus = snd_soc_component_get_drvdata(cmpnt);
+	struct hdac_bus *bus = ebus_to_hbus(ebus);
+	struct skl *skl = ebus_to_skl(ebus);
+	int ret = 0;
+
+	minfo = &skl->skl_sst->manifest;
+	memcpy(minfo, manifest->priv.data, sizeof(struct skl_dfw_manifest));
+
+	if (minfo->lib_count > HDA_MAX_LIB) {
+		dev_err(bus->dev, "Exceeding max Library count. Got:%d\n",
+					minfo->lib_count);
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
 static struct snd_soc_tplg_ops skl_tplg_ops  = {
 	.widget_load = skl_tplg_widget_load,
 	.control_load = skl_tplg_control_load,
 	.bytes_ext_ops = skl_tlv_ops,
 	.bytes_ext_ops_count = ARRAY_SIZE(skl_tlv_ops),
+	.manifest = skl_manifest_load,
 };
 
 /*
diff --git a/sound/soc/intel/skylake/skl-tplg-interface.h b/sound/soc/intel/skylake/skl-tplg-interface.h
index a32e5e9cc530..1b531c165a91 100644
--- a/sound/soc/intel/skylake/skl-tplg-interface.h
+++ b/sound/soc/intel/skylake/skl-tplg-interface.h
@@ -228,4 +228,16 @@ struct skl_dfw_algo_data {
 	char params[0];
 } __packed;
 
+#define LIB_NAME_LENGTH	128
+#define HDA_MAX_LIB	16
+
+struct lib_info {
+	char name[LIB_NAME_LENGTH];
+} __packed;
+
+struct skl_dfw_manifest {
+	u32 lib_count;
+	struct lib_info lib[HDA_MAX_LIB];
+} __packed;
+
 #endif
-- 
1.9.1
