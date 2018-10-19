From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: kbl_da7219_max98927: minor white
	space clean up" to the asoc tree
Date: Fri, 19 Oct 2018 13:34:29 +0100 (BST)
Message-ID: <20181019123429.9B6AD1122548@debutante.sirena.org.uk>
References: <20181018073430.c45sl5k62o3ebp2g@kili.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D13A26798F
 for <alsa-devel@alsa-project.org>; Fri, 19 Oct 2018 14:34:32 +0200 (CEST)
In-Reply-To: <20181018073430.c45sl5k62o3ebp2g@kili.mountain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, Vinod Koul <vkoul@kernel.org>, alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Harsha Priya <harshapriya.n@intel.com>, Jie Yang <yang.jie@linux.intel.com>, kernel-janitors@vger.kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mac Chiang <mac.chiang@intel.com>, Mark Brown <broonie@kernel.org>, Naveen Manohar <naveen.m@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: kbl_da7219_max98927: minor white space clean up

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

>From 9ab2a1bd81f7eaef4b496168dd93e0f23e8906fe Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Thu, 18 Oct 2018 10:34:30 +0300
Subject: [PATCH] ASoC: Intel: kbl_da7219_max98927: minor white space clean up

I just added a couple missing tabs.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/kbl_da7219_max98927.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/kbl_da7219_max98927.c b/sound/soc/intel/boards/kbl_da7219_max98927.c
index 3ab96ee7bd3c..3fa1c3ca6d37 100644
--- a/sound/soc/intel/boards/kbl_da7219_max98927.c
+++ b/sound/soc/intel/boards/kbl_da7219_max98927.c
@@ -180,14 +180,14 @@ static int kabylake_ssp0_hw_params(struct snd_pcm_substream *substream,
 			ret = snd_soc_dai_set_tdm_slot(codec_dai, 0x30, 3, 8, 16);
 			if (ret < 0) {
 				dev_err(runtime->dev, "DEV0 TDM slot err:%d\n", ret);
-			return ret;
+				return ret;
 			}
 		}
 		if (!strcmp(codec_dai->component->name, MAXIM_DEV1_NAME)) {
 			ret = snd_soc_dai_set_tdm_slot(codec_dai, 0xC0, 3, 8, 16);
 			if (ret < 0) {
 				dev_err(runtime->dev, "DEV1 TDM slot err:%d\n", ret);
-			return ret;
+				return ret;
 			}
 		}
 	}
-- 
2.19.0.rc2
