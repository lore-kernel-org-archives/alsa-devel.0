From: Curtis Veit <curtisv@lineo.com>
Subject: Re: 2.5.5-pre1 kernel - compile as modules?
Date: Thu, 14 Feb 2002 10:47:03 -0700
Message-ID: <20020214174703.GA28285@lineo.com>
References: <E16bNUh-0000Ne-00@baldrick>
Reply-To: curtisv@lineo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from thor.lineo.com (gk2-ext.lineo.com [64.50.107.253])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id SAA04995
	for <alsa-devel@alsa-project.org>; Thu, 14 Feb 2002 18:48:32 +0100
In-Reply-To: <E16bNUh-0000Ne-00@baldrick>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Duncan Sands <duncan.sands@math.u-psud.fr>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 14, 2002 at 04:08:19PM +0100, Duncan Sands wrote:
> I just gave the 2.5.5-pre1 kernel a whirl.  Just to be different,
> I compiled all sound support into the kernel rather than as
> modules.  On startup I get:
> 
> Feb 14 15:43:55 baldrick kernel: Advanced Linux Sound Architecture Driver Version 0.9.0beta10.
> Feb 14 15:43:55 baldrick kernel: kmod: failed to exec /sbin/modprobe -s -k snd-card-0, errno = 2
> Feb 14 15:43:55 baldrick last message repeated 7 times
> Feb 14 15:43:55 baldrick kernel: kmod: failed to exec /sbin/modprobe -s -k snd-card-1, errno = 2

I cut a bit out here...

> 
> And then later there are all sorts of problems, such as
> 
> cat /proc/asound/cards
> 
> claims there is no such device.
> 
> Must sound support be compiled as modules?
> 
> Thanks,
> 
> Duncan.
> 

I have been backporting the 2.5 patch to 2.4.18-preX and compiling
drivers into the kernel only for hardware which I have installed on 
the machine.

So far this has worked (at least partially - see below) with
yamaha YMF-744
sound blaster live 
sound blaster 1371

I also have compiled for the Delta 1010 (ICE) but don't have all 
the utilities so I don't know if it is really working (might
check it out a little more this weekend)

I've mostly used the mixer (aumix) and PCM devices
(playing MP3 files) with success.

Because this seemed to work I did not even look to see if there
were any error messages generated.  The only thing I did before
trying to use the devices was to look in /proc.


If anyone has suggestions for how to easily test more
devices quickly feel free to post some instructions and 
I'll post the results here.  (I have some other HW I could
test as well. gravis and others)  

Actually if anyone would care to help in putting together 
an automated test suite... I could justify spending time 
to work on it. 

Regards,

Curtis



-- 

Curtis Veit                    email: curtisv@lineo.com
Lineo Inc.                     Where Open Meets Smart
390 South 400 West             phone: 801.426.5001 
Lindon, Utah, USA  84042       fax:   801.852.8071



_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
