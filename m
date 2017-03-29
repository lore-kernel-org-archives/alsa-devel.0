From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Add 16-bit constraint
	to FE bxt_rt298 machine" to the asoc tree
Date: Wed, 29 Mar 2017 12:54:30 +0100
Message-ID: <E1ctCBK-0001ZS-1X@debutante>
References: <1490275926-2270-5-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EA35B266FA9
 for <alsa-devel@alsa-project.org>; Wed, 29 Mar 2017 13:54:38 +0200 (CEST)
In-Reply-To: <1490275926-2270-5-git-send-email-jeeja.kp@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: G Kranthi <gudishax.kranthikumar@intel.com>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com, tiwai@suse.de, broonie@kernel.org, liam.r.girdwood@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Add 16-bit constraint to FE bxt_rt298 machine

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

>From e59ed0875b0681ebd1e5062b739742f98f24274c Mon Sep 17 00:00:00 2001
From: G Kranthi <gudishax.kranthikumar@intel.com>
Date: Fri, 24 Mar 2017 23:10:27 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Add 16-bit constraint to FE bxt_rt298
 machine

Add constraint to FE to restrict sample format to 16-bit for bxt_rt298
machine

Signed-off-by: G Kranthi <gudishax.kranthikumar@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bxt_rt298.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/intel/boards/bxt_rt298.c b/sound/soc/intel/boards/bxt_rt298.c
index 176c080a9818..1a68d043c803 100644
--- a/sound/soc/intel/boards/bxt_rt298.c
+++ b/sound/soc/intel/boards/bxt_rt298.c
@@ -274,12 +274,15 @@ static int bxt_fe_startup(struct snd_pcm_substream *substream)
 	 * on this platform for PCM device we support:
 	 *      48Khz
 	 *      stereo
+	 *	16-bit audio
 	 */
 
 	runtime->hw.channels_max = 2;
 	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
 				&constraints_channels);
 
+	runtime->hw.formats = SNDRV_PCM_FMTBIT_S16_LE;
+	snd_pcm_hw_constraint_msbits(runtime, 0, 16, 16);
 	snd_pcm_hw_constraint_list(runtime, 0,
 				SNDRV_PCM_HW_PARAM_RATE, &constraints_rates);
 
-- 
2.11.0
