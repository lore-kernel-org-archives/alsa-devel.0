From: noreply@alsa-project.org
Subject: [ALSA - driver 0000056]: snd-cs46xx now fails to load (worked in 0.9.8)
Date: Fri, 16 Jul 2004 14:37:36 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716123736.26E402C005@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 7B281244
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 14:37:36 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000056
======================================================================
Reported By:                robbat2
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     56
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Gentoo
Kernel Version:             2.4.23-pac1
======================================================================
Date Submitted:             02-13-2004 01:53 CET
Last Modified:              07-16-2004 14:37 CEST
======================================================================
Summary:                    snd-cs46xx now fails to load (worked in 0.9.8)
Description: 
snd-cs46xx previously worked on my Thinkpad 600E, as of alsa-driver version
0.9.8. Now after upgrading to 1.0.2, the module no longer loads.

relevant output from dmesg:
ALSA: ../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:3148: create - never read
codec ready from AC'97
ALSA: ../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:3149: it is not probably
bug, try to use CS4236 driver

i did try the cs4236 driver as well after this, with the sole output being
CS4236+ soundcard not found or device busy.

/proc/pci has:
Multimedia audio controller: Cirrus Logic CS 4610/11 [CrystalClear
SoundFusion Audio Accelerator] (rev 1).
======================================================================

----------------------------------------------------------------------
 robbat2 - 02-13-2004 01:54 CET 
----------------------------------------------------------------------
one further note, I use the ACPI solely on the laptop, as I need it for
some of the other bits I do (APM is not sufficent).

----------------------------------------------------------------------
 perex - 02-13-2004 18:35 CET 
----------------------------------------------------------------------
Does 0.9.8 code work on your current kernel?

----------------------------------------------------------------------
 perex - 03-05-2004 13:03 CET 
----------------------------------------------------------------------
No reaction from user.

----------------------------------------------------------------------
 robbat2 - 03-05-2004 13:42 CET 
----------------------------------------------------------------------
sorry for long delay, been busy with exams.
0.9.8 doesn't work on the current kernel either.

i'm going to be moving to a 2.6 kernel in the next two weeks, so you might
as close this as a proper resolution for now, and i'll open a new bug
after upgrading everything and checking it out.

----------------------------------------------------------------------
 tiwai - 03-05-2004 17:43 CET 
----------------------------------------------------------------------
cs46xx has never worked with TP600E, since it doesn't have
AC97 codec but CS4236.
you can configure cs4236 via alsaconf.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
02-13-04 01:53 robbat2        New Bug                                      
02-13-04 01:54 robbat2        Bugnote Added: 0000235                       
02-13-04 18:35 perex          Assigned To               => perex           
02-13-04 18:35 perex          Status                   new => assigned     
02-13-04 18:35 perex          Bugnote Added: 0000238                       
03-05-04 13:03 perex          Bugnote Added: 0000502                       
03-05-04 13:03 perex          Resolution               open => suspended   
03-05-04 13:03 perex          Status                   assigned => resolved
03-05-04 13:42 robbat2        Bugnote Added: 0000504                       
03-05-04 13:42 robbat2        Resolution               suspended => reopened
03-05-04 13:42 robbat2        Status                   resolved => feedback
03-05-04 17:43 tiwai          Bugnote Added: 0000507                       
03-08-04 11:37 tiwai          Assigned To              perex => tiwai      
03-08-04 11:37 tiwai          Resolution               reopened => not a bug
03-08-04 11:37 tiwai          Status                   feedback => resolved
07-16-04 14:37 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
