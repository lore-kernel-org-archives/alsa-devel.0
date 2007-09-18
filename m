From: Rene Herman <rene.herman@gmail.com>
Subject: [PATCH 2/4] alsa-kernel: schedule_timeout() fix for
	kernel/drivers/input/touchscreen/ucb1400_ts.c
Date: Tue, 18 Sep 2007 15:49:29 +0200
Message-ID: <46EFD769.3010503@gmail.com>
References: <46E58D01.9080809@gmail.com>	<Pine.LNX.4.58.0709170325380.27377@shell4.speakeasy.net>	<46EF18FF.7070906@gmail.com>	<46EF3097.7060300@gmail.com>	<46EF52E4.90401@gmail.com>
	<s5habrkchpa.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030708010201070700010401"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.tilbu1.nb.home.nl (smtpq1.tilbu1.nb.home.nl
	[213.51.146.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 5C3E0244D7
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Sep 2007 15:50:28 +0200 (CEST)
In-Reply-To: <s5habrkchpa.wl%tiwai@suse.de>
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
Cc: Krzysztof Helt <krzysztof.h1@gmail.com>, ALSA devel <alsa-devel@alsa-project.org>, Trent Piepho <xyzzy@speakeasy.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------030708010201070700010401
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

On 09/18/2007 01:54 PM, Takashi Iwai wrote:

> The other changes look good to me.  But, honestly, I couldn't follow all
> the pathes you sent in the right order.  So, could you guys make a series
> of patches to be applied to HG tree?  That'll be really helpful for
> review, too.

Only split of from the rest since I'm not in fact sure what/why that 
drivers/input stuff is inside alsa-kernel.

===

alsa-kernel: schedule_timeout() fix for ucb1400_ts.c

ucb14ts_ts.c is doing a (manual) schedule_timeout_uninterruptible, but is 
not actually checking for pending signals. An _uninterruptible() one will do 
then.

Signed-off-by: Rene Herman <rene.herman>

--------------030708010201070700010401
Content-Type: text/plain;
 name="schedule_timeout-ucb1400_ts.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="schedule_timeout-ucb1400_ts.diff"

diff -r 0028e39ead78 kernel/drivers/input/touchscreen/ucb1400_ts.c
--- a/kernel/drivers/input/touchscreen/ucb1400_ts.c	Tue Sep 18 00:52:38 2007 +0200
+++ b/kernel/drivers/input/touchscreen/ucb1400_ts.c	Tue Sep 18 14:51:04 2007 +0200
@@ -130,8 +130,7 @@ static unsigned int ucb1400_adc_read(str
 		if (val & UCB_ADC_DAT_VALID)
 			break;
 		/* yield to other processes */
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(1);
+		schedule_timeout_uninterruptible(1);
 	}
 
 	return UCB_ADC_DAT_VALUE(val);

--------------030708010201070700010401
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------030708010201070700010401--
