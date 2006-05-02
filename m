From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002070]: Hard lockup from aplay with low buffersizes on Tascam us-122 (snd_usb_usx2y)
Date: Tue, 2 May 2006 21:14:26 +0200
Message-ID: <dfb1c1af97df47ded8be74a2003d0ccb@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2650019F
	for <alsa-devel@alsa-project.org>; Tue,  2 May 2006 21:14:27 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2070> 
======================================================================
Reported By:                jaime
Assigned To:                karsten
======================================================================
Project:                    ALSA - driver
Issue ID:                   2070
Category:                   USB - usb-usx2y
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo ~x86
Kernel Version:             2.6.17-rc1
======================================================================
Date Submitted:             04-25-2006 23:07 CEST
Last Modified:              05-02-2006 21:14 CEST
======================================================================
Summary:                    Hard lockup from aplay with low buffersizes on
Tascam us-122 (snd_usb_usx2y)
Description: 
Hi.

Here's the original I'm playing (440Hz sine wave):
www.carbon.eclipse.co.uk/origSine.wav

aplay --buffer-size=1024 origSine.wav sounds great:
www.carbon.eclipse.co.uk/aplay1024.wav

aplay --buffer-size=512 origSine.wav sounds bad:
www.carbon.eclipse.co.uk/aplay512.wav

aplay --buffer-size=256 origSine.wav sounds very bad:
www.carbon.eclipse.co.uk/aplay256.wav

aplay --buffer-size=128 origSine.wav gives only a very short click,
and then locks up the machine completely:
www.carbon.eclipse.co.uk/aplay128.wav

I've tried this using different usb cards/controllers, and I get the
same problem, so I think it is an alsa driver problem.

Thank you for any help you can offer.

======================================================================

----------------------------------------------------------------------
 karsten - 04-30-06 21:12 
----------------------------------------------------------------------
ah, glad to read nrpacks=1 helps.

I guess its not necessary to further debug this:
the driver should be changed to only allow buffersizes >= 1024,
when nrpacks!=1.
(nrpacks!=1 is a means to make things work in slowish pc anyhow.)

In the meantime,
just modify your /etc/modprobe.conf so nrpacks=1 will always be applied.

Thanks, Karsten

----------------------------------------------------------------------
 jaime - 05-02-06 21:14 
----------------------------------------------------------------------
Hi Karsten.

I know that you said that it's not worth debugging this, but I'm still
trying to get a stack trace, just to find out what's causing the lockup.
I'm managed to get a serial console working on another machine, and using
the nmi_watchdog, I get the following out 5 seconds after I start aplay:

BUG: NMI Watchdog detected LOCKUP on CPU0, eip c03393a4, registers:
Modules linked in: snd_usb_usx2y snd_usb_lib snd_rawmidi snd_seq_device
..]&#65533;.u&#65533;.}&#65533;&#65533;...0.

That's all I get, and that was after I'd set the console logging level to
8 (using /proc/sys/kernel/printk).

I've read a lot in the last few days, but I'm not sure what is the best
tool to use, to get that elusive stack trace. What do you recommend?

Thanks

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-25-06 23:07 jaime          New Issue                                    
04-25-06 23:07 jaime          Distribution              => Gentoo ~x86     
04-25-06 23:07 jaime          Kernel Version            => 2.6.17-rc1      
04-26-06 16:23 jaime          Note Added: 0009514                          
04-26-06 23:19 karsten        Note Added: 0009526                          
04-26-06 23:29 karsten        Note Added: 0009527                          
04-26-06 23:31 karsten        Note Edited: 0009527                         
04-30-06 19:35 jaime          Note Added: 0009550                          
04-30-06 21:12 karsten        Note Added: 0009551                          
05-02-06 21:14 jaime          Note Added: 0009578                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
