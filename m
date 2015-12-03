From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 02/12] ASoC: Intel: Skylake: Add memory
	pages to widget data.
Date: Thu,  3 Dec 2015 23:29:51 +0530
Message-ID: <1449165601-11226-3-git-send-email-vinod.koul@intel.com>
References: <1449165601-11226-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id BBFEC26055E
 for <alsa-devel@alsa-project.org>; Thu,  3 Dec 2015 18:57:09 +0100 (CET)
In-Reply-To: <1449165601-11226-1-git-send-email-vinod.koul@intel.com>
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
Cc: "Dharageswari.R" <dharageswari.r@intel.com>, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

A module can require extra memory for processing, like audio
algorithms. The memory for these modules needs to be represented
in base module configuration and passed to DSP on init, so add
the memory pages as a field in widget data

Signed-off-by: Dharageswari.R <dharageswari.r@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-messages.c | 1 +
 sound/soc/intel/skylake/skl-topology.c | 1 +
 sound/soc/intel/skylake/skl-topology.h | 1 +
 3 files changed, 3 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index 7770a7e4162f..5297b345839a 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -212,6 +212,7 @@ static void skl_set_base_module_format(struct skl_sst *ctx,
 	base_cfg->cps = mconfig->mcps;
 	base_cfg->ibs = mconfig->ibs;
 	base_cfg->obs = mconfig->obs;
+	base_cfg->is_pages = mconfig->mem_pages;
 }
 
 /*
diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 95b6dd49d6a4..ad1388e4f847 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -1339,6 +1339,7 @@ static int skl_tplg_widget_load(struct snd_soc_component *cmpnt,
 	mconfig->converter = dfw_config->converter;
 	mconfig->m_type = dfw_config->module_type;
 	mconfig->vbus_id = dfw_config->vbus_id;
+	mconfig->mem_pages = dfw_config->mem_pages;
 
 	pipe = skl_tplg_add_pipe(bus->dev, skl, &dfw_config->pipe);
 	if (pipe)
diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
index 51e785424a37..04318e2091fd 100644
--- a/sound/soc/intel/skylake/skl-topology.h
+++ b/sound/soc/intel/skylake/skl-topology.h
@@ -277,6 +277,7 @@ struct skl_module_cfg {
 	u32 params_fixup;
 	u32 converter;
 	u32 vbus_id;
+	u32 mem_pages;
 	struct skl_module_pin *m_in_pin;
 	struct skl_module_pin *m_out_pin;
 	enum skl_module_type m_type;
-- 
1.9.1
