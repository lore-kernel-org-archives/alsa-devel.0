From: "Oskar Schirmer" <oskar@scara.com>
Subject: [PATCH] ASoC: fsl: imx-pcm-fiq: remove bogus period
	delta calculation
Date: 5 Nov 2013 12:13:54 +0000
Message-ID: <1383653634-13691-1-git-send-email-oskar@scara.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from skyrme.org (skyrme.org [193.175.80.135])
 by alsa0.perex.cz (Postfix) with ESMTP id 8B7C026518A
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2013 13:13:57 +0100 (CET)
Received: from p4ff18a93.dip0.t-ipconnect.de ([79.241.138.147]
 helo=curry.scara.com)
 by skyrme.org with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.63) (envelope-from <oskar@curry.scara.com>)
 id 1VdfW9-0004O0-Qh
 for alsa-devel@alsa-project.org; Tue, 05 Nov 2013 12:13:58 +0000
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
Cc: alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Oskar Schirmer <oskar@scara.com>
List-Id: alsa-devel@alsa-project.org

Originally snd_hrtimer_callback() used iprtd->period_time for
some jiffies based estimation to determine the right moment
to call snd_pcm_period_elapsed(). As timer drifts may well be a
problem, this was changed in commit b4e82b5b785670b6 to be based
on buffer transmission progress, using iprtd->offset and
runtime->buffer_size to calculate the amount of data since last
period had elapsed.

Unfortunately, iprtd->offset counts in bytes, while
runtime->buffer_size counts frames, so adding these to find some
delta is like comparing apples and oranges, and eventually results
in negative delta values every now and then. This is no big harm,
because it simply causes snd_pcm_period_elapsed() being called
more often than necessary, as negative delta is taken for a
large unsigned value by implicit conversion rule.
Nonetheless, the calculation is broken, so one would replace
the runtime->buffer_size by its equivalent in bytes.

But then, there are chances snd_pcm_period_elapsed() is called
late, because calculating the moment for the elapsed period
into delta is based against the iprtd->last_offset, which is not
necessarily the first byte of the period in question, but some
random byte which the FIQ handler left us with in r8/r9 by
accident. Again, negative impact is low, as there are plenty of
periods already prefilled with data, and snd_pcm_period_elapsed()
will probably be called latest when the following period is
reached. However, the calculation is conceptually broken, and we
are best off removing the clever stuff altogether.

snd_pcm_period_elapsed() is now simply called once everytime
snd_hrtimer_callback() is run, which may not be most accurate,
but at least this way we are quite sure we dont miss an end of
period. There is not much extra effort wasted by superfluous
calls to snd_pcm_period_elapsed(), as the timer frequency
closely matches the period size anyway.

Signed-off-by: Oskar Schirmer <oskar@scara.com>
---
 sound/soc/fsl/imx-pcm-fiq.c |   21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/sound/soc/fsl/imx-pcm-fiq.c b/sound/soc/fsl/imx-pcm-fiq.c
index 34043c5..94720a6 100644
--- a/sound/soc/fsl/imx-pcm-fiq.c
+++ b/sound/soc/fsl/imx-pcm-fiq.c
@@ -39,8 +39,6 @@ struct imx_pcm_runtime_data {
 	unsigned int period;
 	int periods;
 	unsigned long offset;
-	unsigned long last_offset;
-	unsigned long size;
 	struct hrtimer hrt;
 	int poll_time_ns;
 	struct snd_pcm_substream *substream;
@@ -54,7 +52,6 @@ static enum hrtimer_restart snd_hrtimer_callback(struct hrtimer *hrt)
 	struct snd_pcm_substream *substream = iprtd->substream;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct pt_regs regs;
-	unsigned long delta;
 
 	if (!atomic_read(&iprtd->running))
 		return HRTIMER_NORESTART;
@@ -66,19 +63,7 @@ static enum hrtimer_restart snd_hrtimer_callback(struct hrtimer *hrt)
 	else
 		iprtd->offset = regs.ARM_r9 & 0xffff;
 
-	/* How much data have we transferred since the last period report? */
-	if (iprtd->offset >= iprtd->last_offset)
-		delta = iprtd->offset - iprtd->last_offset;
-	else
-		delta = runtime->buffer_size + iprtd->offset
-			- iprtd->last_offset;
-
-	/* If we've transferred at least a period then report it and
-	 * reset our poll time */
-	if (delta >= iprtd->period) {
-		snd_pcm_period_elapsed(substream);
-		iprtd->last_offset = iprtd->offset;
-	}
+	snd_pcm_period_elapsed(substream);
 
 	hrtimer_forward_now(hrt, ns_to_ktime(iprtd->poll_time_ns));
 
@@ -95,11 +80,9 @@ static int snd_imx_pcm_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct imx_pcm_runtime_data *iprtd = runtime->private_data;
 
-	iprtd->size = params_buffer_bytes(params);
 	iprtd->periods = params_periods(params);
-	iprtd->period = params_period_bytes(params) ;
+	iprtd->period = params_period_bytes(params);
 	iprtd->offset = 0;
-	iprtd->last_offset = 0;
 	iprtd->poll_time_ns = 1000000000 / params_rate(params) *
 				params_period_size(params);
 	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
-- 
1.7.9.5
