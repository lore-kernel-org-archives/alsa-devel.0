From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Remove second shim read
	in register_poll" to the asoc tree
Date: Wed, 06 Dec 2017 17:49:46 +0000
Message-ID: <E1eMdpK-0004oI-9S@debutante>
References: <20171107104626.25800-6-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 5E1F2267A48
 for <alsa-devel@alsa-project.org>; Wed,  6 Dec 2017 18:49:49 +0100 (CET)
In-Reply-To: <20171107104626.25800-6-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Patches Audio <patches.audio@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Remove second shim read in register_poll

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

>From b2ca3bdd07f68ca63fdb8e45f1fe039ba6af54a2 Mon Sep 17 00:00:00 2001
From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Date: Wed, 6 Dec 2017 16:34:01 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Remove second shim read in
 register_poll

No need to read the register again if the value read has already matched
the target during the loop. So remove the second shim read.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/common/sst-dsp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/intel/common/sst-dsp.c b/sound/soc/intel/common/sst-dsp.c
index 11c0805393ff..fd82f4b1d4a0 100644
--- a/sound/soc/intel/common/sst-dsp.c
+++ b/sound/soc/intel/common/sst-dsp.c
@@ -269,7 +269,7 @@ int sst_dsp_register_poll(struct sst_dsp *ctx, u32 offset, u32 mask,
 	 */
 
 	timeout = jiffies + msecs_to_jiffies(time);
-	while (((sst_dsp_shim_read_unlocked(ctx, offset) & mask) != target)
+	while ((((reg = sst_dsp_shim_read_unlocked(ctx, offset)) & mask) != target)
 		&& time_before(jiffies, timeout)) {
 		k++;
 		if (k > 10)
@@ -278,8 +278,6 @@ int sst_dsp_register_poll(struct sst_dsp *ctx, u32 offset, u32 mask,
 		usleep_range(s, 2*s);
 	}
 
-	reg = sst_dsp_shim_read_unlocked(ctx, offset);
-
 	if ((reg & mask) == target) {
 		dev_dbg(ctx->dev, "FW Poll Status: reg=%#x %s successful\n",
 					reg, operation);
-- 
2.15.0
