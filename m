From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ASoC: sunxi: Uninitialized variable in probe()
Date: Thu, 24 Nov 2016 01:29:06 +0300
Message-ID: <20161123222906.GA27895@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>
Cc: Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Oddly enough, my version of GCC misses this uninitialized variable.

Fixes: ba2ff3027b5a ("ASoC: sunxi: Add support for A23/A33/H3 codec's analog path controls")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/soc/sunxi/sun8i-codec-analog.c b/sound/soc/sunxi/sun8i-codec-analog.c
index 222bbd4..af02290 100644
--- a/sound/soc/sunxi/sun8i-codec-analog.c
+++ b/sound/soc/sunxi/sun8i-codec-analog.c
@@ -589,7 +589,7 @@ static int sun8i_codec_analog_cmpnt_probe(struct snd_soc_component *cmpnt)
 	}
 
 	if (quirks->has_hmic) {
-		sun8i_codec_add_hmic(cmpnt);
+		ret = sun8i_codec_add_hmic(cmpnt);
 		if (ret)
 			return ret;
 	}
