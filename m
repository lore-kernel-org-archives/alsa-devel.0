From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: add support for tplg
	manifest load" to the asoc tree
Date: Mon, 01 Aug 2016 18:07:19 +0100
Message-ID: <E1bUGgR-0006PA-AE@debutante>
References: <1469536610-27606-6-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EEE6F2660BD
 for <alsa-devel@alsa-project.org>; Mon,  1 Aug 2016 19:07:25 +0200 (CEST)
In-Reply-To: <1469536610-27606-6-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kranthi G <gudishax.kranthikumar@intel.com>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, Ramesh Babu <ramesh.babu@intel.com>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: add support for tplg manifest load

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

>From 05b39fd4eca326aa67a636b4eec63dd4677c19d4 Mon Sep 17 00:00:00 2001
From: Kranthi G <gudishax.kranthikumar@intel.com>
Date: Tue, 26 Jul 2016 18:06:43 +0530
Subject: [PATCH] ASoC: Intel: Skylake: add support for tplg manifest load

Topology manifest gives information about the libraries to be
loaded. Implement the topology manifest load callback to get
this.

Signed-off-by: Kranthi G <gudishax.kranthikumar@intel.com>
Signed-off-by: Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
Signed-off-by: Ramesh Babu <ramesh.babu@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.8.1
