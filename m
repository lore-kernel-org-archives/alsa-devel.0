From: Joachim  Eastwood <manabian@gmail.com>
Subject: [PATCH] asoc atmel_ssc: Don't try to free ssc if
	request failed
Date: Wed, 1 Jun 2011 23:59:10 +0200
Message-ID: <BANLkTin=o135Ayy_yKiJ3JUs91Y_k9ciVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
	[209.85.220.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 7BEF52457E
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Jun 2011 23:59:13 +0200 (CEST)
Received: by vxi40 with SMTP id 40so247290vxi.38
	for <alsa-devel@alsa-project.org>; Wed, 01 Jun 2011 14:59:10 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, sedji.gaouaou@atmel.com, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Hello,

Patch below fixes a segmentation fault in atmel_ssc_dai if ssc_request() fails.

We should only call ssc_free() when ssc_request() succeeds or bad
things will happen.

Signed-off-by: Joachim Eastwood <joachim.eastwood@jotron.com>
---
 sound/soc/atmel/atmel_ssc_dai.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index 7fbfa05..eda955b 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -848,9 +848,10 @@ int atmel_ssc_set_audio(int ssc_id)
 	if (IS_ERR(ssc))
 		pr_warn("Unable to parent ASoC SSC DAI on SSC: %ld\n",
 			PTR_ERR(ssc));
-	else
+	else {
 		ssc_pdev->dev.parent = &(ssc->pdev->dev);
-	ssc_free(ssc);
+		ssc_free(ssc);
+	}

 	ret = platform_device_add(ssc_pdev);
 	if (ret < 0)
-- 
1.7.5.2
