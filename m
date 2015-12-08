From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Add memory pages to
	widget data." to the asoc tree
Date: Tue, 08 Dec 2015 19:11:28 +0000
Message-ID: <E1a6Nfc-00044y-LU@debutante>
References: <1448703121-5831-9-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A03712606D1
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2015 20:11:34 +0100 (CET)
In-Reply-To: <1448703121-5831-9-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Dharageswari.R" <dharageswari.r@intel.com>, Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Add memory pages to widget data.

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

>From b18c458de143d22773e770fc785c521614c24487 Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Thu, 3 Dec 2015 23:29:51 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Add memory pages to widget data.

A module can require extra memory for processing, like audio
algorithms. The memory for these modules needs to be represented
in base module configuration and passed to DSP on init, so add
the memory pages as a field in widget data

Signed-off-by: Dharageswari.R <dharageswari.r@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
index 32735eff386c..be02214e80db 100644
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
2.6.2
