From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 2/4] ASoC: wm8753: Use power efficient workqueue
Date: Thu, 18 Jul 2013 22:57:16 +0100
Message-ID: <1374184638-10691-2-git-send-email-broonie@kernel.org>
References: <1374184638-10691-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F11D2655FD
 for <alsa-devel@alsa-project.org>; Thu, 18 Jul 2013 23:57:25 +0200 (CEST)
In-Reply-To: <1374184638-10691-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

The work used to allow the capcitors to ramp is not performance sensitive
so let  the scheduler run it wherever is most efficient rather than in a
per CPU workqueue by using the system power efficient workqueue.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/wm8753.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index 0a4ab4c..d96ebf5 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -1456,8 +1456,9 @@ static int wm8753_resume(struct snd_soc_codec *codec)
 	if (codec->dapm.suspend_bias_level == SND_SOC_BIAS_ON) {
 		wm8753_set_bias_level(codec, SND_SOC_BIAS_PREPARE);
 		codec->dapm.bias_level = SND_SOC_BIAS_ON;
-		schedule_delayed_work(&codec->dapm.delayed_work,
-			msecs_to_jiffies(caps_charge));
+		queue_delayed_work(system_power_efficient_wq,
+				   &codec->dapm.delayed_work,
+				   msecs_to_jiffies(caps_charge));
 	}
 
 	return 0;
-- 
1.8.3.2
