From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Add deep buffer
	support" to the asoc tree
Date: Mon, 19 Jun 2017 17:24:01 +0100
Message-ID: <E1dMzT7-0002Qa-BF@debutante>
References: <1497853761-4778-2-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 367EE267148
 for <alsa-devel@alsa-project.org>; Mon, 19 Jun 2017 18:24:11 +0200 (CEST)
In-Reply-To: <1497853761-4778-2-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ramesh Babu <ramesh.babu@intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, lgirdwood@gmail.com, patches.audio@intel.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Add deep buffer support

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

>From 939df3ada789ccd61a01721df8fc7955aab3aad7 Mon Sep 17 00:00:00 2001
From: Ramesh Babu <ramesh.babu@intel.com>
Date: Mon, 19 Jun 2017 11:59:19 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Add deep buffer support

With this patch, the dma buffer size is fetched from topology binary. This
buffer size is applicable for gateway copier modules.

Now that we can configure DSP dma buffer size, the device can support deep
buffer playback. DSP fetches large buffer and can result fewer wakes,
which helps in power reduction.

Signed-off-by: Ramesh Babu <ramesh.babu@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/uapi/sound/snd_sst_tokens.h    | 5 ++++-
 sound/soc/intel/skylake/skl-topology.c | 4 ++++
 sound/soc/intel/skylake/skl-topology.h | 1 +
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/uapi/sound/snd_sst_tokens.h b/include/uapi/sound/snd_sst_tokens.h
index 89b82f6256ad..dedb2056160d 100644
--- a/include/uapi/sound/snd_sst_tokens.h
+++ b/include/uapi/sound/snd_sst_tokens.h
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
index 212cee71d586..9569f118e97e 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -2212,6 +2212,10 @@ static int skl_tplg_get_token(struct device *dev,
 
 		break;
 
+	case SKL_TKN_U32_DMA_BUF_SIZE:
+		mconfig->dma_buffer_size = tkn_elem->value;
+		break;
+
 	case SKL_TKN_U8_IN_PIN_TYPE:
 	case SKL_TKN_U8_OUT_PIN_TYPE:
 	case SKL_TKN_U8_CONN_TYPE:
diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
index 3f51a0a00093..c25e8868b84e 100644
--- a/sound/soc/intel/skylake/skl-topology.h
+++ b/sound/soc/intel/skylake/skl-topology.h
@@ -321,6 +321,7 @@ struct skl_module_cfg {
 	u32 vbus_id;
 	u32 mem_pages;
 	enum d0i3_capability d0i3_caps;
+	u32 dma_buffer_size; /* in milli seconds */
 	struct skl_module_pin *m_in_pin;
 	struct skl_module_pin *m_out_pin;
 	enum skl_module_type m_type;
-- 
2.11.0
