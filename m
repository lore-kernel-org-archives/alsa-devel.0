From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/3] ASoC: wm8994: Cancel delayed work for
	jackdet unconditionally
Date: Tue, 26 Feb 2013 17:15:31 +0000
Message-ID: <1361898934-615-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1361898934-615-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6C9922652A7
 for <alsa-devel@alsa-project.org>; Tue, 26 Feb 2013 18:15:40 +0100 (CET)
In-Reply-To: <1361898934-615-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

This avoids a potential deadlock with cancellation and races with
completion on insertion.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index b66435f..d6e994d 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -3578,6 +3578,8 @@ static irqreturn_t wm1811_jackdet_irq(int irq, void *data)
 	int reg, delay;
 	bool present;
 
+	cancel_delayed_work_sync(&wm8994->mic_work);
+
 	pm_runtime_get_sync(codec->dev);
 
 	mutex_lock(&wm8994->accdet_lock);
@@ -3612,8 +3614,6 @@ static irqreturn_t wm1811_jackdet_irq(int irq, void *data)
 	} else {
 		dev_dbg(codec->dev, "Jack not detected\n");
 
-		cancel_delayed_work_sync(&wm8994->mic_work);
-
 		snd_soc_update_bits(codec, WM8958_MICBIAS2,
 				    WM8958_MICB2_DISCH, WM8958_MICB2_DISCH);
 
-- 
1.7.10.4
