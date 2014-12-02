From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Subject: [PATCH] sound: pci: cmipci.c: Cleaning up function
	that are not used anywhere
Date: Wed,  3 Dec 2014 00:12:55 +0100
Message-ID: <1417561975-27627-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f52.google.com (mail-wg0-f52.google.com [74.125.82.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 71E752603A5
 for <alsa-devel@alsa-project.org>; Wed,  3 Dec 2014 00:10:17 +0100 (CET)
Received: by mail-wg0-f52.google.com with SMTP id a1so18435676wgh.39
 for <alsa-devel@alsa-project.org>; Tue, 02 Dec 2014 15:10:17 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Benoit Taine <benoit.taine@lip6.fr>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
List-Id: alsa-devel@alsa-project.org

Remove function snd_cmipci_pll_rmn() that is not used anywhere.

This was partially found by using a static code analysis program called cppcheck.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 sound/pci/cmipci.c |   41 -----------------------------------------
 1 file changed, 41 deletions(-)

diff --git a/sound/pci/cmipci.c b/sound/pci/cmipci.c
index 85ed403..e33edae 100644
--- a/sound/pci/cmipci.c
+++ b/sound/pci/cmipci.c
@@ -615,47 +615,6 @@ static unsigned int snd_cmipci_rate_freq(unsigned int rate)
 
 #ifdef USE_VAR48KRATE
 /*
- * Determine PLL values for frequency setup, maybe the CMI8338 (CMI8738???)
- * does it this way .. maybe not.  Never get any information from C-Media about
- * that <werner@suse.de>.
- */
-static int snd_cmipci_pll_rmn(unsigned int rate, unsigned int adcmult, int *r, int *m, int *n)
-{
-	unsigned int delta, tolerance;
-	int xm, xn, xr;
-
-	for (*r = 0; rate < CM_MAXIMUM_RATE/adcmult; *r += (1<<5))
-		rate <<= 1;
-	*n = -1;
-	if (*r > 0xff)
-		goto out;
-	tolerance = rate*CM_TOLERANCE_RATE;
-
-	for (xn = (1+2); xn < (0x1f+2); xn++) {
-		for (xm = (1+2); xm < (0xff+2); xm++) {
-			xr = ((CM_REFFREQ_XIN/adcmult) * xm) / xn;
-
-			if (xr < rate)
-				delta = rate - xr;
-			else
-				delta = xr - rate;
-
-			/*
-			 * If we found one, remember this,
-			 * and try to find a closer one
-			 */
-			if (delta < tolerance) {
-				tolerance = delta;
-				*m = xm - 2;
-				*n = xn - 2;
-			}
-		}
-	}
-out:
-	return (*n > -1);
-}
-
-/*
  * Program pll register bits, I assume that the 8 registers 0xf8 up to 0xff
  * are mapped onto the 8 ADC/DAC sampling frequency which can be chosen
  * at the register CM_REG_FUNCTRL1 (0x04).
-- 
1.7.10.4
