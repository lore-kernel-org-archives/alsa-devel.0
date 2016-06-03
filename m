From: jeeja.kp@intel.com
Subject: [PATCH 08/10] ASoC: Intel: Skylake: Set the DSP pipe
	type
Date: Fri,  3 Jun 2016 18:29:41 +0530
Message-ID: <1464958783-19344-9-git-send-email-jeeja.kp@intel.com>
References: <1464958783-19344-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 2B5E526655A
 for <alsa-devel@alsa-project.org>; Fri,  3 Jun 2016 14:56:35 +0200 (CEST)
In-Reply-To: <1464958783-19344-1-git-send-email-jeeja.kp@intel.com>
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
Cc: patches.audio@intel.com, Jeeja KP <jeeja.kp@intel.com>, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

DSP pipe type can be a pass through or it can be processing pipe.
In case of pass through pipe, it is a single pipeline with both
host and link copier in the same pipeline.

Identify the DSP pipe type if it pass through or not. Pass through
pipe is identified by checking if it has both host and link copier
in the same pipeline.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-topology.c | 27 +++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl-topology.h |  1 +
 2 files changed, 28 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 761dfc4..2f1991d 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -1769,6 +1769,29 @@ static int skl_tplg_create_pipe_widget_list(struct snd_soc_platform *platform)
 	return 0;
 }
 
+static void skl_tplg_set_pipe_type(struct skl *skl, struct skl_pipe *pipe)
+{
+	struct skl_pipe_module *w_module;
+	struct snd_soc_dapm_widget *w;
+	struct skl_module_cfg *mconfig;
+	bool host_found = false, link_found = false;
+
+	list_for_each_entry(w_module, &pipe->w_list, node) {
+		w = w_module->w;
+		mconfig = w->priv;
+
+		if (mconfig->dev_type == SKL_DEVICE_HDAHOST)
+			host_found = true;
+		else if (mconfig->dev_type != SKL_DEVICE_NONE)
+			link_found = true;
+	}
+
+	if (host_found && link_found)
+		pipe->passthru = true;
+	else
+		pipe->passthru = false;
+}
+
 /* This will be read from topology manifest, currently defined here */
 #define SKL_MAX_MCPS 30000000
 #define SKL_FW_MAX_MEM 1000000
@@ -1782,6 +1805,7 @@ int skl_tplg_init(struct snd_soc_platform *platform, struct hdac_ext_bus *ebus)
 	const struct firmware *fw;
 	struct hdac_bus *bus = ebus_to_hbus(ebus);
 	struct skl *skl = ebus_to_skl(ebus);
+	struct skl_pipeline *ppl;
 
 	ret = request_firmware(&fw, skl->tplg_name, bus->dev);
 	if (ret < 0) {
@@ -1815,5 +1839,8 @@ int skl_tplg_init(struct snd_soc_platform *platform, struct hdac_ext_bus *ebus)
 	if (ret < 0)
 		return ret;
 
+	list_for_each_entry(ppl, &skl->ppl_list, node)
+		skl_tplg_set_pipe_type(skl, ppl->pipe);
+
 	return 0;
 }
diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
index d4a58bc..170d68b 100644
--- a/sound/soc/intel/skylake/skl-topology.h
+++ b/sound/soc/intel/skylake/skl-topology.h
@@ -271,6 +271,7 @@ struct skl_pipe {
 	struct skl_pipe_params *p_params;
 	enum skl_pipe_state state;
 	struct list_head w_list;
+	bool passthru;
 };
 
 enum skl_module_state {
-- 
2.5.0
