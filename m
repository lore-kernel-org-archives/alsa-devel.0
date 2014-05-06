From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2] ASoC: dapm: Fix SUSPEND -> OFF bias sequence
Date: Tue,  6 May 2014 10:32:15 +0200
Message-ID: <1399365135-26877-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-167.synserver.de (smtp-out-016.synserver.de
 [212.40.185.16])
 by alsa0.perex.cz (Postfix) with ESMTP id CC2C226072A
 for <alsa-devel@alsa-project.org>; Tue,  6 May 2014 10:32:24 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Currently when the DAPM context bias level is SUSPEND and the target bias level
is OFF dapm_pre_sequence_async() will first transition to PREPARE and
dapm_post_sequence_async() will then transition back from PREPARE to STANDBY and
then to OFF.

This patch makes sure that dapm_pre_sequence_async() only transitions to PREPARE
when either going to ON or away from ON. This avoids the extra unnecessary
transitions.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
Given that SUSPEND -> OFF transitions are rather rare and the code will still
work correctly (but inefficent) without this patch, the patch probably does not
need to go into stable.

Changes since v1:
	* Change indention
---
 sound/soc/soc-dapm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 5d54dfc..bfc46a9 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1549,8 +1549,11 @@ static void dapm_pre_sequence_async(void *data, async_cookie_t cookie)
 				"ASoC: Failed to turn on bias: %d\n", ret);
 	}
 
-	/* Prepare for a STADDBY->ON or ON->STANDBY transition */
-	if (d->bias_level != d->target_bias_level) {
+	/* Prepare for a transition to ON or away from ON */
+	if ((d->target_bias_level == SND_SOC_BIAS_ON &&
+	     d->bias_level != SND_SOC_BIAS_ON) ||
+	    (d->target_bias_level != SND_SOC_BIAS_ON &&
+	     d->bias_level == SND_SOC_BIAS_ON)) {
 		ret = snd_soc_dapm_set_bias_level(d, SND_SOC_BIAS_PREPARE);
 		if (ret != 0)
 			dev_err(d->dev,
-- 
1.8.0
