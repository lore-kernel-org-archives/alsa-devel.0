From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 14/17] ASoC: Intel: Skylake: Add support
	for module GUIDs
Date: Fri, 30 Oct 2015 11:08:27 +0900
Message-ID: <E1Zrz7D-00019o-I6@finisterre>
References: <1445905380-18167-15-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CA255265DC3
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2015 03:08:30 +0100 (CET)
In-Reply-To: <1445905380-18167-15-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hardik T Shah <hardik.t.shah@intel.com>, Omair M Abdullah <omair.m.abdullah@intel.com>, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Add support for module GUIDs

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

>From 16b52e8a4f208a613a347fba8bc45bfd50f7e922 Mon Sep 17 00:00:00 2001
From: Hardik T Shah <hardik.t.shah@intel.com>
Date: Tue, 27 Oct 2015 09:22:57 +0900
Subject: [PATCH] ASoC: Intel: Skylake: Add support for module GUIDs

The DSP FW specifies loadable modules using GUIDs so add support to
specify the GUIDs from topology

Signed-off-by: Hardik T Shah <hardik.t.shah@intel.com>
Signed-off-by: Omair M Abdullah <omair.m.abdullah@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-topology.c       | 4 ++++
 sound/soc/intel/skylake/skl-topology.h       | 1 +
 sound/soc/intel/skylake/skl-tplg-interface.h | 3 +++
 3 files changed, 8 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 37e5c4f..3c5f062 100644
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
index 4b0a59898..57cb7b8 100644
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
index aeb8f25..20c0687 100644
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
2.6.1
