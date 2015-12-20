From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 4/4] ASoC: Intel: add NULL test
Date: Sun, 20 Dec 2015 12:15:53 +0100
Message-ID: <1450610153-7746-5-git-send-email-Julia.Lawall@lip6.fr>
References: <1450610153-7746-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <1450610153-7746-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: kernel-janitors-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: kernel-janitors@vger.kernel.org, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Add NULL test on call to devm_kzalloc.

The semantic match that finds this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
expression x;
identifier fld;
@@

* x = devm_kzalloc(...);
  ... when != x == NULL
  x->fld
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 sound/soc/intel/baytrail/sst-baytrail-pcm.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/intel/baytrail/sst-baytrail-pcm.c b/sound/soc/intel/baytrail/sst-baytrail-pcm.c
index 79547be..4765ad4 100644
--- a/sound/soc/intel/baytrail/sst-baytrail-pcm.c
+++ b/sound/soc/intel/baytrail/sst-baytrail-pcm.c
@@ -377,6 +377,8 @@ static int sst_byt_pcm_probe(struct snd_soc_platform *platform)
 
 	priv_data = devm_kzalloc(platform->dev, sizeof(*priv_data),
 				 GFP_KERNEL);
+	if (!priv_data)
+		return -ENOMEM;
 	priv_data->byt = plat_data->dsp;
 	snd_soc_platform_set_drvdata(platform, priv_data);
 

