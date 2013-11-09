From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] ASoC: fsl: set correct platform drvdata in
	pcm030_fabric_probe()
Date: Sat, 9 Nov 2013 08:41:14 +0800
Message-ID: <CAPgLHd8kfDJJg045WbRrrd06rKSsUZkYha2nFPuXkbkAKRvpTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f44.google.com (mail-bk0-f44.google.com
 [209.85.214.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 24A51265730
 for <alsa-devel@alsa-project.org>; Sat,  9 Nov 2013 01:41:15 +0100 (CET)
Received: by mail-bk0-f44.google.com with SMTP id mx12so60776bkb.17
 for <alsa-devel@alsa-project.org>; Fri, 08 Nov 2013 16:41:14 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de, grant.likely@linaro.org, rob.herring@calxeda.com, wfp5p@virginia.edu, mpa@pengutronix.de
Cc: yongjun_wei@trendmicro.com.cn, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

platform_set_drvdata(op, pdata) in pcm030_fabric_probe()
will be overwrited when calling snd_soc_register_card(card),
but cm030_fabric_remove() use drvdata as a type of struct
pcm030_audio_data, so we should move platform_set_drvdata()
below snd_soc_register_card() call.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 sound/soc/fsl/pcm030-audio-fabric.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/pcm030-audio-fabric.c b/sound/soc/fsl/pcm030-audio-fabric.c
index eb43738..3665f61 100644
--- a/sound/soc/fsl/pcm030-audio-fabric.c
+++ b/sound/soc/fsl/pcm030-audio-fabric.c
@@ -69,7 +69,6 @@ static int pcm030_fabric_probe(struct platform_device *op)
 		return -ENOMEM;
 
 	card->dev = &op->dev;
-	platform_set_drvdata(op, pdata);
 
 	pdata->card = card;
 
@@ -98,6 +97,8 @@ static int pcm030_fabric_probe(struct platform_device *op)
 	if (ret)
 		dev_err(&op->dev, "snd_soc_register_card() failed: %d\n", ret);
 
+	platform_set_drvdata(op, pdata);
+
 	return ret;
 }
 
