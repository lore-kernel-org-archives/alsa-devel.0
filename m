From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000418]: loading atiixp-modem and slmodemd corrupts part of atiixp driver
Date: Thu, 19 Aug 2004 19:21:49 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040819172149.4F6981102F@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 98EAF214
	for <alsa-devel@alsa-project.org>; Thu, 19 Aug 2004 19:21:49 +0200 (MEST)
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


A BUGNOTE has been added to this bug.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000418
======================================================================
Reported By:                ronis
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     418
Category:                   PCI - atiixp-modem
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             08-02-2004 19:43 CEST
Last Modified:              08-19-2004 19:21 CEST
======================================================================
Summary:                    loading atiixp-modem and slmodemd corrupts part of atiixp driver
Description: 
I've managed to get both sound and modem drivers working with the CVS
sources (and with alot of help from you guys).  If I simply load the sound
modules
(i.e., snd_atiixp and oss emulator), sound works as expected.  If I
subsequently load the atiixp_modem driver, part of the sound system still
works (e.g., the zinf mp3 player with the native alsa plugin), however
other sound applications don't work properly--the sound is played far too
quicky.

This happens whether or not I'm actually using the modem, and persists
even after I stop slmodemd and unload the snd_atiixp_modem module.

======================================================================

----------------------------------------------------------------------
 netstar - 08-03-2004 00:44 CEST 
----------------------------------------------------------------------
I am also having issues with the modem, although not the sound card.  Both
drivers load fine (CVS alsa-driver, kernel and lib), sound also works
fine, it is normally loaded as my second device hw:1, fine.  When using
slmodemd with the modem device things seem ok until I try dialing and it
is reported to me that there is no DIALTONE.  After disabling DIALTONE
detection with ATX3, subsequent ATDT attempts return NO CARRIER.  

When listening on the device with arecord for example and outputting to
STDOUT, I get a constant hiss, however when I pick up a phone on the line
it appears that the device does notice this as the constant hissing is
interupted when either opening or closing the line elsewhere.

I do not believe the modem is broken as has been suggested to me before.

Attatched is an slmodem log of a dialing attempt and some system
information including card register information whilst dialing.  I hope
this helps.

----------------------------------------------------------------------
 ronis - 08-03-2004 04:08 CEST 
----------------------------------------------------------------------
netstar, 

The problem you are describing is the same one I reported in bug report
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000413.  The problem is not alsa, but slmodemd (at least in version 2.9.9). 
You have to make a 1 line fix
to the file modem/modem_cmdline.c (at line 240) add the following test
before the assignment:

if(strcmp(modem_dev_name,"/dev/slamr0")==0)
     modem_dev_name = modem_alsa_dev_name;

After building (with ALSA support enabled) and installing slmodemd, you
install the driver (modprobe snd_atiixp_modem) and run

slmodemd --alsa --country=YourCountry modem:1.
If all goes well, you have a modem at /dev/ttySL0. (Note that I have the
atiixp sound driver already installed as device 0).

It works (I'm using it to send this).

I've reported the bug and fix to the slmodem authors.

In any event, this is not the same problem as I've reported here.

----------------------------------------------------------------------
 ronis - 08-09-2004 16:39 CEST 
----------------------------------------------------------------------
Reminder sent to tiwai

I hate being a nag, but this problem kills sound every time I run the
modem driver.

David


----------------------------------------------------------------------
 tiwai - 08-19-2004 19:21 CEST 
----------------------------------------------------------------------
It seems there are some linked clock between audio and modem.
Perhaps when you use the modem, only 48k is possible.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
08-02-04 19:43 ronis          New Bug                                      
08-03-04 00:40 netstar        File Added: systeminfo.txt                    
08-03-04 00:43 netstar        File Added: slmodem.log.modem                    
08-03-04 00:44 netstar        Bugnote Added: 0001526                       
08-03-04 04:08 ronis          Bugnote Added: 0001527                       
08-09-04 16:39 ronis          Bugnote Added: 0001546                       
08-19-04 19:21 tiwai          Bugnote Added: 0001595                       
======================================================================


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
