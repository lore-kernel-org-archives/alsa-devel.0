From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Use pm_wakeup_event() in WM8962 jack
	detection
Date: Wed,  3 Nov 2010 14:50:18 -0400
Message-ID: <1288810218-30825-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5B71B103834
	for <alsa-devel@alsa-project.org>; Wed,  3 Nov 2010 19:50:16 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Ensure that the system does not suspend while we process a WM8962 jack
event by using pm_wakeup_event() to block the suspend while we're waiting
for the jack to settle. Use a slightly longer timeout than the jack waits
to allow for other stuff to take over and delays in scheduling.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8962.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 894d0cd..2eaf9bb 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -3353,6 +3353,8 @@ static irqreturn_t wm8962_irq(int irq, void *data)
 	if (active & (WM8962_MICSCD_EINT | WM8962_MICD_EINT)) {
 		dev_dbg(codec->dev, "Microphone event detected\n");
 
+		pm_wakeup_event(codec->dev, 300);
+
 		schedule_delayed_work(&wm8962->mic_work,
 				      msecs_to_jiffies(250));
 	}
-- 
1.7.1
