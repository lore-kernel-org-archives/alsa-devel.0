From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 14/17] ASoC: Intel: Skylake: Add support for
	module GUIDs
Date: Tue, 27 Oct 2015 09:22:57 +0900
Message-ID: <1445905380-18167-15-git-send-email-vinod.koul@intel.com>
References: <1445905380-18167-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 74E1F2651FE
 for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2015 01:24:01 +0100 (CET)
In-Reply-To: <1445905380-18167-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, Hardik T Shah <hardik.t.shah@intel.com>, Omair M Abdullah <omair.m.abdullah@intel.com>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Hardik T Shah <hardik.t.shah@intel.com>

The DSP FW specifies loadable modules using GUIDs so add support to
specify the GUIDs from topology

Signed-off-by: Hardik T Shah <hardik.t.shah@intel.com>
Signed-off-by: Omair M Abdullah <omair.m.abdullah@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-topology.c       | 4 ++++
 sound/soc/intel/skylake/skl-topology.h       | 1 +
 sound/soc/intel/skylake/skl-tplg-interface.h | 3 +++
 3 files changed, 8 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 37e5c4fc0f10..3c5f06235889 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -1164,6 +1164,10 @@ static int skl_tplg_widget_load(struct snd_soc_component *cmpnt,
 	mconfig->time_slot = dfw_config->time_slot;
 	mconfig->formats_config.caps_size = dfw_config->caps.caps_size;
 
+	if (dfw_config->is_loadable)
+		memcpy(mconfig->guid, dfw_config->uuid,
+					ARRAY_SIZE(dfw_config->uuid));
+
 	mconfig->m_in_pin = devm_kzalloc(bus->dev, (mconfig->max_in_queue) *
 						sizeof(*mconfig->m_in_pin),
 						GFP_KERNEL);
diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
index 4b0a59898676..57cb7b8dd269 100644
--- a/sound/soc/intel/skylake/skl-topology.h
+++ b/sound/soc/intel/skylake/skl-topology.h
@@ -246,6 +246,7 @@ enum skl_module_state {
 };
 
 struct skl_module_cfg {
+	char guid[SKL_UUID_STR_SZ];
 	struct skl_module_inst_id id;
 	u8 domain;
 	bool homogenous_inputs;
diff --git a/sound/soc/intel/skylake/skl-tplg-interface.h b/sound/soc/intel/skylake/skl-tplg-interface.h
index aeb8f251675a..20c068754d08 100644
--- a/sound/soc/intel/skylake/skl-tplg-interface.h
+++ b/sound/soc/intel/skylake/skl-tplg-interface.h
@@ -32,6 +32,7 @@
 #define MAX_IN_QUEUE 8
 #define MAX_OUT_QUEUE 8
 
+#define SKL_UUID_STR_SZ 40
 /* Event types goes here */
 /* Reserve event type 0 for no event handlers */
 enum skl_event_types {
@@ -174,6 +175,8 @@ struct skl_dfw_pipe {
 } __packed;
 
 struct skl_dfw_module {
+	char uuid[SKL_UUID_STR_SZ];
+
 	u16 module_id;
 	u16 instance_id;
 	u32 max_mcps;
-- 
2.4.3
