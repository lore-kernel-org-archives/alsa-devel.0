From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] ASoC: Intel: kbl_da7219_max98927: minor white
	space clean up
Date: Thu, 18 Oct 2018 10:34:30 +0300
Message-ID: <20181018073430.c45sl5k62o3ebp2g@kili.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E879267546
 for <alsa-devel@alsa-project.org>; Thu, 18 Oct 2018 09:34:51 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Mac Chiang <mac.chiang@intel.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Harsha Priya <harshapriya.n@intel.com>, kernel-janitors@vger.kernel.org, Jie Yang <yang.jie@linux.intel.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>, Naveen Manohar <naveen.m@intel.com>
List-Id: alsa-devel@alsa-project.org

I just added a couple missing tabs.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

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
