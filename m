From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: use a helper macro to
	rounding-up calculation" to the asoc tree
Date: Wed, 08 Mar 2017 14:23:30 +0100
Message-ID: <E1clbYw-0000Qf-DI@finisterre>
References: <20170306071222.16219-1-takashi.sakamoto@miraclelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 43C8B2671BA
 for <alsa-devel@alsa-project.org>; Wed,  8 Mar 2017 14:23:42 +0100 (CET)
In-Reply-To: <20170306071222.16219-1-takashi.sakamoto@miraclelinux.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <takashi.sakamoto@miraclelinux.com>
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, ichiro.suzuki@miraclelinux.com, Takashi Sakamoto <o-takashi@sakamocchi.jp>, broonie@kernel.org, shreyas.nc@intel.com, jeeja.kp@intel.com, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, yukie.kato@miraclelinux.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: use a helper macro to rounding-up calculation

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

>From 8e15e762cddf68a401df5c6aa45da3c27712e856 Mon Sep 17 00:00:00 2001
From: Takashi Sakamoto <takashi.sakamoto@miraclelinux.com>
Date: Mon, 6 Mar 2017 16:12:22 +0900
Subject: [PATCH] ASoC: Intel: Skylake: use a helper macro to rounding-up
 calculation

In 'include/linux/kernel.h', there's a helper macro to round numerical
value. Let's use it.

Signed-off-by: Takashi Sakamoto <takashi.sakamoto@miraclelinux.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Tested-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-topology.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index ed58b5b3555a..17a9a55026a4 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -299,8 +299,6 @@ static void skl_tplg_update_buffer_size(struct skl_sst *ctx,
 {
 	int multiplier = 1;
 	struct skl_module_fmt *in_fmt, *out_fmt;
-	int in_rate, out_rate;
-
 
 	/* Since fixups is applied to pin 0 only, ibs, obs needs
 	 * change for pin 0 only
@@ -311,21 +309,13 @@ static void skl_tplg_update_buffer_size(struct skl_sst *ctx,
 	if (mcfg->m_type == SKL_MODULE_TYPE_SRCINT)
 		multiplier = 5;
 
-	if (in_fmt->s_freq % 1000)
-		in_rate = (in_fmt->s_freq / 1000) + 1;
-	else
-		in_rate = (in_fmt->s_freq / 1000);
-
-	mcfg->ibs = in_rate * (mcfg->in_fmt->channels) *
+	mcfg->ibs = DIV_ROUND_UP(in_fmt->s_freq, 1000) *
+			(mcfg->in_fmt->channels) *
 			(mcfg->in_fmt->bit_depth >> 3) *
 			multiplier;
 
-	if (mcfg->out_fmt->s_freq % 1000)
-		out_rate = (mcfg->out_fmt->s_freq / 1000) + 1;
-	else
-		out_rate = (mcfg->out_fmt->s_freq / 1000);
-
-	mcfg->obs = out_rate * (mcfg->out_fmt->channels) *
+	mcfg->obs = DIV_ROUND_UP(mcfg->out_fmt->s_freq, 1000) *
+			(mcfg->out_fmt->channels) *
 			(mcfg->out_fmt->bit_depth >> 3) *
 			multiplier;
 }
-- 
2.11.0
