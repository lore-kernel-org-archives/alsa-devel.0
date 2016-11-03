From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Add support for
	specifying D0i3 configuration" to the asoc tree
Date: Thu, 03 Nov 2016 11:26:37 -0600
Message-ID: <E1c2Lmf-0002cX-6P@finisterre>
References: <1474868137-29712-8-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 912EC2667EA
 for <alsa-devel@alsa-project.org>; Thu,  3 Nov 2016 18:26:45 +0100 (CET)
In-Reply-To: <1474868137-29712-8-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Jayachandran B <jayachandran.b@intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Add support for specifying D0i3 configuration

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

>From 6bd9dcf339ebb292fa149ee0e52ea3c9d9822553 Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Thu, 3 Nov 2016 17:07:19 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Add support for specifying D0i3
 configuration

Not all use cases can support Doi3. Only certain use cases like hot word
detection, deep buffering can support D0i3 based on resource requirement.

So, pass the D0i3 capability for the FE/BE copier using topology. This will
be used to take a decision for D0i3 mode entry/exit.

Signed-off-by: Jayachandran B <jayachandran.b@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/uapi/sound/snd_sst_tokens.h    | 5 ++++-
 sound/soc/intel/skylake/skl-topology.c | 4 ++++
 sound/soc/intel/skylake/skl-topology.h | 7 +++++++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/uapi/sound/snd_sst_tokens.h b/include/uapi/sound/snd_sst_tokens.h
index f4b8b34de519..93392bedcc58 100644
--- a/include/uapi/sound/snd_sst_tokens.h
+++ b/include/uapi/sound/snd_sst_tokens.h
@@ -159,6 +159,8 @@
  *
  * %SKL_TKN_U32_PMODE:		Specifies the power mode for pipe
  *
+ * %SKL_TKL_U32_D0I3_CAPS:	Specifies the D0i3 capability for module
+ *
  * module_id and loadable flags dont have tokens as these values will be
  * read from the DSP FW manifest
  */
@@ -211,7 +213,8 @@ enum SKL_TKNS {
 	SKL_TKN_U32_LIB_COUNT,
 	SKL_TKN_STR_LIB_NAME,
 	SKL_TKN_U32_PMODE,
-	SKL_TKN_MAX = SKL_TKN_U32_PMODE,
+	SKL_TKL_U32_D0I3_CAPS,
+	SKL_TKN_MAX = SKL_TKL_U32_D0I3_CAPS,
 };
 
 #endif
diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 9a7a008f6689..86597d491982 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -1830,6 +1830,10 @@ static int skl_tplg_get_token(struct device *dev,
 		mconfig->converter = tkn_elem->value;
 		break;
 
+	case SKL_TKL_U32_D0I3_CAPS:
+		mconfig->d0i3_caps = tkn_elem->value;
+		break;
+
 	case SKL_TKN_U32_PIPE_ID:
 		ret = skl_tplg_add_pipe(dev,
 				mconfig, skl, tkn_elem);
diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
index 11fd0a4b6603..38809f6d20d6 100644
--- a/sound/soc/intel/skylake/skl-topology.h
+++ b/sound/soc/intel/skylake/skl-topology.h
@@ -294,6 +294,12 @@ enum skl_module_state {
 	SKL_MODULE_UNLOADED = 4,
 };
 
+enum d0i3_capability {
+	SKL_D0I3_NONE = 0,
+	SKL_D0I3_STREAMING = 1,
+	SKL_D0I3_NON_STREAMING = 2,
+};
+
 struct skl_module_cfg {
 	u8 guid[16];
 	struct skl_module_inst_id id;
@@ -320,6 +326,7 @@ struct skl_module_cfg {
 	u32 converter;
 	u32 vbus_id;
 	u32 mem_pages;
+	enum d0i3_capability d0i3_caps;
 	struct skl_module_pin *m_in_pin;
 	struct skl_module_pin *m_out_pin;
 	enum skl_module_type m_type;
-- 
2.10.1
