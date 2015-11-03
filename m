From: Sebastien Jan <sjan@baylibre.com>
Subject: [PATCH] mfd: arizona: Add DT binding for irq_gpio
	property
Date: Tue,  3 Nov 2015 12:20:12 +0100
Message-ID: <1446549612-18221-1-git-send-email-sjan@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f42.google.com (mail-wm0-f42.google.com [74.125.82.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 112012605B0
 for <alsa-devel@alsa-project.org>; Tue,  3 Nov 2015 12:32:11 +0100 (CET)
Received: by wmeg8 with SMTP id g8so81932372wme.0
 for <alsa-devel@alsa-project.org>; Tue, 03 Nov 2015 03:32:10 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Sebastien Jan <sjan@baylibre.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Sebastien Jan <sjan@baylibre.com>
---
 drivers/mfd/arizona-core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mfd/arizona-core.c b/drivers/mfd/arizona-core.c
index 44cfdbb..23a0f93 100644
--- a/drivers/mfd/arizona-core.c
+++ b/drivers/mfd/arizona-core.c
@@ -814,6 +814,11 @@ static int arizona_of_get_core_pdata(struct arizona *arizona)
 		count++;
 	}
 
+	arizona->pdata.irq_gpio = of_get_named_gpio(arizona->dev->of_node,
+							"wlf,irq_gpio", 0);
+	if (arizona->pdata.irq_gpio < 0)
+		arizona->pdata.irq_gpio = 0;
+
 	return 0;
 }
 
-- 
1.9.1
