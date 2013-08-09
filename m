From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: compress: Use power efficient workqueue
Date: Fri,  9 Aug 2013 18:22:11 +0100
Message-ID: <1376068931-15520-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id E276B2657EA
 for <alsa-devel@alsa-project.org>; Fri,  9 Aug 2013 19:22:28 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

There is no need for the power down work to be done on a per CPU workqueue
especially considering the fairly long delay before powerdown.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/soc-compress.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index d220150..53c9ecd 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -149,8 +149,9 @@ static int soc_compr_free(struct snd_compr_stream *cstream)
 					SND_SOC_DAPM_STREAM_STOP);
 		} else {
 			rtd->pop_wait = 1;
-			schedule_delayed_work(&rtd->delayed_work,
-				msecs_to_jiffies(rtd->pmdown_time));
+			queue_delayed_work(system_power_efficient_wq,
+					   &rtd->delayed_work,
+					   msecs_to_jiffies(rtd->pmdown_time));
 		}
 	} else {
 		/* capture streams can be powered down now */
-- 
1.8.4.rc1
