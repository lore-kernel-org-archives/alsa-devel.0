From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: intel: skylake: Add missing break in
	skl_tplg_get_token()" to the asoc tree
Date: Thu,  4 Oct 2018 11:42:48 +0100 (BST)
Message-ID: <20181004104248.3D2EA1121BA8@debutante.sirena.org.uk>
References: <20181003173144.5132-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B3792678E4
 for <alsa-devel@alsa-project.org>; Thu,  4 Oct 2018 12:42:49 +0200 (CEST)
In-Reply-To: <20181003173144.5132-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Jie Yang <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, stable@vger.kernel.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: intel: skylake: Add missing break in skl_tplg_get_token()

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 9c80c5a8831471e0a3e139aad1b0d4c0fdc50b2f Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Wed, 3 Oct 2018 19:31:44 +0200
Subject: [PATCH] ASoC: intel: skylake: Add missing break in
 skl_tplg_get_token()

skl_tplg_get_token() misses a break in the big switch() block for
SKL_TKN_U8_CORE_ID entry.
Spotted nicely by -Wimplicit-fallthrough compiler option.

Fixes: 6277e83292a2 ("ASoC: Intel: Skylake: Parse vendor tokens to build module data")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-topology.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 52a9915da0f5..cf8848b779dc 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -2460,6 +2460,7 @@ static int skl_tplg_get_token(struct device *dev,
 
 	case SKL_TKN_U8_CORE_ID:
 		mconfig->core_id = tkn_elem->value;
+		break;
 
 	case SKL_TKN_U8_MOD_TYPE:
 		mconfig->m_type = tkn_elem->value;
-- 
2.19.0.rc2
