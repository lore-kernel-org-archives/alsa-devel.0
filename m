From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Fix potential NULL
	pointer dereference" to the asoc tree
Date: Wed, 08 Nov 2017 21:33:26 +0000
Message-ID: <E1eCXyQ-0005ZC-9i@debutante>
References: <20171107104626.25800-4-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 66194266EDF
 for <alsa-devel@alsa-project.org>; Wed,  8 Nov 2017 22:35:02 +0100 (CET)
In-Reply-To: <20171107104626.25800-4-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Patches Audio <patches.audio@intel.com>, Mark Brown <broonie@kernel.org>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Fix potential NULL pointer dereference

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

>From 0265ddd7b713bd8b68a9ec451761bcb87bbac4b3 Mon Sep 17 00:00:00 2001
From: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
Date: Tue, 7 Nov 2017 16:16:18 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Fix potential NULL pointer dereference

Pointer 'mconfig' returned from call to skl_tplg_fe_get_cpr_module() can
be NULL. So check for the valid pointer before dereferencing.

Signed-off-by: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-pcm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 2b1e513b1680..a3cb204e9640 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -355,7 +355,8 @@ static void skl_pcm_close(struct snd_pcm_substream *substream,
 	}
 
 	mconfig = skl_tplg_fe_get_cpr_module(dai, substream->stream);
-	skl_tplg_d0i3_put(skl, mconfig->d0i3_caps);
+	if (mconfig)
+		skl_tplg_d0i3_put(skl, mconfig->d0i3_caps);
 
 	kfree(dma_params);
 }
-- 
2.15.0
