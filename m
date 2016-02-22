From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: topology: fix build warning" to the
	asoc tree
Date: Mon, 22 Feb 2016 19:51:32 +0900
Message-ID: <E1aXo5U-0005g4-Um@finisterre>
References: <1456132033-15326-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F74E2659CE
 for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2016 11:51:44 +0100 (CET)
In-Reply-To: <1456132033-15326-1-git-send-email-sudipm.mukherjee@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: topology: fix build warning

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

>From 3375cbe420a8987b30daf3c021bea6fb0b0fe344 Mon Sep 17 00:00:00 2001
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Mon, 22 Feb 2016 14:37:13 +0530
Subject: [PATCH] ASoC: topology: fix build warning

We are getting build warning about:
sound/soc/soc-topology.c:249:31: warning: 'get_dobj_type' defined but
not used

commit 64527e8a3529 has removed the only caller of get_dobj_type() but
missed to remove the function which is now unused. And after removing
get_dobj_type() we do not have any use of get_dobj_mixer_type().

Fixes: 64527e8a3529 ("ASoC: topology: Add FE DAIs dynamically")
CC: Mengdong Lin <mengdong.lin@linux.intel.com>
Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-topology.c | 45 ---------------------------------------------
 1 file changed, 45 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 0eb01e8155f1..07f61a67aef6 100644
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
2.7.0
