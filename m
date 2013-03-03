From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH RFT] ASoC: wm8350: Use jiffies rather than
 msecs in schedule_delayed_work()
Date: Sun, 03 Mar 2013 16:20:50 +0800
Message-ID: <1362298850.9569.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f46.google.com (mail-pb0-f46.google.com
 [209.85.160.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 8601D2616C9
 for <alsa-devel@alsa-project.org>; Sun,  3 Mar 2013 09:21:03 +0100 (CET)
Received: by mail-pb0-f46.google.com with SMTP id uo15so2529114pbc.19
 for <alsa-devel@alsa-project.org>; Sun, 03 Mar 2013 00:21:02 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The delay parameter of schedule_delayed_work() is number of jiffies to wait
rather than miliseconds.

Before commit 6d3c26bcb "ASoC: Use delayed work to debounce WM8350 jack IRQs",
the debounce time is 200 miliseconds in wm8350_hp_jack_handler().
So I think this is a bug when convert to use delayed work.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/wm8350.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8350.c b/sound/soc/codecs/wm8350.c
index ec0efc1..0e8b3aa 100644
--- a/sound/soc/codecs/wm8350.c
+++ b/sound/soc/codecs/wm8350.c
@@ -1301,7 +1301,7 @@ static irqreturn_t wm8350_hpl_jack_handler(int irq, void *data)
 	if (device_may_wakeup(wm8350->dev))
 		pm_wakeup_event(wm8350->dev, 250);
 
-	schedule_delayed_work(&priv->hpl.work, 200);
+	schedule_delayed_work(&priv->hpl.work, msecs_to_jiffies(200));
 
 	return IRQ_HANDLED;
 }
@@ -1318,7 +1318,7 @@ static irqreturn_t wm8350_hpr_jack_handler(int irq, void *data)
 	if (device_may_wakeup(wm8350->dev))
 		pm_wakeup_event(wm8350->dev, 250);
 
-	schedule_delayed_work(&priv->hpr.work, 200);
+	schedule_delayed_work(&priv->hpr.work, msecs_to_jiffies(200));
 
 	return IRQ_HANDLED;
 }
-- 
1.7.9.5
