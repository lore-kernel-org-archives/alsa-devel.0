From: Harsha Priya <harshapriya.n@intel.com>
Subject: [v2 3/3] ASoC: Intel: Enabling 4 slot IV feedback for
	max98927 on Kabylake platform
Date: Wed, 26 Jul 2017 13:47:45 -0700
Message-ID: <1501102065-11083-4-git-send-email-harshapriya.n@intel.com>
References: <1501102065-11083-1-git-send-email-harshapriya.n@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id C41A226757C
 for <alsa-devel@alsa-project.org>; Wed, 26 Jul 2017 22:48:04 +0200 (CEST)
In-Reply-To: <1501102065-11083-1-git-send-email-harshapriya.n@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, vinod.koul@intel.com, broonie@kernel.org, alsa-devel@alsa-project.org
Cc: Harsha Priya <harshapriya.n@intel.com>
List-Id: alsa-devel@alsa-project.org

This patch enables 4 slot IV feedback for max98927 speaker amp codec.

Signed-off-by: Harsha Priya <harshapriya.n@intel.com>
---
 sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
index cfd89ca..a675ae5 100644
--- a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
@@ -358,11 +358,18 @@ static int kabylake_ssp0_hw_params(struct snd_pcm_substream *substream,
 				return ret;
 			}
 		}
-		if (!strcmp(codec_dai->component->name, MAXIM_DEV0_NAME) ||
-			!strcmp(codec_dai->component->name, MAXIM_DEV1_NAME)) {
-			ret = snd_soc_dai_set_tdm_slot(codec_dai, 0xF0, 3, 8, 16);
+		if (!strcmp(codec_dai->component->name, MAXIM_DEV0_NAME)) {
+			ret = snd_soc_dai_set_tdm_slot(codec_dai, 0x30, 3, 8, 16);
 			if (ret < 0) {
-				dev_err(rtd->dev, "set TDM slot err:%d\n", ret);
+				dev_err(rtd->dev, "DEV0 TDM slot err:%d\n", ret);
+				return ret;
+			}
+		}
+
+		if (!strcmp(codec_dai->component->name, MAXIM_DEV1_NAME)) {
+			ret = snd_soc_dai_set_tdm_slot(codec_dai, 0xC0, 3, 8, 16);
+			if (ret < 0) {
+				dev_err(rtd->dev, "DEV1 TDM slot err:%d\n", ret);
 				return ret;
 			}
 		}
-- 
1.9.1
