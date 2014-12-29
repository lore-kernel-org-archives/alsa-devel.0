From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/3] ALSA: Fix handling of multiple msbits
	constraints on the same runtime
Date: Mon, 29 Dec 2014 18:43:36 +0100
Message-ID: <1419875018-30812-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-180.synserver.de (smtp-out-181.synserver.de
 [212.40.185.181])
 by alsa0.perex.cz (Postfix) with ESMTP id E9C95261531
 for <alsa-devel@alsa-project.org>; Mon, 29 Dec 2014 18:43:42 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

If the sound card is made up of discrete components, each with their own
driver (e.g. like in the ASoC case), we might end up with multiple msbits
constraint rules installed. Currently this will result in msbits being set
to whatever the last rule set it to.

This patch updates the behavior of the rule to choose the minimum (other
than zero) of all the installed rules.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/core/pcm_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index ec9e786..b0c1535 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -1300,7 +1300,7 @@ static int snd_pcm_hw_rule_msbits(struct snd_pcm_hw_params *params,
 	unsigned int msbits = l >> 16;
 	struct snd_interval *i = hw_param_interval(params, SNDRV_PCM_HW_PARAM_SAMPLE_BITS);
 	if (snd_interval_single(i) && snd_interval_value(i) == width)
-		params->msbits = msbits;
+		params->msbits = min_not_zero(params->msbits, msbits);
 	return 0;
 }
 
-- 
1.8.0
