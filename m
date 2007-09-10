From: Rene Herman <rene.herman@gmail.com>
Subject: Re: [PATCH] ad1848 and cs4231 busy loop replacement
Date: Mon, 10 Sep 2007 20:18:41 +0200
Message-ID: <46E58A81.8050307@gmail.com>
References: <20070909001208.b2e54c13.krzysztof.h1@gmail.com>	<46E46109.5040704@gmail.com>	<8c74410a0709100008v5497e870j7495b3ea054ae00b@mail.gmail.com>	<46E53072.2040404@gmail.com>	<8c74410a0709100542x6b5997d0hc893afb6f94acf4@mail.gmail.com>	<46E542F4.7060608@gmail.com>
	<20070910190533.e5382668.krzysztof.h1@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030703070501070701080802"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 9C050103879
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Sep 2007 20:25:40 +0200 (CEST)
In-Reply-To: <20070910190533.e5382668.krzysztof.h1@gmail.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------030703070501070701080802
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

On 09/10/2007 07:05 PM, Krzysztof Helt wrote:

> Rene Herman <rene.herman@gmail.com> wrote:

>> No, waiting for calibration the be under way is what my 0/1 ms does.
>> You are waiting for it to be nearly done, which is complete nonsense.
>> One line below we are waiting for 250 ms (generally with _one_ pass
>> through the loop -- we only wake up through signals) anyway!
> 
> I don't buy your argument that it is complete nonsense.

You don't need to buy it -- I presented it to you for free on a fucking 
platter 4 times now. You are making me waste my time. Answer this or just 
bury this useles nonsense discussion: why do you insist on delaying for 7 ms 
when the specification says (and the hardware is confirming) that 1 ms is 
enough?

You are delaying 7 ms and then 250 ms when we are auto-calibrating. I delay 
1 ms and then 250 ms when we are auto-calibrating. Why do you delay longer 
than the hardware needs and make everyone who ever reads this code wonder 
why the hell that odd delay is in there? And make everyone who ever will be 
re-writing or porting this code drag it along on the notion that someone, 
somewhere probably once had a purpose for it?

Fix it up with a comment? Why? There's still not a single point to it.

Why 7? Or 2? Or whatever more time than needed for the calibration to start?

> Also comments like "my way or highway" (NAK) won't make you many friends.

Good, I don't need more friends. You are doing the generic newbie thing 
where you assume you obviously must know everything better than everyone 
else. Just shelve that dumb crap.

You also may want to take into account that I'm taking the time to review 
your code and dig trough datasheets while I had in fact different things to 
do and it's proving utterly useless.

Fixed patch attached.

Rene.

--------------030703070501070701080802
Content-Type: text/plain;
 name="mce_down.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mce_down.diff"

diff --git a/sound/isa/ad1848/ad1848_lib.c b/sound/isa/ad1848/ad1848_lib.c
index 8094282..dcd4435 100644
--- a/sound/isa/ad1848/ad1848_lib.c
+++ b/sound/isa/ad1848/ad1848_lib.c
@@ -227,16 +227,15 @@ static void snd_ad1848_mce_down(struct snd_ad1848 *chip)
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
+        /*
+         * Wait for (possible -- during init auto-calibration may not be set)
+         * calibration process to start. Needs upto 5 sample periods on AD1848
+         * which at the slowest possible rate of 5.5125 kHz means 907 us.
+         */
+        msleep(1);
 #if 0
-	printk("(2) timeout = %i, jiffies = %li\n", timeout, jiffies);
+	printk("(2) jiffies = %li\n", jiffies);
 #endif
 	time = HZ / 4;
 	while (snd_ad1848_in(chip, AD1848_TEST_INIT) & AD1848_CALIB_IN_PROGRESS) {
diff --git a/sound/isa/cs423x/cs4231_lib.c b/sound/isa/cs423x/cs4231_lib.c
index 914d77b..9e8e0f1 100644
--- a/sound/isa/cs423x/cs4231_lib.c
+++ b/sound/isa/cs423x/cs4231_lib.c
@@ -346,16 +346,14 @@ void snd_cs4231_mce_down(struct snd_cs4231 *chip)
 	}
 	snd_cs4231_busy_wait(chip);
 
-	/* calibration process */
-
-	for (timeout = 500; timeout > 0 && (snd_cs4231_in(chip, CS4231_TEST_INIT) & CS4231_CALIB_IN_PROGRESS) == 0; timeout--)
-		udelay(10);
-	if ((snd_cs4231_in(chip, CS4231_TEST_INIT) & CS4231_CALIB_IN_PROGRESS) == 0) {
-		snd_printd("cs4231_mce_down - auto calibration time out (1)\n");
-		return;
-	}
+	/*
+	 * Wait for (possible -- during init auto-calibration may not be set)
+	 * calibration process to start. Needs upto 5 sample periods on AD1848
+	 * which at the slowest possible rate of 5.5125 kHz means 907 us.
+	 */
+	msleep(1);
 #if 0
-	printk("(2) timeout = %i, jiffies = %li\n", timeout, jiffies);
+	printk("(2) jiffies = %li\n", jiffies);
 #endif
 	/* in 10 ms increments, check condition, up to 250 ms */
 	timeout = 25;

--------------030703070501070701080802
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------030703070501070701080802--
