From: Frank Barknecht <fbar@footils.org>
Subject: Re: Problems running latencytest: "error setting freq 1024"
Date: Tue, 23 Mar 2004 22:42:05 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040323214205.GA4382@fliwatut.scifi>
References: <20040323205352.GA3246@fliwatut.scifi> <200403232133.i2NLXCZt015035@dhin.linuxaudiosystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp2.netcologne.de (smtp2.netcologne.de [194.8.194.218])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id WAA04458
	for <alsa-devel@alsa-project.org>; Tue, 23 Mar 2004 22:42:38 +0100
Received: from fliwatut.scifi (xdsl-213-196-243-96.netcologne.de [213.196.243.96])
	by smtp2.netcologne.de (Postfix) with ESMTP id CC4CA3A0B3
	for <alsa-devel@alsa-project.org>; Tue, 23 Mar 2004 22:42:05 +0100 (MET)
Received: from freak by fliwatut.scifi with local (Exim 3.36 #1 (Debian))
	id 1B5tev-0001AU-00
	for <alsa-devel@alsa-project.org>; Tue, 23 Mar 2004 22:42:05 +0100
Content-Disposition: inline
In-Reply-To: <200403232133.i2NLXCZt015035@dhin.linuxaudiosystems.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hallo,
Paul Davis hat gesagt: // Paul Davis wrote:

> >$ measure -p ./out/x11.png -o ./out/x11.out -c 0 -f 1024 -n 2 -t 2
> >I get this error message: "error setting freq 1024"
> 
> probably a permissions problem. try it as root.

This is while runng at root. (Sorry for the "$" I typed that one by
hand). 

A tip from Tim Goetze to do: 

 # echo 2048 > /proc/sys/dev/rtc/max-user-freq
(^ sic!)

didn't help either yet. I did a strace on the measure run now, which
showed something equally strange (to my eyes): 

mlockall(MCL_CURRENT|MCL_FUTURE)        = 0
sched_get_priority_max(0x1)             = 99
sched_setscheduler(0, 0x1, 0xbfffe254)  = 0
open("/dev/midi0", O_RDWR)              = 3
ioctl(3, 0x40047401, 0x400)             = -1 ENOTTY (Inappropriate ioctl for device)
write(2, "error setting freq 1024\n", 24) = 24
exit_group(1)                           = ?

I'm still puzzled. Why "/dev/midi0"?

ciao
-- 
 Frank Barknecht                               _ ______footils.org__


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
