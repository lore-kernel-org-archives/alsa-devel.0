From: Jonathan Andrews <jon@jonshouse.co.uk>
Subject: Re: Random process lockup on ARM board:
 alsa-lib-1.0.25, FUTEX_WAIT_PRIVATE
Date: Thu, 08 Mar 2012 19:05:49 +0000
Message-ID: <1331233549.2772.5.camel@jonspc>
References: <1329393691.6830.20.camel@jonspc>
	<1329512682.29051.1.camel@jonspc> <1329570128.6670.0.camel@jonspc>
	<4F400BBF.9020707@ladisch.de> <1329603022.1089.57.camel@jonspc>
	<4F41FC28.1070605@ladisch.de> <1329926198.22918.10.camel@jonspc>
	<4F45167A.6080706@ladisch.de> <1329933773.24266.44.camel@jonspc>
	<4F58736F.6010500@ladisch.de> <1331199625.22455.7.camel@jonspc>
	<4F588213.2030600@ladisch.de> <1331203724.22455.44.camel@jonspc>
	<4F589B58.6090203@ladisch.de> <1331214439.27232.12.camel@jonspc>
	<4F58C394.3020200@ladisch.de> <1331219690.30002.13.camel@jonspc>
	<s5h8vjbyuly.wl%tiwai@suse.de>
Reply-To: jon@jonshouse.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.jonshouse.co.uk (unknown [91.84.151.33])
	by alsa0.perex.cz (Postfix) with ESMTP id 8A37E24133
	for <alsa-devel@alsa-project.org>; Thu,  8 Mar 2012 20:05:48 +0100 (CET)
In-Reply-To: <s5h8vjbyuly.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Thu, 2012-03-08 at 16:34 +0100, Takashi Iwai wrote:
> At Thu, 08 Mar 2012 15:14:50 +0000,
> Jonathan Andrews wrote:
> > 
> > On Thu, 2012-03-08 at 15:35 +0100, Clemens Ladisch wrote:
> > > Jonathan Andrews wrote:
> > > > Getting closer, alsalib now builds without the need for pthreads but
> > > > seems to insist on dlopen dlclose even in static lib ?
> > > 
> > > Add --without-libdl.
> > > 
Using the static libasound without pthreads now.

Process still stalls in same way:

ARM / # strace -p 408
Process 408 attached - interrupt to quit
futex(0x15a684, FUTEX_WAIT, 2, NULL
^C <unfinished ...>
Process 408 detached

Took 3 hours 1 min to stall. It was decoding 8 udp audio streams, a
second tx process reading from the same sound device was also running.


An strace of a stall (intel this time) is here.  Its 2GB and on a slow
link (sorry).
http://www.jonshouse.co.uk/download/a_stop.txt

futex(0xae5320, FUTEX_WAIT_PRIVATE, 2, NULL) = ? ERESTARTSYS (To be
restarted)
--- SIGINT (Interrupt) @ 0 (0) ---

The futex address 0xae5320 occurs only once at the end of the text file
so I have no idea what sets it up.

Thanks,
Jon
