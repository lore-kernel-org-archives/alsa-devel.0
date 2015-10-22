From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 9/9] ASoC: Intel: Skylake: Add support to
	topology for module static pin
Date: Thu, 22 Oct 2015 23:22:42 +0530
Message-ID: <1445536362-26670-10-git-send-email-vinod.koul@intel.com>
References: <1445536362-26670-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 11DA12605AE
 for <alsa-devel@alsa-project.org>; Thu, 22 Oct 2015 19:53:51 +0200 (CEST)
In-Reply-To: <1445536362-26670-1-git-send-email-vinod.koul@intel.com>
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

Some module pin connection are static and defined by the topology.
This patch adds support for static pin definitions in topology widget
private data

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-topology.c       | 32 +++++++++++++++-------------
 sound/soc/intel/skylake/skl-tplg-interface.h |  6 ++++--
 2 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 68e1b00ce7ed..a7854c8fc523 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -1034,18 +1034,17 @@ static const struct snd_soc_tplg_widget_events skl_tplg_widget_ops[] = {
  * The topology binary passes the pin info for a module so initialize the pin
  * info passed into module instance
  */
-static void skl_fill_module_pin_info(struct device *dev,
-			struct skl_module_pin *m_pin,
-			int max_pin)
+static void skl_fill_module_pin_info(struct skl_dfw_module_pin *dfw_pin,
+						struct skl_module_pin *m_pin,
+						bool is_dynamic, int max_pin)
 {
 	int i;
 
 	for (i = 0; i < max_pin; i++) {
-		m_pin[i].id.module_id = 0;
-		m_pin[i].id.instance_id = 0;
+		m_pin[i].id.module_id = dfw_pin[i].module_id;
+		m_pin[i].id.instance_id = dfw_pin[i].instance_id;
 		m_pin[i].in_use = false;
-		m_pin[i].is_dynamic = true;
-		m_pin[i].pin_index = i;
+		m_pin[i].is_dynamic = is_dynamic;
 	}
 }
 
@@ -1164,17 +1163,20 @@ static int skl_tplg_widget_load(struct snd_soc_component *cmpnt,
 	if (!mconfig->m_in_pin)
 		return -ENOMEM;
 
-	mconfig->m_out_pin = devm_kzalloc(bus->dev,
-				(mconfig->max_in_queue) *
-					sizeof(*mconfig->m_out_pin),
-				GFP_KERNEL);
+	mconfig->m_out_pin = devm_kzalloc(bus->dev, (mconfig->max_out_queue) *
+						sizeof(*mconfig->m_out_pin),
+						GFP_KERNEL);
 	if (!mconfig->m_out_pin)
 		return -ENOMEM;
 
-	skl_fill_module_pin_info(bus->dev, mconfig->m_in_pin,
-				mconfig->max_in_queue);
-	skl_fill_module_pin_info(bus->dev, mconfig->m_out_pin,
-				mconfig->max_out_queue);
+	skl_fill_module_pin_info(dfw_config->in_pin, mconfig->m_in_pin,
+						dfw_config->is_dynamic_in_pin,
+						mconfig->max_in_queue);
+
+	skl_fill_module_pin_info(dfw_config->out_pin, mconfig->m_out_pin,
+						 dfw_config->is_dynamic_out_pin,
+							mconfig->max_out_queue);
+
 
 	if (mconfig->formats_config.caps_size == 0)
 		goto bind_event;
diff --git a/sound/soc/intel/skylake/skl-tplg-interface.h b/sound/soc/intel/skylake/skl-tplg-interface.h
index 718d3d5df9a8..2bc396d54cbe 100644
--- a/sound/soc/intel/skylake/skl-tplg-interface.h
+++ b/sound/soc/intel/skylake/skl-tplg-interface.h
@@ -113,8 +113,6 @@ enum skl_dev_type {
 struct skl_dfw_module_pin {
 	u16 module_id;
 	u16 instance_id;
-	u8 pin_id;
-	bool is_dynamic;
 } __packed;
 
 struct skl_dfw_module_fmt {
@@ -155,9 +153,13 @@ struct skl_dfw_module {
 	u32 converter;
 	u32 module_type;
 	u32 vbus_id;
+	u8 is_dynamic_in_pin;
+	u8 is_dynamic_out_pin;
 	struct skl_dfw_pipe pipe;
 	struct skl_dfw_module_fmt in_fmt;
 	struct skl_dfw_module_fmt out_fmt;
+	struct skl_dfw_module_pin in_pin[MAX_IN_QUEUE];
+	struct skl_dfw_module_pin out_pin[MAX_OUT_QUEUE];
 	struct skl_dfw_module_caps caps;
 } __packed;
 
-- 
1.9.1
