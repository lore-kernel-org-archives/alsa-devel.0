From: Dan Carpenter <error27@gmail.com>
Subject: [patch] ASoC: sgtl5000: use after free in
	ldo_regulator_register()
Date: Tue, 8 Mar 2011 14:39:24 +0300
Message-ID: <20110308113924.GC3416@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 1C70B10381E
	for <alsa-devel@alsa-project.org>; Tue,  8 Mar 2011 12:39:54 +0100 (CET)
Received: by fxm11 with SMTP id 11so5072457fxm.38
	for <alsa-devel@alsa-project.org>; Tue, 08 Mar 2011 03:39:53 -0800 (PST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, Zeng Zhaoming <b32542@freescale.com>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The "ldo" variable was dereferenced after free on the error path.

Signed-off-by: Dan Carpenter <error27@gmail.com>

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index b7e97c0..1f7217f 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -875,11 +875,13 @@ static int ldo_regulator_register(struct snd_soc_codec *codec,
 	ldo->dev = regulator_register(&ldo->desc, codec->dev,
 					  init_data, ldo);
 	if (IS_ERR(ldo->dev)) {
+		int ret = PTR_ERR(ldo->dev);
+
 		dev_err(codec->dev, "failed to register regulator\n");
 		kfree(ldo->desc.name);
 		kfree(ldo);
 
-		return PTR_ERR(ldo->dev);
+		return ret;
 	}
 
 	return 0;
