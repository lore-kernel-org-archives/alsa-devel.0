From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH 1/3] ASoC: Intel: Skylake: Add deep buffer
	support
Date: Mon, 12 Jun 2017 17:10:55 +0530
Message-ID: <1497267657-20359-2-git-send-email-subhransu.s.prusty@intel.com>
References: <1497267657-20359-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id A1161266E17
 for <alsa-devel@alsa-project.org>; Mon, 12 Jun 2017 13:55:44 +0200 (CEST)
In-Reply-To: <1497267657-20359-1-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: tiwai@suse.de, lgirdwood@gmail.com, Ramesh Babu <ramesh.babu@intel.com>, patches.audio@intel.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Ramesh Babu <ramesh.babu@intel.com>

With this patch, the dma buffer size is fetched from topology binary. This
buffer size is applicable for gateway copier modules.

Now that we can configure DSP dma buffer size, the device can support deep
buffer playback. DSP fetches large buffer and can result fewer wakes,
which helps in power reduction.

Signed-off-by: Ramesh Babu <ramesh.babu@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
---
 include/uapi/sound/snd_sst_tokens.h    | 7 +++++--
 sound/soc/intel/skylake/skl-topology.c | 4 ++++
 sound/soc/intel/skylake/skl-topology.h | 1 +
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/uapi/sound/snd_sst_tokens.h b/include/uapi/sound/snd_sst_tokens.h
index 89b82f6256ad..f1c9416294a5 100644
--- a/include/uapi/sound/snd_sst_tokens.h
+++ b/include/uapi/sound/snd_sst_tokens.h
@@ -152,7 +152,7 @@
  * %SKL_TKN_U32_CAPS_SIZE:      Caps size
  *
  * %SKL_TKN_U32_PROC_DOMAIN:    Specify processing domain
- *
+
  * %SKL_TKN_U32_LIB_COUNT:      Specifies the number of libraries
  *
  * %SKL_TKN_STR_LIB_NAME:       Specifies the library name
@@ -161,6 +161,8 @@
  *
  * %SKL_TKL_U32_D0I3_CAPS:	Specifies the D0i3 capability for module
  *
+ * %SKL_TKN_U32_DMA_BUF_SIZE:	DMA buffer size in millisec
+ *
  * module_id and loadable flags dont have tokens as these values will be
  * read from the DSP FW manifest
  */
@@ -215,7 +217,8 @@ enum SKL_TKNS {
 	SKL_TKN_U32_PMODE,
 	SKL_TKL_U32_D0I3_CAPS, /* Typo added at v4.10 */
 	SKL_TKN_U32_D0I3_CAPS = SKL_TKL_U32_D0I3_CAPS,
-	SKL_TKN_MAX = SKL_TKN_U32_D0I3_CAPS,
+	SKL_TKN_U32_DMA_BUF_SIZE,
+	SKL_TKN_MAX = SKL_TKN_U32_DMA_BUF_SIZE,
 };
 
 #endif
diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index b687ae455a61..2cadfa74438b 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -2086,6 +2086,10 @@ static int skl_tplg_get_token(struct device *dev,
 
 		break;
 
+	case SKL_TKN_U32_DMA_BUF_SIZE:
+		mconfig->dma_buffer_size = tkn_elem->value;
+		break;
+
 	case SKL_TKN_U8_IN_PIN_TYPE:
 	case SKL_TKN_U8_OUT_PIN_TYPE:
 	case SKL_TKN_U8_CONN_TYPE:
diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
index cc64d6bdb4f6..e760e835b885 100644
--- a/sound/soc/intel/skylake/skl-topology.h
+++ b/sound/soc/intel/skylake/skl-topology.h
@@ -314,6 +314,7 @@ struct skl_module_cfg {
 	u32 vbus_id;
 	u32 mem_pages;
 	enum d0i3_capability d0i3_caps;
+	u32 dma_buffer_size; /* in milli seconds */
 	struct skl_module_pin *m_in_pin;
 	struct skl_module_pin *m_out_pin;
 	enum skl_module_type m_type;
-- 
1.9.1
