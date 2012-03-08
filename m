From: Jonathan Andrews <jon@jonshouse.co.uk>
Subject: Re: Random process lockup on ARM board:
 alsa-lib-1.0.25, FUTEX_WAIT_PRIVATE
Date: Thu, 08 Mar 2012 21:42:16 +0000
Message-ID: <1331242936.3126.24.camel@jonspc>
References: <1329393691.6830.20.camel@jonspc>
	<1329512682.29051.1.camel@jonspc> <1329570128.6670.0.camel@jonspc>
	<4F400BBF.9020707@ladisch.de> <1329603022.1089.57.camel@jonspc>
	<4F41FC28.1070605@ladisch.de> <1329926198.22918.10.camel@jonspc>
	<4F45167A.6080706@ladisch.de> <1329933773.24266.44.camel@jonspc>
	<4F58736F.6010500@ladisch.de> <1331199625.22455.7.camel@jonspc>
	<4F588213.2030600@ladisch.de> <1331203724.22455.44.camel@jonspc>
	<4F589B58.6090203@ladisch.de> <1331214439.27232.12.camel@jonspc>
	<4F58C394.3020200@ladisch.de> <1331219690.30002.13.camel@jonspc>
	<s5h8vjbyuly.wl%tiwai@suse.de> <1331233549.2772.5.camel@jonspc>
	<4F591943.8040308@ladisch.de>
Reply-To: jon@jonshouse.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.jonshouse.co.uk (unknown [91.84.151.33])
	by alsa0.perex.cz (Postfix) with ESMTP id B09201039E4
	for <alsa-devel@alsa-project.org>; Thu,  8 Mar 2012 22:42:16 +0100 (CET)
In-Reply-To: <4F591943.8040308@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2012-03-08 at 21:40 +0100, Clemens Ladisch wrote:
> Jonathan Andrews wrote:
> > Using the static libasound without pthreads now.
> >
> > Process still stalls in same way:
> >
> > ARM / # strace -p 408
> > Process 408 attached - interrupt to quit
> > futex(0x15a684, FUTEX_WAIT, 2, NULL
> 
> So it's not a call from alsa-lib.
The alsa code is a conditional compile, as is that for the /dev/dsp
device.  Only the alsa version fails, the version that just takes data
from the network and mixes it does not fail.

cc udp-many-way-audio-rx.c -DARM -DALSA -lasound -lrt -lm -o udp-many-way-audio-rx_alsa_arms --static
Fails randomly

cc udp-many-way-audio-rx.c -DARM -DDUMMY -DSTATIC -o udp-many-way-audio-rx_dummy_arms --static
Dummy version, never fails.  Still has network code and my audio mixer.

Its not as if I'm linking in a lot of libs...

> > An strace of a stall (intel this time) is here.  Its 2GB and on a slow
> > link (sorry).
> > http://www.jonshouse.co.uk/download/a_stop.txt
> 
> If only there were a tool to compress files ...
Ok, i'm pretty tired I admit it .... 30MB
http://www.jonshouse.co.uk/download/a_stop.txt.gz


> 
> > The futex address 0xae5320 occurs only once at the end of the text file
> > so I have no idea what sets it up.
> 
> Can't you attach gdb to your process?
I need to build an arm version, will work on that next.

> Or at least log where in your program you are?
I did that, best I can tell it enters one of these two functions but
never exists. Makes sense as these are the two conditional compiles
wrapped around #ifdef ALSA in the main loop.
http://www.jonshouse.co.uk/download/udp-many-way-audio-playsample-alsa.c


> (If strace has too much overhead, write to a variable, and run a thread
> that waits for keyboard input and prints the variable.)
The strace (now gzipped) is the same process as the arm running (and
then stalling) on the PC. It still stalls, just takes (on average)
longer to stall on the faster machine ......

Thanks,
Jon
