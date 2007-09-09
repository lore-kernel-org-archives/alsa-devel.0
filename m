From: Rene Herman <rene.herman@gmail.com>
Subject: Re: [PATCH] ad1848 and cs4231 busy loop replacement
Date: Sun, 09 Sep 2007 23:09:29 +0200
Message-ID: <46E46109.5040704@gmail.com>
References: <20070909001208.b2e54c13.krzysztof.h1@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050505080708040509090206"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.tilbu1.nb.home.nl (smtpq1.tilbu1.nb.home.nl
	[213.51.146.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 3006210394C
	for <alsa-devel@alsa-project.org>;
	Sun,  9 Sep 2007 23:16:18 +0200 (CEST)
In-Reply-To: <20070909001208.b2e54c13.krzysztof.h1@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Krzysztof Helt <krzysztof.h1@gmail.com>
Cc: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------050505080708040509090206
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

On 09/09/2007 12:12 AM, Krzysztof Helt wrote:

> This should fix Rene's problem with the timeout message he got in his new
> Aztech driver.
> 
> The problem is that the driver wait for busy bit to go high but it may 
> not happen if the auto-calibration is not set. The result is incorrect 
> debug message (that timeout happened). It is also possible (in theory) to
> get this message in the ad1848-lib on a slow CPU.
> 
> The patch just wait a period around the period needed for the 
> auto-calibration. If there is no auto-calibration set, the driver just 
> loses few miliseconds. This may happen only during driver start as both 
> drivers set auto-calibration. If the auto-calibration is set we give CPU
> more time to do something else then move to next waiting loop (for the 
> auto-calibration bit to get cleared).

Yes, thank you, this appears to be a proper analysis. Unfortunately, I don't 
believe the patch itself is correct though:

> The msleep delay is calculated as rounded down time of waiting number of
> cycles (from ad1848k and cs4231a specs) with the highest frequency
> (48kHz).

As you say, the next loop is waiting for the auto-calibration bit to go down 
again, so here we should be waiting (the maximum time needed) for it to come 
up after dropping the MCE bit. You do a msleep(7), which I assume is derived 
(somehow...) from the 384 cycles mentioned in the spec, at 48kHz, but that's 
the time the auto-calibration bit will stay up after _having_ come up.

On page 24 of the AD1848K spec (2nd column, near top) we have:

   * Clear the Mode Change Enable (MCE) bit

   * The Autocalibrate-In-Progrss (ACI) bit will transition from LO to
     HI within 5 sample periods. [ ... ]

Which seems to be saying that we should be waiting for only 5 cycles at that 
point. With the slowest (!) possible sampling rate of 5.5125 kHz that would 
mean 907 us, or sligtly under 1 ms.

For the CS4231, the datasheet implies ACI should be up immediately upon 
dropping MCE (when auto-calibrating). On page 20 of the CS4231A sheet:

   3) Return from Mode Change Enable by resetting the MCE bit [ ... ]
   4) Wait until ACI cleared to proceed

As such, I've tested the below on CS4231A and there it seems to be working 
fine. Also delaying for 1ms in cs2431 would be fine by me as well...

> Rene, please test this patch on the cs4231 codec.

Given that the only difference is that I wait less, yours would've worked as 
well -- thanks for looking into this! And could you viceversa test this on 
AD1848 and perhaps resubmit if you agree?

Rene.


--------------050505080708040509090206
Content-Type: text/plain;
 name="ad1848-mce_down.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ad1848-mce_down.diff"

diff --git a/sound/isa/ad1848/ad1848_lib.c b/sound/isa/ad1848/ad1848_lib.c
index 8094282..4d951ac 100644
--- a/sound/isa/ad1848/ad1848_lib.c
+++ b/sound/isa/ad1848/ad1848_lib.c
@@ -227,16 +227,14 @@ static void snd_ad1848_mce_down(struct snd_ad1848 *chip)
 		spin_unlock_irqrestore(&chip->reg_lock, flags);
 		return;
 	}
-	/* calibration process */
 
-	for (timeout = 500; timeout > 0 && (snd_ad1848_in(chip, AD1848_TEST_INIT) & AD1848_CALIB_IN_PROGRESS) == 0; timeout--);
-	if ((snd_ad1848_in(chip, AD1848_TEST_INIT) & AD1848_CALIB_IN_PROGRESS) == 0) {
-		snd_printd("mce_down - auto calibration time out (1)\n");
-		spin_unlock_irqrestore(&chip->reg_lock, flags);
-		return;
-	}
+	/*
+	 * If auto-calibrating, CALIB_IN_PROGRESS will be up within 5 sample
+	 * periods which at the slowest rate of 5.5125 kHz means ~ 907 us.
+	 */
+	mdelay(1);
 #if 0
-	printk("(2) timeout = %i, jiffies = %li\n", timeout, jiffies);
+	printk("(2) jiffies = %li\n", jiffies);
 #endif
 	time = HZ / 4;
 	while (snd_ad1848_in(chip, AD1848_TEST_INIT) & AD1848_CALIB_IN_PROGRESS) {
diff --git a/sound/isa/cs423x/cs4231_lib.c b/sound/isa/cs423x/cs4231_lib.c
index 914d77b..bd1affe 100644
--- a/sound/isa/cs423x/cs4231_lib.c
+++ b/sound/isa/cs423x/cs4231_lib.c
@@ -344,18 +344,8 @@ void snd_cs4231_mce_down(struct snd_cs4231 *chip)
 	    !(chip->hardware & (CS4231_HW_CS4231_MASK | CS4231_HW_CS4232_MASK))) {
 		return;
 	}
-	snd_cs4231_busy_wait(chip);
-
-	/* calibration process */
-
-	for (timeout = 500; timeout > 0 && (snd_cs4231_in(chip, CS4231_TEST_INIT) & CS4231_CALIB_IN_PROGRESS) == 0; timeout--)
-		udelay(10);
-	if ((snd_cs4231_in(chip, CS4231_TEST_INIT) & CS4231_CALIB_IN_PROGRESS) == 0) {
-		snd_printd("cs4231_mce_down - auto calibration time out (1)\n");
-		return;
-	}
 #if 0
-	printk("(2) timeout = %i, jiffies = %li\n", timeout, jiffies);
+	printk("(2) jiffies = %li\n", jiffies);
 #endif
 	/* in 10 ms increments, check condition, up to 250 ms */
 	timeout = 25;

--------------050505080708040509090206
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------050505080708040509090206--
