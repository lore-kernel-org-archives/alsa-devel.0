From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Re: PCM driver only plays tiny portion of clip
Date: Thu, 02 Mar 2006 20:49:23 +0000
Message-ID: <1141332564.9233.6.camel@localhost.localdomain>
References: <44054.217.150.108.178.1141056426.squirrel@newgolddream.dyndns.info>
	 <20060227172601.GA446@turing.informatik.uni-halle.de>
	 <40613.217.150.108.178.1141061722.squirrel@newgolddream.dyndns.info>
	 <20060228073049.GA4158@turing.informatik.uni-halle.de>
	 <35384.217.150.108.178.1141117853.squirrel@newgolddream.dyndns.info>
	 <20060228145541.GA20876@turing.informatik.uni-halle.de>
	 <47411.217.150.108.178.1141139656.squirrel@newgolddream.dyndns.info>
	 <20060228170824.GA24675@turing.informatik.uni-halle.de>
	 <61111.217.150.108.178.1141148175.squirrel@newgolddream.dyndns.info>
	 <1141240231.9233.11.camel@localhost.localdomain>
	 <1141241474.5860.183.camel@mindpipe>
	 <1141242058.9233.17.camel@localhost.localdomain>
	 <1141243152.5860.197.camel@mindpipe>
	 <1141244926.9233.32.camel@localhost.localdomain>
	 <1141245699.5860.224.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sc-outsmtp2.homechoice.co.uk (sc-outsmtp2.homechoice.co.uk [81.1.65.36])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 7B3E7173
	for <alsa-devel@alsa-project.org>; Thu,  2 Mar 2006 21:49:27 +0100 (MET)
In-Reply-To: <1141245699.5860.224.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2006-03-01 at 15:41 -0500, Lee Revell wrote:

> 
> In this example the period (# of frames between interrupts) is 256.  So
> if the app is waiting to write 512 frames (by setting the avail_min
> software parameter) it will be woken up every other interrupt.  (This
> example only makes sense if there are more than 2 periods per buffer,
> otherwise the app is constantly overwriting the data that the hardware
> is playing).
> 
> Lee


I think I have a good idea why my it is not working now - the DMA
routine which transfers sound samples from the main CPU memory to the
ring buffer of the hardware (which is effectively in a different memory
space) is in a kernel thread which, in essence, never gets rescheduled -
so the app thinks there is sound to be transferred but it never is -
hence it gets wedged.

To fix that I need to know what the alsa subsystem calls inside the
driver when it wants a DMA transfer to resume - I have to reschedule the
kernel thread there.

(I have to use a kernel thread or at least something similar to ensure
that the trigger callback remains atomic due to the nature of the SH
DMAC API.)



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
