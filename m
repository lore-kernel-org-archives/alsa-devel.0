From: Bo Shen <voice.shen@atmel.com>
Subject: [PATCH] atmel/ac97c: correct the unexpected behavior
	when using uninitial value for reset pin
Date: Fri, 11 May 2012 17:39:28 +0800
Message-ID: <1336729168-20562-1-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sjogate2.atmel.com (newsmtp5.atmel.com [204.2.163.5])
	by alsa0.perex.cz (Postfix) with ESMTP id AA0D810BB66
	for <alsa-devel@alsa-project.org>;
	Fri, 11 May 2012 11:40:15 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, jm.lin@atmel.com, nicolas.ferre@atmel.com, linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, josh.wu@atmel.com, Bo Shen <voice.shen@atmel.com>, plagnioj@jcrosoft.com
List-Id: alsa-devel@alsa-project.org

When pdata->reset_pin is passed with a negative value (means gpio
is invalid), then chip->reset_pin will not be assigned to a vaule,
it will use default value 0. This will cause unexpected behavior.

So, add this patch to correct.

Signed-off-by: Bo Shen <voice.shen@atmel.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 sound/atmel/ac97c.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/atmel/ac97c.c b/sound/atmel/ac97c.c
index 115313e..f5ded64 100644
--- a/sound/atmel/ac97c.c
+++ b/sound/atmel/ac97c.c
@@ -991,6 +991,8 @@ static int __devinit atmel_ac97c_probe(struct platform_device *pdev)
 			gpio_direction_output(pdata->reset_pin, 1);
 			chip->reset_pin = pdata->reset_pin;
 		}
+	} else {
+		chip->reset_pin = -EINVAL;
 	}
 
 	snd_card_set_dev(card, &pdev->dev);
-- 
1.7.10
