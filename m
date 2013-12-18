From: Bo Shen <voice.shen@atmel.com>
Subject: [RESEND PATCH v2 2/2] ASoC: atmel: sam9x5_wm8731:
	remove platform_set_drvdata
Date: Wed, 18 Dec 2013 14:55:41 +0800
Message-ID: <1387349741-13121-1-git-send-email-voice.shen@atmel.com>
References: <1385546710-11308-2-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sjogate2.atmel.com (newsmtp5.atmel.com [204.2.163.5])
 by alsa0.perex.cz (Postfix) with ESMTP id 35E032615F2
 for <alsa-devel@alsa-project.org>; Wed, 18 Dec 2013 07:56:49 +0100 (CET)
In-Reply-To: <1385546710-11308-2-git-send-email-voice.shen@atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, richard.genoud@gmail.com, nicolas.ferre@atmel.com, linux-sound@vger.kernel.org, Bo Shen <voice.shen@atmel.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

When call snd_soc_register_card, it will set driver data to this
device through dev_set_drvdata, then in driver, no need to call
platform_set_drvdata again, so remove it.

Signed-off-by: Bo Shen <voice.shen@atmel.com>
Tested-by: Richard Genoud <richard.genoud@gmail.com>
---
Hi Mark,
   This patch is not in your tree, so I resend it.

 sound/soc/atmel/sam9x5_wm8731.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/atmel/sam9x5_wm8731.c b/sound/soc/atmel/sam9x5_wm8731.c
index 7d6a905..3188036 100644
--- a/sound/soc/atmel/sam9x5_wm8731.c
+++ b/sound/soc/atmel/sam9x5_wm8731.c
@@ -155,8 +155,6 @@ static int sam9x5_wm8731_driver_probe(struct platform_device *pdev)
 	of_node_put(codec_np);
 	of_node_put(cpu_np);
 
-	platform_set_drvdata(pdev, card);
-
 	ret = snd_soc_register_card(card);
 	if (ret) {
 		dev_err(&pdev->dev,
-- 
1.7.9.5
