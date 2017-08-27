From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Add driver structures
	to be filled from topology manifest" to the asoc tree
Date: Sun, 27 Aug 2017 14:38:51 +0100 (BST)
Message-ID: <20170827133851.669E64400E7@finisterre.ee.mobilebroadband>
References: <20170823140354.792-5-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8B331267478
 for <alsa-devel@alsa-project.org>; Sun, 27 Aug 2017 15:38:53 +0200 (CEST)
In-Reply-To: <20170823140354.792-5-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shreyas NC <shreyas.nc@intel.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Patches Audio <patches.audio@intel.com>, Mark Brown <broonie@kernel.org>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Add driver structures to be filled from topology manifest

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

>From 822c3b044f7fbecc9894fcd3d19fc2ad51232fdb Mon Sep 17 00:00:00 2001
From: Shreyas NC <shreyas.nc@intel.com>
Date: Wed, 23 Aug 2017 19:33:51 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Add driver structures to be filled from
 topology manifest

The topology manifest would include module common data including resource
and interface table. The resource table consists of resources required by
the dsp module such as buffer size, cycles per second, number of
input/output pins. And, the interface table consists of pcm parameters per
module which can be referenced later.

So define the structures accordingly to represent topology manifest data in
the driver.

Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-topology.h | 52 ++++++++++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl.h          |  2 ++
 2 files changed, 54 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
index c25e8868b84e..93b2ba8c40f7 100644
--- a/sound/soc/intel/skylake/skl-topology.h
+++ b/sound/soc/intel/skylake/skl-topology.h
@@ -44,6 +44,13 @@
 #define SKL_DEFAULT_MIC_SEL_GAIN	0x3FF
 #define SKL_MIC_SEL_SWITCH	0x3
 
+#define SKL_OUTPUT_PIN		0
+#define SKL_INPUT_PIN		1
+#define SKL_MAX_PATH_CONFIGS	8
+#define SKL_MAX_MODULES_IN_PIPE	8
+#define SKL_MAX_MODULE_FORMATS		32
+#define SKL_MAX_MODULE_RESOURCES	32
+
 enum skl_channel_index {
 	SKL_CHANNEL_LEFT = 0,
 	SKL_CHANNEL_RIGHT = 1,
@@ -292,6 +299,51 @@ enum d0i3_capability {
 	SKL_D0I3_NON_STREAMING = 2,
 };
 
+struct skl_module_pin_fmt {
+	u8 id;
+	struct skl_module_fmt fmt;
+};
+
+struct skl_module_iface {
+	u8 fmt_idx;
+	u8 nr_in_fmt;
+	u8 nr_out_fmt;
+	struct skl_module_pin_fmt inputs[MAX_IN_QUEUE];
+	struct skl_module_pin_fmt outputs[MAX_OUT_QUEUE];
+};
+
+struct skl_module_pin_resources {
+	u8 pin_index;
+	u32 buf_size;
+};
+
+struct skl_module_res {
+	u8 id;
+	u32 is_pages;
+	u32 cps;
+	u32 ibs;
+	u32 obs;
+	u32 dma_buffer_size;
+	u32 cpc;
+	u8 nr_input_pins;
+	u8 nr_output_pins;
+	struct skl_module_pin_resources input[MAX_IN_QUEUE];
+	struct skl_module_pin_resources output[MAX_OUT_QUEUE];
+};
+
+struct skl_module {
+	uuid_le uuid;
+	u8 loadable;
+	u8 input_pin_type;
+	u8 output_pin_type;
+	u8 max_input_pins;
+	u8 max_output_pins;
+	u8 nr_resources;
+	u8 nr_interfaces;
+	struct skl_module_res resources[SKL_MAX_MODULE_RESOURCES];
+	struct skl_module_iface formats[SKL_MAX_MODULE_FORMATS];
+};
+
 struct skl_module_cfg {
 	u8 guid[16];
 	struct skl_module_inst_id id;
diff --git a/sound/soc/intel/skylake/skl.h b/sound/soc/intel/skylake/skl.h
index 20017ee4685c..8d9d6899f761 100644
--- a/sound/soc/intel/skylake/skl.h
+++ b/sound/soc/intel/skylake/skl.h
@@ -71,6 +71,8 @@ struct skl {
 	struct work_struct probe_work;
 
 	struct skl_debug *debugfs;
+	u8 nr_modules;
+	struct skl_module **modules;
 };
 
 #define skl_to_ebus(s)	(&(s)->ebus)
-- 
2.13.2
