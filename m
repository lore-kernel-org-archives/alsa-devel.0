From: noreply@alsa-project.org
Subject: [ALSA - driver 0000327]: Creative SoundBlaster Audigy Gamer - No sound at all
Date: Fri, 16 Jul 2004 12:54:01 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716105401.414D726008@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id B41871B0
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 12:54:01 +0200 (MEST)
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


The following bug has been CLOSED
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000327
======================================================================
Reported By:                th0ma7
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     327
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Fedora Core 2
Kernel Version:             2.6.5, 2.6.6, 2.6.7-rc2
======================================================================
Date Submitted:             06-08-2004 01:53 CEST
Last Modified:              07-16-2004 12:54 CEST
======================================================================
Summary:                    Creative SoundBlaster Audigy Gamer - No sound at all
Description: 
No sound is available.
In reference to a bug I've opened
http://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=120804
I've tried kernel-2.6.5smp (driver 1.0.3), 2.6.6smp, 2.6.7rc2-smp (driver
1.0.4.. I think!)

I've also tried to manually install driver 1.0.5 onto 2.6.7-rc2 kernel
(with tools and libs) but still nothing.

In alsamixer there is a few channels completely blocked.
======================================================================

----------------------------------------------------------------------
 pzad - 06-08-2004 08:34 CEST 
----------------------------------------------------------------------
TONE
Mic Boost (+20db)
IEC958 Optical Raw4
Audigy Analog/Digital Output Jack
External Amplifier

These are switches - you can mute, unmute it using M key in alsamixer.
Make sure that 
IEC958 Optical Raw4
Audigy Analog/Digital Output Jack
are muted (in alsamixer there should be MM above bars.

make shure that these volumes are not 0
Master
PCM
Front - kmix seem to have bug and this kontrol not work in it - use
alsamixer

I have Audigy 1 and FC2 and it works with default FC2 kernel ALSA.

----------------------------------------------------------------------
 th0ma7 - 06-11-2004 03:10 CEST 
----------------------------------------------------------------------
It has resolved the bug effectively.. thnx!

Bug History
Date Modified  Username       Field                    Change              
======================================================================
06-08-04 01:53 th0ma7         New Bug                                      
06-08-04 01:53 th0ma7         File Added: alsamixer.png                    
06-08-04 01:53 th0ma7         Distribution              => Fedora Core 2   
06-08-04 01:53 th0ma7         Kernel Version            => 2.6.5, 2.6.6, 2.6.7-rc2
06-08-04 08:34 pzad           Bugnote Added: 0001293                       
06-11-04 03:10 th0ma7         Bugnote Added: 0001299                       
06-22-04 14:52 tiwai          Assigned To               => tiwai           
06-22-04 14:52 tiwai          Resolution               open => not a bug   
06-22-04 14:52 tiwai          Status                   new => resolved     
07-16-04 12:54 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
