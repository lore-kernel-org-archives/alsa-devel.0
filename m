From: Gen Zhang <blackgod016574@gmail.com>
Subject: [PATCH] pcm030-audio-fabric: Fix a memory leaking bug in
 pcm030_fabric_probe()
Date: Fri, 24 May 2019 10:12:21 +0800
Message-ID: <20190524021221.GA4753@zhanggen-UX430UQ>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

In pcm030_fabric_probe(), 'pdata->codec_device' is allocated by
platform_device_alloc(). When this allocation fails, ENOMEM is returned.
However, 'pdata' is allocated by devm_kzalloc() before this site. We
should free 'pdata' before function ends to prevent memory leaking.

Similarly, we should free 'pdata' when 'pdata->codec_device' is NULL.
And we should free 'pdata->codec_device' and 'pdata' when 'ret' is error
to prevent memory leaking.

Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
---
diff --git a/sound/soc/fsl/pcm030-audio-fabric.c b/sound/soc/fsl/pcm030-audio-fabric.c
index a7fe4ad..d2e6eae 100644
--- a/sound/soc/fsl/pcm030-audio-fabric.c
+++ b/sound/soc/fsl/pcm030-audio-fabric.c
@@ -72,29 +72,43 @@ static int pcm030_fabric_probe(struct platform_device *op)
 	platform_np = of_parse_phandle(np, "asoc-platform", 0);
 	if (!platform_np) {
 		dev_err(&op->dev, "ac97 not registered\n");
-		return -ENODEV;
+		ret = -ENODEV;
+		goto out_free1;
 	}
 
 	for_each_card_prelinks(card, i, dai_link)
 		dai_link->platform_of_node = platform_np;
 
 	ret = request_module("snd-soc-wm9712");
-	if (ret)
+	if (ret) {
 		dev_err(&op->dev, "request_module returned: %d\n", ret);
+		goto out_free1;
+	}
 
 	pdata->codec_device = platform_device_alloc("wm9712-codec", -1);
-	if (!pdata->codec_device)
+	if (!pdata->codec_device) {
 		dev_err(&op->dev, "platform_device_alloc() failed\n");
+		ret = -ENOMEM;
+		goto out_free1;
+	}
 
 	ret = platform_device_add(pdata->codec_device);
-	if (ret)
+	if (ret) {
 		dev_err(&op->dev, "platform_device_add() failed: %d\n", ret);
+		goto out_free2;
+	}
 
 	ret = snd_soc_register_card(card);
-	if (ret)
+	if (ret) {
 		dev_err(&op->dev, "snd_soc_register_card() failed: %d\n", ret);
+		goto out_free2;
+	}
 
 	platform_set_drvdata(op, pdata);
+out_free2:
+	platform_device_put(pdata->codec_device);
+out_free1:
+	devm_kfree(&op->dev, pdata);
 
 	return ret;
 }
---
