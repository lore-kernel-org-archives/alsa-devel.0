From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: firewire-lib: fix insufficient PCM rule
	for period/buffer size
Date: Tue, 30 Oct 2018 15:31:15 +0900
Message-ID: <20181030063115.24468-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com
 [209.85.215.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 180342675B8
 for <alsa-devel@alsa-project.org>; Tue, 30 Oct 2018 07:31:25 +0100 (CET)
Received: by mail-pg1-f196.google.com with SMTP id 32-v6so5127293pgu.2
 for <alsa-devel@alsa-project.org>; Mon, 29 Oct 2018 23:31:25 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

In a former commit, PCM constraint based on LCM of SYT_INTERVAL was
obsoleted with PCM rule. However, the new PCM rule brings -EINVAL in
some cases that max/min values of size of buffer/period is not
multiples of one of values of SYT_INTERVAL. For example, pulseaudio
always fail to configure PCM substream.

This commit changes strategy for the PCM rule. Although the buggy rules
had a single dependency (rate from period, period from rate, rate from
buffer, buffer from rate), a revised rule has double dependencies
(period from period/rate, buffer from buffer/rate). A step of value is
calculated with table of SYT_INTERVAL and list of available rates. This
prevents interval template which brings -EINVAL to a call of
snd_interval_refine().

Fixes: 5950229582bc('ALSA: firewire-lib: add PCM rules to obsolete PCM constraints based on LCM of SYT_INTERVAL')
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 57 ++++++-----------------------------
 1 file changed, 9 insertions(+), 48 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index fcd965f1d69e..9be76c808fcc 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -146,53 +146,22 @@ static int apply_constraint_to_size(struct snd_pcm_hw_params *params,
 	struct snd_interval *s = hw_param_interval(params, rule->var);
 	const struct snd_interval *r =
 		hw_param_interval_c(params, SNDRV_PCM_HW_PARAM_RATE);
-	struct snd_interval t = {
-		.min = s->min, .max = s->max, .integer = 1,
-	};
+	struct snd_interval t = {0};
+	unsigned int step = 0;
 	int i;
 
 	for (i = 0; i < CIP_SFC_COUNT; ++i) {
-		unsigned int rate = amdtp_rate_table[i];
-		unsigned int step = amdtp_syt_intervals[i];
-
-		if (!snd_interval_test(r, rate))
-			continue;
-
-		t.min = roundup(t.min, step);
-		t.max = rounddown(t.max, step);
+		if (snd_interval_test(r, amdtp_rate_table[i]))
+			step = max(step, amdtp_syt_intervals[i]);
 	}
 
-	if (snd_interval_checkempty(&t))
-		return -EINVAL;
+	t.min = roundup(s->min, step);
+	t.max = rounddown(s->max, step);
+	t.integer = 1;
 
 	return snd_interval_refine(s, &t);
 }
 
-static int apply_constraint_to_rate(struct snd_pcm_hw_params *params,
-				    struct snd_pcm_hw_rule *rule)
-{
-	struct snd_interval *r =
-			hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE);
-	const struct snd_interval *s = hw_param_interval_c(params, rule->deps[0]);
-	struct snd_interval t = {
-		.min = UINT_MAX, .max = 0, .integer = 1,
-	};
-	int i;
-
-	for (i = 0; i < CIP_SFC_COUNT; ++i) {
-		unsigned int step = amdtp_syt_intervals[i];
-		unsigned int rate = amdtp_rate_table[i];
-
-		if (s->min % step || s->max % step)
-			continue;
-
-		t.min = min(t.min, rate);
-		t.max = max(t.max, rate);
-	}
-
-	return snd_interval_refine(r, &t);
-}
-
 /**
  * amdtp_stream_add_pcm_hw_constraints - add hw constraints for PCM substream
  * @s:		the AMDTP stream, which must be initialized.
@@ -250,24 +219,16 @@ int amdtp_stream_add_pcm_hw_constraints(struct amdtp_stream *s,
 	 */
 	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
 				  apply_constraint_to_size, NULL,
+				  SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
 				  SNDRV_PCM_HW_PARAM_RATE, -1);
 	if (err < 0)
 		goto end;
-	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
-				  apply_constraint_to_rate, NULL,
-				  SNDRV_PCM_HW_PARAM_PERIOD_SIZE, -1);
-	if (err < 0)
-		goto end;
 	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_SIZE,
 				  apply_constraint_to_size, NULL,
+				  SNDRV_PCM_HW_PARAM_BUFFER_SIZE,
 				  SNDRV_PCM_HW_PARAM_RATE, -1);
 	if (err < 0)
 		goto end;
-	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
-				  apply_constraint_to_rate, NULL,
-				  SNDRV_PCM_HW_PARAM_BUFFER_SIZE, -1);
-	if (err < 0)
-		goto end;
 end:
 	return err;
 }
-- 
2.19.1
