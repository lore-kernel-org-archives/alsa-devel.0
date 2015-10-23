From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Add support to topology
	for module static pin" to the asoc tree
Date: Sat, 24 Oct 2015 02:47:41 +0900
Message-ID: <E1ZpgRJ-0006SX-GG@finisterre>
References: <1445536362-26670-10-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A6CE265142
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 19:47:53 +0200 (CEST)
In-Reply-To: <1445536362-26670-10-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Add support to topology for module static pin

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

>From 6abca1d71b62090821240ee2a4507c94ddd144e9 Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Thu, 22 Oct 2015 23:22:42 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Add support to topology for module
 static pin

Some module pin connection are static and defined by the topology.
This patch adds support for static pin definitions in topology widget
private data

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-topology.c       | 32 +++++++++++++++-------------
 sound/soc/intel/skylake/skl-tplg-interface.h |  6 ++++--
 2 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 68e1b00..a7854c8 100644
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
index 718d3d5..2bc396d 100644
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
2.6.1
