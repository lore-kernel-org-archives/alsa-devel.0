From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: wm5102: Initialize dac_comp_lock mutex
Date: Fri,  5 Dec 2014 20:08:39 +0000
Message-ID: <1417810119-7772-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A396C2605A1
 for <alsa-devel@alsa-project.org>; Fri,  5 Dec 2014 21:09:43 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Commit d74bcaaeb6682 (ASoC: wm5102: Move ultrasonic response settings
lock to the driver level) created a driver local mutex for protecting
the ultrasonic response settings but neglected to initialize that mutex,
causing loud complaints from lockep and potential runtime failures. Fix
this by initializing the mutex.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm5102.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index 8c99b7cf47e0..f439ae052128 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -1900,6 +1900,8 @@ static int wm5102_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	platform_set_drvdata(pdev, wm5102);
 
+	mutex_init(&arizona->dac_comp_lock);
+
 	wm5102->core.arizona = arizona;
 	wm5102->core.num_inputs = 6;
 
-- 
2.1.3
