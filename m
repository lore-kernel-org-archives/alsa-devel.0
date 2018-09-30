From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: firewire-lib: add PCM rules to obsolete
	PCM constraints based on LCM of SYT_INTERVAL
Date: Mon,  1 Oct 2018 04:11:49 +0900
Message-ID: <20180930191149.32225-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com
 [209.85.210.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 94F27267842
 for <alsa-devel@alsa-project.org>; Sun, 30 Sep 2018 21:12:01 +0200 (CEST)
Received: by mail-pf1-f195.google.com with SMTP id m77-v6so7602076pfi.8
 for <alsa-devel@alsa-project.org>; Sun, 30 Sep 2018 12:12:01 -0700 (PDT)
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
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

In blocking mode of IEC 61883-1/6, when one isochronous packet includes
data for events, the data is for the same number of events as
SYT_INTERVAL decided according to sampling transmission frequency (SFC).

IEC 61883-1/6 engine of ALSA firewire stack applies constraints of
period and buffer size of PCM intermediate buffer of PCM substream.
At present, this constraint is designed to round the size up/down to
32 frames. This value comes from the least common multiple (LCM) of
SYT_INTERVAL. Although this looks to work well, in lower sampling
rate, applications are not allowed to set size of period quite near
period time constraint (at present 5 msec per period).

This commit adds PCM rules for period/buffer size and rate to obsoletes
the constraints based on LCM.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 78 +++++++++++++++++++++++++++++++----
 1 file changed, 71 insertions(+), 7 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index cb9acfe60f6a..fcd965f1d69e 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -140,6 +140,59 @@ const unsigned int amdtp_rate_table[CIP_SFC_COUNT] = {
 };
 EXPORT_SYMBOL(amdtp_rate_table);
 
+static int apply_constraint_to_size(struct snd_pcm_hw_params *params,
+				    struct snd_pcm_hw_rule *rule)
+{
+	struct snd_interval *s = hw_param_interval(params, rule->var);
+	const struct snd_interval *r =
+		hw_param_interval_c(params, SNDRV_PCM_HW_PARAM_RATE);
+	struct snd_interval t = {
+		.min = s->min, .max = s->max, .integer = 1,
+	};
+	int i;
+
+	for (i = 0; i < CIP_SFC_COUNT; ++i) {
+		unsigned int rate = amdtp_rate_table[i];
+		unsigned int step = amdtp_syt_intervals[i];
+
+		if (!snd_interval_test(r, rate))
+			continue;
+
+		t.min = roundup(t.min, step);
+		t.max = rounddown(t.max, step);
+	}
+
+	if (snd_interval_checkempty(&t))
+		return -EINVAL;
+
+	return snd_interval_refine(s, &t);
+}
+
+static int apply_constraint_to_rate(struct snd_pcm_hw_params *params,
+				    struct snd_pcm_hw_rule *rule)
+{
+	struct snd_interval *r =
+			hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE);
+	const struct snd_interval *s = hw_param_interval_c(params, rule->deps[0]);
+	struct snd_interval t = {
+		.min = UINT_MAX, .max = 0, .integer = 1,
+	};
+	int i;
+
+	for (i = 0; i < CIP_SFC_COUNT; ++i) {
+		unsigned int step = amdtp_syt_intervals[i];
+		unsigned int rate = amdtp_rate_table[i];
+
+		if (s->min % step || s->max % step)
+			continue;
+
+		t.min = min(t.min, rate);
+		t.max = max(t.max, rate);
+	}
+
+	return snd_interval_refine(r, &t);
+}
+
 /**
  * amdtp_stream_add_pcm_hw_constraints - add hw constraints for PCM substream
  * @s:		the AMDTP stream, which must be initialized.
@@ -194,16 +247,27 @@ int amdtp_stream_add_pcm_hw_constraints(struct amdtp_stream *s,
 	 * number equals to SYT_INTERVAL. So the number is 8, 16 or 32,
 	 * depending on its sampling rate. For accurate period interrupt, it's
 	 * preferrable to align period/buffer sizes to current SYT_INTERVAL.
-	 *
-	 * TODO: These constraints can be improved with proper rules.
-	 * Currently apply LCM of SYT_INTERVALs.
 	 */
-	err = snd_pcm_hw_constraint_step(runtime, 0,
-					 SNDRV_PCM_HW_PARAM_PERIOD_SIZE, 32);
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
+				  apply_constraint_to_size, NULL,
+				  SNDRV_PCM_HW_PARAM_RATE, -1);
+	if (err < 0)
+		goto end;
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
+				  apply_constraint_to_rate, NULL,
+				  SNDRV_PCM_HW_PARAM_PERIOD_SIZE, -1);
+	if (err < 0)
+		goto end;
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_SIZE,
+				  apply_constraint_to_size, NULL,
+				  SNDRV_PCM_HW_PARAM_RATE, -1);
+	if (err < 0)
+		goto end;
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
+				  apply_constraint_to_rate, NULL,
+				  SNDRV_PCM_HW_PARAM_BUFFER_SIZE, -1);
 	if (err < 0)
 		goto end;
-	err = snd_pcm_hw_constraint_step(runtime, 0,
-					 SNDRV_PCM_HW_PARAM_BUFFER_SIZE, 32);
 end:
 	return err;
 }
-- 
2.17.1
