From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] ASoC: topology: fix build warning
Date: Mon, 22 Feb 2016 14:37:13 +0530
Message-ID: <1456132033-15326-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Mengdong Lin <mengdong.lin@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

We are getting build warning about:
sound/soc/soc-topology.c:249:31: warning: 'get_dobj_type' defined but
not used

commit 64527e8a3529 has removed the only caller of get_dobj_type() but
missed to remove the function which is now unused. And after removing
get_dobj_type() we do not have any use of get_dobj_mixer_type().

Fixes: 64527e8a3529 ("ASoC: topology: Add FE DAIs dynamically")
CC: Mengdong Lin <mengdong.lin@linux.intel.com>
Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
---
 sound/soc/soc-topology.c | 45 ---------------------------------------------
 1 file changed, 45 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 0eb01e8..07f61a6 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -223,51 +223,6 @@ static int get_widget_id(int tplg_type)
 	return -EINVAL;
 }
 
-static enum snd_soc_dobj_type get_dobj_mixer_type(
-	struct snd_soc_tplg_ctl_hdr *control_hdr)
-{
-	if (control_hdr == NULL)
-		return SND_SOC_DOBJ_NONE;
-
-	switch (control_hdr->ops.info) {
-	case SND_SOC_TPLG_CTL_VOLSW:
-	case SND_SOC_TPLG_CTL_VOLSW_SX:
-	case SND_SOC_TPLG_CTL_VOLSW_XR_SX:
-	case SND_SOC_TPLG_CTL_RANGE:
-	case SND_SOC_TPLG_CTL_STROBE:
-		return SND_SOC_DOBJ_MIXER;
-	case SND_SOC_TPLG_CTL_ENUM:
-	case SND_SOC_TPLG_CTL_ENUM_VALUE:
-		return SND_SOC_DOBJ_ENUM;
-	case SND_SOC_TPLG_CTL_BYTES:
-		return SND_SOC_DOBJ_BYTES;
-	default:
-		return SND_SOC_DOBJ_NONE;
-	}
-}
-
-static enum snd_soc_dobj_type get_dobj_type(struct snd_soc_tplg_hdr *hdr,
-	struct snd_soc_tplg_ctl_hdr *control_hdr)
-{
-	switch (hdr->type) {
-	case SND_SOC_TPLG_TYPE_MIXER:
-		return get_dobj_mixer_type(control_hdr);
-	case SND_SOC_TPLG_TYPE_DAPM_GRAPH:
-	case SND_SOC_TPLG_TYPE_MANIFEST:
-		return SND_SOC_DOBJ_NONE;
-	case SND_SOC_TPLG_TYPE_DAPM_WIDGET:
-		return SND_SOC_DOBJ_WIDGET;
-	case SND_SOC_TPLG_TYPE_DAI_LINK:
-		return SND_SOC_DOBJ_DAI_LINK;
-	case SND_SOC_TPLG_TYPE_PCM:
-		return SND_SOC_DOBJ_PCM;
-	case SND_SOC_TPLG_TYPE_CODEC_LINK:
-		return SND_SOC_DOBJ_CODEC_LINK;
-	default:
-		return SND_SOC_DOBJ_NONE;
-	}
-}
-
 static inline void soc_bind_err(struct soc_tplg *tplg,
 	struct snd_soc_tplg_ctl_hdr *hdr, int index)
 {
-- 
1.9.1
