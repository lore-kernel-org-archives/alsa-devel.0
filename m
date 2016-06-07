From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Set the DSP pipe type"
	to the asoc tree
Date: Tue, 07 Jun 2016 14:27:35 +0100
Message-ID: <E1bAH2d-0001eb-Tf@debutante>
References: <1464958783-19344-9-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C1D6260831
 for <alsa-devel@alsa-project.org>; Tue,  7 Jun 2016 15:27:41 +0200 (CEST)
In-Reply-To: <1464958783-19344-9-git-send-email-jeeja.kp@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Set the DSP pipe type

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

>From f0aa94faa0e8990647eed4d8e232e1e6d5671ff2 Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Fri, 3 Jun 2016 18:29:41 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Set the DSP pipe type

DSP pipe type can be a pass through or it can be processing pipe.
In case of pass through pipe, it is a single pipeline with both
host and link copier in the same pipeline.

Identify the DSP pipe type if it pass through or not. Pass through
pipe is identified by checking if it has both host and link copier
in the same pipeline.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-topology.c | 27 +++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl-topology.h |  1 +
 2 files changed, 28 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 761dfc4ec017..2f1991dc9f55 100644
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
index d4a58bcd8c7d..170d68b4e12d 100644
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
2.8.1
