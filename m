From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Fix typo for token d0i3
	caps" to the asoc tree
Date: Mon, 15 May 2017 17:03:06 +0900
Message-ID: <E1dAAyA-0002Tm-El@finisterre>
References: <1493887151-508-2-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7063026728F
 for <alsa-devel@alsa-project.org>; Mon, 15 May 2017 10:03:17 +0200 (CEST)
In-Reply-To: <1493887151-508-2-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, lgirdwood@gmail.com, patches.audio@intel.com, tiwai@suse.de, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Fix typo for token d0i3 caps

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

>From c0116be3d191393928d39791d203a4495d77b66c Mon Sep 17 00:00:00 2001
From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Date: Thu, 4 May 2017 14:09:11 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Fix typo for token d0i3 caps

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/uapi/sound/snd_sst_tokens.h    | 5 +++--
 sound/soc/intel/skylake/skl-topology.c | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/uapi/sound/snd_sst_tokens.h b/include/uapi/sound/snd_sst_tokens.h
index 93392bedcc58..89b82f6256ad 100644
--- a/include/uapi/sound/snd_sst_tokens.h
+++ b/include/uapi/sound/snd_sst_tokens.h
@@ -213,8 +213,9 @@ enum SKL_TKNS {
 	SKL_TKN_U32_LIB_COUNT,
 	SKL_TKN_STR_LIB_NAME,
 	SKL_TKN_U32_PMODE,
-	SKL_TKL_U32_D0I3_CAPS,
-	SKL_TKN_MAX = SKL_TKL_U32_D0I3_CAPS,
+	SKL_TKL_U32_D0I3_CAPS, /* Typo added at v4.10 */
+	SKL_TKN_U32_D0I3_CAPS = SKL_TKL_U32_D0I3_CAPS,
+	SKL_TKN_MAX = SKL_TKN_U32_D0I3_CAPS,
 };
 
 #endif
diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 3a99712e44a8..b28199a5348c 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -1995,7 +1995,7 @@ static int skl_tplg_get_token(struct device *dev,
 		mconfig->converter = tkn_elem->value;
 		break;
 
-	case SKL_TKL_U32_D0I3_CAPS:
+	case SKL_TKN_U32_D0I3_CAPS:
 		mconfig->d0i3_caps = tkn_elem->value;
 		break;
 
-- 
2.11.0
