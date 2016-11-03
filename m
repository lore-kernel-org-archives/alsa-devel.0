From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 6/9] ASoC: Intel: Skylake: Add support for
	specifying D0i3 configuration
Date: Thu,  3 Nov 2016 17:07:19 +0530
Message-ID: <1478173042-9458-7-git-send-email-vinod.koul@intel.com>
References: <1478173042-9458-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 738692671BA
 for <alsa-devel@alsa-project.org>; Thu,  3 Nov 2016 12:28:32 +0100 (CET)
In-Reply-To: <1478173042-9458-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, Jayachandran B <jayachandran.b@intel.com>
List-Id: alsa-devel@alsa-project.org

Not all use cases can support Doi3. Only certain use cases like hot word
detection, deep buffering can support D0i3 based on resource requirement.

So, pass the D0i3 capability for the FE/BE copier using topology. This will
be used to take a decision for D0i3 mode entry/exit.

Signed-off-by: Jayachandran B <jayachandran.b@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
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
1.9.1
