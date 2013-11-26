From: Bo Shen <voice.shen@atmel.com>
Subject: [PATCH 1/2] ASoC: atmel: sam9x5_wm8731: fix oops when
	unload module
Date: Tue, 26 Nov 2013 12:17:51 +0800
Message-ID: <1385439472-23352-1-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sjogate2.atmel.com (newsmtp5.atmel.com [204.2.163.5])
 by alsa0.perex.cz (Postfix) with ESMTP id A0AD3260818
 for <alsa-devel@alsa-project.org>; Tue, 26 Nov 2013 05:19:54 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, richard.genoud@gmail.com, nicolas.ferre@atmel.com, linux-sound@vger.kernel.org, Bo Shen <voice.shen@atmel.com>, plagnioj@jcrosoft.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

As the priv is not assigned to card->drvdata, it is NULL, so when
unload module, it will cause NULL pointer oops.
Assign priv to card->drvdata to fix this issue.

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
 sound/soc/atmel/sam9x5_wm8731.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/atmel/sam9x5_wm8731.c b/sound/soc/atmel/sam9x5_wm8731.c
index 992ae38..6dc33ac 100644
--- a/sound/soc/atmel/sam9x5_wm8731.c
+++ b/sound/soc/atmel/sam9x5_wm8731.c
@@ -99,6 +99,7 @@ static int sam9x5_wm8731_driver_probe(struct platform_device *pdev)
 
 	card->dev = &pdev->dev;
 	card->owner = THIS_MODULE;
+	card->drvdata = priv;
 	card->dai_link = dai;
 	card->num_links = 1;
 	card->dapm_widgets = sam9x5_dapm_widgets;
-- 
1.7.9.5
