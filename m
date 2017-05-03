From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH 2/2] ASoC: Intel: Skylake: Fix typo for token
	d0i3 caps
Date: Wed,  3 May 2017 15:37:35 +0530
Message-ID: <1493806055-28046-2-git-send-email-subhransu.s.prusty@intel.com>
References: <1493806055-28046-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B137266949
 for <alsa-devel@alsa-project.org>; Wed,  3 May 2017 12:21:01 +0200 (CEST)
In-Reply-To: <1493806055-28046-1-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
---
 include/uapi/sound/snd_sst_tokens.h    | 4 ++--
 sound/soc/intel/skylake/skl-topology.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/uapi/sound/snd_sst_tokens.h b/include/uapi/sound/snd_sst_tokens.h
index 93392bedcc58..685149dda66b 100644
--- a/include/uapi/sound/snd_sst_tokens.h
+++ b/include/uapi/sound/snd_sst_tokens.h
@@ -213,8 +213,8 @@ enum SKL_TKNS {
 	SKL_TKN_U32_LIB_COUNT,
 	SKL_TKN_STR_LIB_NAME,
 	SKL_TKN_U32_PMODE,
-	SKL_TKL_U32_D0I3_CAPS,
-	SKL_TKN_MAX = SKL_TKL_U32_D0I3_CAPS,
+	SKL_TKN_U32_D0I3_CAPS,
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
1.9.1
