From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: code cleanup for pin
	fixup limitation" to the asoc tree
Date: Mon, 13 Mar 2017 16:59:15 +0000
Message-ID: <E1cnTJT-0005FL-ED@debutante>
References: <20170308084702.20558-1-takashi.sakamoto@miraclelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7BC82266E35
 for <alsa-devel@alsa-project.org>; Mon, 13 Mar 2017 17:59:24 +0100 (CET)
In-Reply-To: <20170308084702.20558-1-takashi.sakamoto@miraclelinux.com>
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
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, ichiro.suzuki@miraclelinux.com, broonie@kernel.org, shreyas.nc@intel.com, jeeja.kp@intel.com, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, yukie.kato@miraclelinux.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: code cleanup for pin fixup limitation

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

>From 998d6fb5123d5b27edd3abd85b767c822bf766fc Mon Sep 17 00:00:00 2001
From: Takashi Sakamoto <takashi.sakamoto@miraclelinux.com>
Date: Wed, 8 Mar 2017 17:47:02 +0900
Subject: [PATCH] ASoC: Intel: Skylake: code cleanup for pin fixup limitation

As a commit 4cd9899f0d16 ("ASoC: Intel: Skylake: Add multiple pin
formats") describes, 'fixups is applied to pin 0 only'. On the other
hand, the commit left some codes as what they were. This might
confuses readers.

This commit fixes the issue. This doesn't change driver behaviour at all.

Fixes: 4cd9899f0d16 ("ASoC: Intel: Skylake: Add multiple pin formats")
Signed-off-by: Takashi Sakamoto <takashi.sakamoto@miraclelinux.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Tested-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-topology.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 17a9a55026a4..e7836a2e18f0 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -310,13 +310,11 @@ static void skl_tplg_update_buffer_size(struct skl_sst *ctx,
 		multiplier = 5;
 
 	mcfg->ibs = DIV_ROUND_UP(in_fmt->s_freq, 1000) *
-			(mcfg->in_fmt->channels) *
-			(mcfg->in_fmt->bit_depth >> 3) *
+			in_fmt->channels * (in_fmt->bit_depth >> 3) *
 			multiplier;
 
-	mcfg->obs = DIV_ROUND_UP(mcfg->out_fmt->s_freq, 1000) *
-			(mcfg->out_fmt->channels) *
-			(mcfg->out_fmt->bit_depth >> 3) *
+	mcfg->obs = DIV_ROUND_UP(out_fmt->s_freq, 1000) *
+			out_fmt->channels * (out_fmt->bit_depth >> 3) *
 			multiplier;
 }
 
-- 
2.11.0
