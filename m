From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: PCM driver only plays tiny portion of clip
Date: Fri, 03 Mar 2006 08:27:43 +0100
Message-ID: <20060303072743.GB8569@turing.informatik.uni-halle.de>
References: <47411.217.150.108.178.1141139656.squirrel@newgolddream.dyndns.info>
 <20060228170824.GA24675@turing.informatik.uni-halle.de>
 <61111.217.150.108.178.1141148175.squirrel@newgolddream.dyndns.info>
 <1141240231.9233.11.camel@localhost.localdomain>
 <1141241474.5860.183.camel@mindpipe>
 <1141242058.9233.17.camel@localhost.localdomain>
 <1141243152.5860.197.camel@mindpipe>
 <1141244926.9233.32.camel@localhost.localdomain>
 <1141245699.5860.224.camel@mindpipe>
 <1141332564.9233.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailgate2.urz.uni-halle.de (mailgate2.urz.uni-halle.de [141.48.3.8])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id AFAB51A9
	for <alsa-devel@alsa-project.org>; Fri,  3 Mar 2006 08:27:52 +0100 (MET)
In-reply-to: <1141332564.9233.6.camel@localhost.localdomain>
Content-disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Cc: Lee Revell <rlrevell@joe-job.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Adrian McMenamin wrote:
> I think I have a good idea why my it is not working now - the DMA
> routine which transfers sound samples from the main CPU memory to the
> ring buffer of the hardware (which is effectively in a different memory
> space) is in a kernel thread which, in essence, never gets rescheduled -
> so the app thinks there is sound to be transferred but it never is -
> hence it gets wedged.
> 
> To fix that I need to know what the alsa subsystem calls inside the
> driver when it wants a DMA transfer to resume - I have to reschedule the
> kernel thread there.

ALSA doesn't call the driver.  It assumes the hardware runs by itself.

If your hardware doesn't issue some interrupt regularly, you have to use
a timer.


HTH
Clemens


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
