From: kbuild test robot <lkp@intel.com>
Subject: [RFC PATCH asoc] ASoC: tlv320aic31xx: aic31xx_set_jack() can be
 static
Date: Tue, 2 Apr 2019 19:46:18 +0800
Message-ID: <20190402114618.GA8728@lkp-wsm-ep1>
References: <201904021912.ym8zWPD9%lkp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201904021912.ym8zWPD9%lkp@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: kbuild-all@01.org, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Colin Ian King <colin.king@canonical.com>, Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


Fixes: ebf3326cd969 ("ASoC: tlv320aic31xx: Add headphone/headset detection")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 tlv320aic31xx.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index fa47bfc..9b37e98 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -1264,8 +1264,8 @@ static int aic31xx_set_bias_level(struct snd_soc_component *component,
 	return 0;
 }
 
-int aic31xx_set_jack(struct snd_soc_component *component,
-		     struct snd_soc_jack *jack, void *data)
+static int aic31xx_set_jack(struct snd_soc_component *component,
+			    struct snd_soc_jack *jack, void *data)
 {
 	struct aic31xx_priv *aic31xx = snd_soc_component_get_drvdata(component);
 
