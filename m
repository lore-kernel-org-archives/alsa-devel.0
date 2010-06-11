From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH 3/4] ALSA: usb-audio: parse UAC2 sample
 rate ranges correctly
Date: Fri, 11 Jun 2010 17:46:33 +0200
Message-ID: <20100611154633.GG17833@buzzloop.caiaq.de>
References: <20100611151829.GE17833@buzzloop.caiaq.de>
	<1276270462-12901-3-git-send-email-daniel@caiaq.de>
	<s5h8w6linhz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 65F372450C
	for <alsa-devel@alsa-project.org>;
	Fri, 11 Jun 2010 17:46:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h8w6linhz.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alexlee188@gmail.com, alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 11, 2010 at 05:43:04PM +0200, Takashi Iwai wrote:
> At Fri, 11 Jun 2010 17:34:21 +0200,
> Daniel Mack wrote:
> > 
> > +		/*
> > +		 * for ranges with res == 1, we want a continuous sample
> > +		 * rate range, so this function should return 0.
> > +		 */
> > +		if (res == 1) {
> > +			fp->rates = SNDRV_PCM_RATE_CONTINUOUS;
> > +			return 0;
> 
> Missing setup of fp->rate_min and fp->rate_max here?

Gna, not my day. I did that, and of course tested it with a modified
firmware and it worked well.

But appearantly I exported the wrong patch. Sorry.


Daniel


>From 6cefee7ab5168b0875af0aaaa78a0e7b6cce1890 Mon Sep 17 00:00:00 2001
From: Daniel Mack <daniel@caiaq.de>
Date: Fri, 11 Jun 2010 11:32:29 +0200
Subject: [PATCH] ALSA: usb-audio: parse UAC2 sample rate ranges correctly

A device may report its supported sample rates in ranges rather than in
discrete triplets. The code used to only parse the MIN field instead of
properly paying attention to the MAX and RES values.

Also, handle RES values of 1 correctly and announce a continous sample
rate range in this case.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Reported-by: Alex Lee <alexlee188@gmail.com>
---
 sound/usb/format.c |   92 +++++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 74 insertions(+), 18 deletions(-)

diff --git a/sound/usb/format.c b/sound/usb/format.c
index 8eccf17..30364ab 100644
--- a/sound/usb/format.c
+++ b/sound/usb/format.c
@@ -206,6 +206,60 @@ static int parse_audio_format_rates_v1(struct snd_usb_audio *chip, struct audiof
 }
 
 /*
+ * Helper function to walk the array of sample rate triplets reported by
+ * the device. The problem is that we need to parse whole array first to
+ * get to know how many sample rates we have to expect.
+ * Then fp->rate_table can be allocated and filled.
+ */
+static int parse_uac2_sample_rate_range(struct audioformat *fp, int nr_triplets,
+					const unsigned char *data)
+{
+	int i, nr_rates = 0;
+
+	fp->rates = fp->rate_min = fp->rate_max = 0;
+
+	for (i = 0; i < nr_triplets; i++) {
+		int min = combine_quad(&data[2 + 12 * i]);
+		int max = combine_quad(&data[6 + 12 * i]);
+		int res = combine_quad(&data[10 + 12 * i]);
+		int rate;
+
+		if ((max < 0) || (min < 0) || (res < 0) || (max < min))
+			continue;
+
+		/*
+		 * for ranges with res == 1, we announce a continuous sample
+		 * rate range, and this function should return 0 for no further
+		 * parsing.
+		 */
+		if (res == 1) {
+			fp->rate_min = min;
+			fp->rate_max = max;
+			fp->rates = SNDRV_PCM_RATE_CONTINUOUS;
+			return 0;
+		}
+
+		for (rate = min; rate <= max; rate += res) {
+			if (fp->rate_table)
+				fp->rate_table[nr_rates] = rate;
+			if (!fp->rate_min || rate < fp->rate_min)
+				fp->rate_min = rate;
+			if (!fp->rate_max || rate > fp->rate_max)
+				fp->rate_max = rate;
+			fp->rates |= snd_pcm_rate_to_rate_bit(rate);
+
+			nr_rates++;
+
+			/* avoid endless loop */
+			if (res == 0)
+				break;
+		}
+	}
+
+	return nr_rates;
+}
+
+/*
  * parse the format descriptor and stores the possible sample rates
  * on the audioformat table (audio class v2).
  */
@@ -215,7 +269,7 @@ static int parse_audio_format_rates_v2(struct snd_usb_audio *chip,
 {
 	struct usb_device *dev = chip->dev;
 	unsigned char tmp[2], *data;
-	int i, nr_rates, data_size, ret = 0;
+	int nr_triplets, data_size, ret = 0;
 	int clock = snd_usb_clock_find_source(chip, chip->ctrl_intf, fp->clock);
 
 	if (clock < 0) {
@@ -237,8 +291,8 @@ static int parse_audio_format_rates_v2(struct snd_usb_audio *chip,
 		goto err;
 	}
 
-	nr_rates = (tmp[1] << 8) | tmp[0];
-	data_size = 2 + 12 * nr_rates;
+	nr_triplets = (tmp[1] << 8) | tmp[0];
+	data_size = 2 + 12 * nr_triplets;
 	data = kzalloc(data_size, GFP_KERNEL);
 	if (!data) {
 		ret = -ENOMEM;
@@ -259,26 +313,28 @@ static int parse_audio_format_rates_v2(struct snd_usb_audio *chip,
 		goto err_free;
 	}
 
-	fp->rate_table = kmalloc(sizeof(int) * nr_rates, GFP_KERNEL);
+	/* Call the triplet parser, and make sure fp->rate_table is NULL.
+	 * We just use the return value to know how many sample rates we
+	 * will have to deal with. */
+	kfree(fp->rate_table);
+	fp->rate_table = NULL;
+	fp->nr_rates = parse_uac2_sample_rate_range(fp, nr_triplets, data);
+
+	if (fp->nr_rates == 0) {
+		/* SNDRV_PCM_RATE_CONTINUOUS */
+		ret = 0;
+		goto err_free;
+	}
+
+	fp->rate_table = kmalloc(sizeof(int) * fp->nr_rates, GFP_KERNEL);
 	if (!fp->rate_table) {
 		ret = -ENOMEM;
 		goto err_free;
 	}
 
-	fp->nr_rates = 0;
-	fp->rate_min = fp->rate_max = 0;
-
-	for (i = 0; i < nr_rates; i++) {
-		int rate = combine_quad(&data[2 + 12 * i]);
-
-		fp->rate_table[fp->nr_rates] = rate;
-		if (!fp->rate_min || rate < fp->rate_min)
-			fp->rate_min = rate;
-		if (!fp->rate_max || rate > fp->rate_max)
-			fp->rate_max = rate;
-		fp->rates |= snd_pcm_rate_to_rate_bit(rate);
-		fp->nr_rates++;
-	}
+	/* Call the triplet parser again, but this time, fp->rate_table is
+	 * allocated, so the rates will be stored */
+	parse_uac2_sample_rate_range(fp, nr_triplets, data);
 
 err_free:
 	kfree(data);
-- 
1.7.1
