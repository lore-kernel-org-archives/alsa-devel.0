From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Random process lockup on ARM board:
 alsa-lib-1.0.25, FUTEX_WAIT_PRIVATE
Date: Thu, 08 Mar 2012 21:40:35 +0100
Message-ID: <4F591943.8040308@ladisch.de>
References: <1329393691.6830.20.camel@jonspc>	
	<1329512682.29051.1.camel@jonspc>
	<1329570128.6670.0.camel@jonspc>	 <4F400BBF.9020707@ladisch.de>
	<1329603022.1089.57.camel@jonspc>	 <4F41FC28.1070605@ladisch.de>
	<1329926198.22918.10.camel@jonspc>	 <4F45167A.6080706@ladisch.de>
	<1329933773.24266.44.camel@jonspc>	 <4F58736F.6010500@ladisch.de>
	<1331199625.22455.7.camel@jonspc>	 <4F588213.2030600@ladisch.de>
	<1331203724.22455.44.camel@jonspc>	 <4F589B58.6090203@ladisch.de>
	<1331214439.27232.12.camel@jonspc>	 <4F58C394.3020200@ladisch.de>
	<1331219690.30002.13.camel@jonspc>	
	<s5h8vjbyuly.wl%tiwai@suse.de> <1331233549.2772.5.camel@jonspc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 44C751041F3
	for <alsa-devel@alsa-project.org>; Thu,  8 Mar 2012 21:41:25 +0100 (CET)
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 1D9DA20ABF
	for <alsa-devel@alsa-project.org>; Thu,  8 Mar 2012 15:41:18 -0500 (EST)
In-Reply-To: <1331233549.2772.5.camel@jonspc>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jon@jonshouse.co.uk
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Jonathan Andrews wrote:
> Using the static libasound without pthreads now.
>
> Process still stalls in same way:
>
> ARM / # strace -p 408
> Process 408 attached - interrupt to quit
> futex(0x15a684, FUTEX_WAIT, 2, NULL

So it's not a call from alsa-lib.

> An strace of a stall (intel this time) is here.  Its 2GB and on a slow
> link (sorry).
> http://www.jonshouse.co.uk/download/a_stop.txt

If only there were a tool to compress files ...

> The futex address 0xae5320 occurs only once at the end of the text file
> so I have no idea what sets it up.

Can't you attach gdb to your process?
Or at least log where in your program you are?
(If strace has too much overhead, write to a variable, and run a thread
that waits for keyboard input and prints the variable.)


Regards,
Clemens
