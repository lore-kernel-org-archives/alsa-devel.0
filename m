From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/5] ASoC: wm8994: Avoid leaking pm_runtime
	reference on removed jack race
Date: Thu, 30 May 2013 13:42:28 +0100
Message-ID: <1369917750-7322-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1369917750-7322-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 36F4926517C
 for <alsa-devel@alsa-project.org>; Thu, 30 May 2013 14:42:35 +0200 (CEST)
In-Reply-To: <1369917750-7322-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 7dd5045..365e6f9 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -3906,7 +3906,7 @@ static irqreturn_t wm8958_mic_irq(int irq, void *data)
 				ret);
 		} else if (!(ret & WM1811_JACKDET_LVL)) {
 			dev_dbg(codec->dev, "Ignoring removed jack\n");
-			return IRQ_HANDLED;
+			goto out;
 		}
 	} else if (!(reg & WM8958_MICD_STS)) {
 		snd_soc_jack_report(wm8994->micdet[0].jack, 0,
-- 
1.7.10.4
