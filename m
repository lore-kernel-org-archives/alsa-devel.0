From: Joris van Rantwijk <jorispubl@xs4all.nl>
Subject: [PATCH] Workaround for misdetected sample rate with
	CM6207
Date: Sat, 14 Feb 2009 22:22:05 +0100
Message-ID: <20090214212205.GA4898@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-vbr9.xs4all.nl (smtp-vbr9.xs4all.nl [194.109.24.29])
	by alsa0.perex.cz (Postfix) with ESMTP id 2D1042441E
	for <alsa-devel@alsa-project.org>; Sat, 14 Feb 2009 22:22:16 +0100 (CET)
Received: from xs2.xs4all.nl (xs2.xs4all.nl [194.109.21.3])
	by smtp-vbr9.xs4all.nl (8.13.8/8.13.8) with ESMTP id n1ELMAPm019766
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <alsa-devel@alsa-project.org>; Sat, 14 Feb 2009 22:22:15 +0100 (CET)
	(envelope-from rjoris@xs4all.nl)
Received: from xs2.xs4all.nl (rjoris@localhost [127.0.0.1])
	by xs2.xs4all.nl (8.13.6/8.13.6) with ESMTP id n1ELMAK1014229
	for <alsa-devel@alsa-project.org>; Sat, 14 Feb 2009 22:22:10 +0100 (CET)
	(envelope-from rjoris@xs4all.nl)
Received: (from rjoris@localhost)
	by xs2.xs4all.nl (8.13.6/8.13.6/Submit) id n1ELM5dW013477
	for alsa-devel@alsa-project.org; Sat, 14 Feb 2009 22:22:05 +0100 (CET)
	(envelope-from rjoris)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Summary: Workaround for misdetected sample rate with CM6207

The CM6207 incorrectly advertises its 96 kHz playback setting as 48 kHz
in its USB device descriptor. This patch extends an existing workaround
in usbaudio.c to also cover the CM6207.

This resolves issue 0004249 in the ALSA bug tracker.

Signed-off by: Joris van Rantwijk <jorispubl@xs4all.nl>

diff -ur linux-2.6.28.4/sound/usb/usbaudio.c linux-2.6.28.4_j/sound/usb/usbaudio.c
--- linux-2.6.28.4/sound/usb/usbaudio.c	2009-02-13 21:45:17.000000000 +0100
+++ linux-2.6.28.4_j/sound/usb/usbaudio.c	2009-02-13 22:00:44.000000000 +0100
@@ -2533,19 +2533,20 @@
 		}
 
 		fp->nr_rates = nr_rates;
-		fp->rate_min = fp->rate_max = combine_triple(&fmt[8]);
+		fp->rate_min = fp->rate_max = 0;
 		for (r = 0, idx = offset + 1; r < nr_rates; r++, idx += 3) {
 			unsigned int rate = combine_triple(&fmt[idx]);
 			/* C-Media CM6501 mislabels its 96 kHz altsetting */
 			if (rate == 48000 && nr_rates == 1 &&
-			    chip->usb_id == USB_ID(0x0d8c, 0x0201) &&
+                            (chip->usb_id == USB_ID(0x0d8c, 0x0201) ||
+                             chip->usb_id == USB_ID(0x0d8c, 0x0102)) &&
 			    fp->altsetting == 5 && fp->maxpacksize == 392)
 				rate = 96000;
 			fp->rate_table[r] = rate;
 			nonzero_rates |= rate;
-			if (rate < fp->rate_min)
+			if (r == 0 || rate < fp->rate_min)
 				fp->rate_min = rate;
-			else if (rate > fp->rate_max)
+			else if (r == 0 || rate > fp->rate_max)
 				fp->rate_max = rate;
 			fp->rates |= snd_pcm_rate_to_rate_bit(rate);
 		}
