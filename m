From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 2/2] ASoC: cht-bsw-rt5645: fix unused variable
	compiler warning
Date: Wed,  1 Feb 2017 12:27:05 -0600
Message-ID: <1485973625-20553-3-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1485973625-20553-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id D6BEC2674E2
 for <alsa-devel@alsa-project.org>; Wed,  1 Feb 2017 19:27:21 +0100 (CET)
In-Reply-To: <1485973625-20553-1-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Missed unused variable in previous changes, oops.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/cht_bsw_rt5645.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boards/cht_bsw_rt5645.c
index b972b65..5bcde01 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5645.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
@@ -262,7 +262,6 @@ static int cht_codec_init(struct snd_soc_pcm_runtime *runtime)
 	int jack_type;
 	struct snd_soc_codec *codec = runtime->codec;
 	struct snd_soc_card *card = runtime->card;
-	struct snd_soc_dai *codec_dai = runtime->codec_dai;
 	struct cht_mc_private *ctx = snd_soc_card_get_drvdata(runtime->card);
 
 	if ((cht_rt5645_quirk & CHT_RT5645_SSP2_AIF2) ||
-- 
2.7.4
