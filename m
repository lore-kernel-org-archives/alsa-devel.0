From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Fix the memory
	overwrite of tlv buffer" to the asoc tree
Date: Thu, 04 Feb 2016 12:16:18 +0000
Message-ID: <E1aRIpe-0001Gz-39@debutante>
References: <1454502594-21700-2-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 52FFE261583
 for <alsa-devel@alsa-project.org>; Thu,  4 Feb 2016 13:16:24 +0100 (CET)
In-Reply-To: <1454502594-21700-2-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Fix the memory overwrite of tlv buffer

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

>From 41556f68d1dd0b6bbf311a220523b034d2a040e7 Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Wed, 3 Feb 2016 17:59:44 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Fix the memory overwrite of tlv buffer

TLV buffer can be smaller than the module data, so update the
size of data to be copied before doing the copy.

Also TLV header consists of two unsigned ints, this is also taken
into account here and size modified to reflect this

Suggested-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-topology.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index c7816d52ad08..c67e3acb8102 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -916,6 +916,13 @@ static int skl_tplg_tlv_control_get(struct snd_kcontrol *kcontrol,
 		skl_get_module_params(skl->skl_sst, (u32 *)bc->params,
 				      bc->max, bc->param_id, mconfig);
 
+	/* decrement size for TLV header */
+	size -= 2 * sizeof(u32);
+
+	/* check size as we don't want to send kernel data */
+	if (size > bc->max)
+		size = bc->max;
+
 	if (bc->params) {
 		if (copy_to_user(data, &bc->param_id, sizeof(u32)))
 			return -EFAULT;
-- 
2.7.0.rc3
