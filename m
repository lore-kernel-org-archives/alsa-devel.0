From: kbuild test robot <fengguang.wu@intel.com>
Subject: [RFC PATCH] ASoC: TSCS454: tscs454_set_sysclk() can be static
Date: Thu, 31 May 2018 02:25:45 +0800
Message-ID: <20180530182545.GA106931@lkp-hsx03>
References: <20180529105147.GA32219@t7-ThinkPad-E560>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180529105147.GA32219@t7-ThinkPad-E560>
Sender: linux-kernel-owner@vger.kernel.org
Cc: kbuild-all@01.org, alsa-devel@alsa-project.org, Steven Eckhoff <steven.eckhoff.opensource@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


Fixes: 3bed8970d09a ("ASoC: TSCS454: Add Support")
Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
---
 tscs454.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tscs454.c b/sound/soc/codecs/tscs454.c
index 8d8cac3..d7e4f7c 100644
--- a/sound/soc/codecs/tscs454.c
+++ b/sound/soc/codecs/tscs454.c
@@ -2626,7 +2626,7 @@ static struct snd_soc_dapm_route const tscs454_intercon[] = {
 };
 
 /* This is used when BCLK is sourcing the PLLs */
-int tscs454_set_sysclk(struct snd_soc_dai *dai, int clk_id, unsigned int freq,
+static int tscs454_set_sysclk(struct snd_soc_dai *dai, int clk_id, unsigned int freq,
 		int dir)
 {
 	struct snd_soc_component *component = dai->component;
