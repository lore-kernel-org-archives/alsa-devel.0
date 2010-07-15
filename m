From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 3/12] da7210: fix a memory leak if failed to initialise
	da7210 audio codec
Date: Thu, 15 Jul 2010 10:53:49 +0800
Message-ID: <1279162429.29294.9.camel@mola>
References: <1279162147.29294.2.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1279162147.29294.2.camel@mola>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Phil Edworthy <Phil.Edworthy@renesas.com>, Tejun Heo <tj@kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

da7210 should be kfreed if da7210_init() return error.
This patch also fixes the error handing in the case of snd_soc_register_dai()
fail by adding snd_soc_unregister_codec() in error path.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/da7210.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/da7210.c b/sound/soc/codecs/da7210.c
index 75af2d6..3b9a6cc 100644
--- a/sound/soc/codecs/da7210.c
+++ b/sound/soc/codecs/da7210.c
@@ -488,7 +488,7 @@ static int da7210_init(struct da7210_priv *da7210)
 	ret = snd_soc_register_dai(&da7210_dai);
 	if (ret) {
 		dev_err(codec->dev, "Failed to register DAI: %d\n", ret);
-		goto init_err;
+		goto codec_err;
 	}
 
 	/* FIXME
@@ -574,6 +574,8 @@ static int da7210_init(struct da7210_priv *da7210)
 
 	return ret;
 
+codec_err:
+	snd_soc_unregister_codec(codec);
 init_err:
 	kfree(codec->reg_cache);
 	codec->reg_cache = NULL;
@@ -601,8 +603,10 @@ static int __devinit da7210_i2c_probe(struct i2c_client *i2c,
 	codec->control_data = i2c;
 
 	ret = da7210_init(da7210);
-	if (ret < 0)
+	if (ret < 0) {
 		pr_err("Failed to initialise da7210 audio codec\n");
+		kfree(da7210);
+	}
 
 	return ret;
 }
-- 
1.5.4.3
