From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: Problems running latencytest: "error setting freq
	1024"
Date: 23 Mar 2004 15:08:50 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1080083330.32365.278.camel@cmn37.stanford.edu>
References: <20040323205352.GA3246@fliwatut.scifi>
	 <200403232133.i2NLXCZt015035@dhin.linuxaudiosystems.com>
	 <20040323214205.GA4382@fliwatut.scifi>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp3.Stanford.EDU (smtp3.Stanford.EDU [171.67.16.117])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id AAA06430
	for <alsa-devel@alsa-project.org>; Wed, 24 Mar 2004 00:08:57 +0100
In-Reply-To: <20040323214205.GA4382@fliwatut.scifi>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Frank Barknecht <fbar@footils.org>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> > >$ measure -p ./out/x11.png -o ./out/x11.out -c 0 -f 1024 -n 2 -t 2
> > >I get this error message: "error setting freq 1024"
> > 
> > probably a permissions problem. try it as root.
> 
> This is while runng at root. (Sorry for the "$" I typed that one by
> hand). 
> 
> A tip from Tim Goetze to do: 
> 
>  # echo 2048 > /proc/sys/dev/rtc/max-user-freq
> (^ sic!)
> 
> didn't help either yet. I did a strace on the measure run now, which
> showed something equally strange (to my eyes): 
> 
> mlockall(MCL_CURRENT|MCL_FUTURE)        = 0
> sched_get_priority_max(0x1)             = 99
> sched_setscheduler(0, 0x1, 0xbfffe254)  = 0
> open("/dev/midi0", O_RDWR)              = 3
> ioctl(3, 0x40047401, 0x400)             = -1 ENOTTY (Inappropriate ioctl for device)
> write(2, "error setting freq 1024\n", 24) = 24
> exit_group(1)                           = ?
> 
> I'm still puzzled. Why "/dev/midi0"?

Takashi is apparently using that to communicate with the latency test
kernel module (I think he mentions it in the README :-)

I have it running here with no problems, will post pointers to some
results (2.6.4 + 2.6.5rc2 + bk2 + lsm + drm lowlat patches, w and w/o
preempt). 

-- Fernando




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
