From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Suggestion for improving alsa-lib sample rate converters.
Date: Wed, 15 Sep 2004 15:38:36 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <414853EC.3050103@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-34.mail.demon.net (anchor-post-34.mail.demon.net [194.217.242.92])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 7FE052FD
	for <alsa-devel@alsa-project.org>; Wed, 15 Sep 2004 16:38:43 +0200 (MEST)
Received: from superbug.demon.co.uk ([80.176.146.252] helo=[192.168.1.10])
	by anchor-post-34.mail.demon.net with esmtp (Exim 3.35 #1)
	id 1C7avh-000Pf1-0Y
	for alsa-devel@alsa-project.org; Wed, 15 Sep 2004 14:38:42 +0000
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The ideal sample rate converter would be a serial sample rate converter.
e.g. Each sample is fed into the converter, and the new samples exit the 
converter at the correct rate.
With alsa this would convert to user application calling snd_pcm_write() 
with X samples, and Y samples coming out of the rate converter.
But one cannot have half a sample, so some rounding has to happen, so 
for X input samples, the output will differ depending on what went 
before, so one might get Y samples coming out, or Y+1 samples coming out.

User applications require a number of things from the sound card.
1) How many samples will fill the next period.
2) When doing sample rate conversions, this period size that the app 
sees should really be allowed to be different for each period.

Currently, we are limited in that the user application's period size has 
to be the same size for all periods.

The hardware normally has all equal size periods per buffer.
Depending on the state of the sample rate converters, this "all periods 
the same size" at the hardware level will result in varying period sizes 
at the application level after the sample rate converters have acted.
E.g. Hardware running at 48000, with period size of 1024.
Application running at 44100, period sizes, in sequence might be 
941,941,941,941,940,941,941,941,941,940...
I.e. every 5th period having a different size.

If the application wishes to write whole periods at a time(e.g. Mem 
mapped, or callback based apps), there will have to be a way to tell the 
application about the size of the next period.

Conclusion:
So, the alsa application would now do:
x = snd_pcm_get_next_period_size();   /* This would be a new api call */
snd_pcm_write(x samples);

With this extra bit of information fed back to the application, we could 
implement proper polyphase interpolators in alsa-lib.

Any comments?

James


-------------------------------------------------------
This SF.Net email is sponsored by: thawte's Crypto Challenge Vl
Crack the code and win a Sony DCRHC40 MiniDV Digital Handycam
Camcorder. More prizes in the weekly Lunch Hour Challenge.
Sign up NOW http://ad.doubleclick.net/clk;10740251;10262165;m
