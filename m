From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000422]: snd-atiixp-modem driver: No CARRIER/DIALTONE.
Date: Sun, 29 Aug 2004 12:10:12 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040829101012.6553439006@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id CA1D923C
	for <alsa-devel@alsa-project.org>; Sun, 29 Aug 2004 12:10:12 +0200 (MEST)
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


The following bug has been RESOLVED.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000422
======================================================================
Reported By:                netstar
Assigned To:                sashak
======================================================================
Project:                    ALSA - driver
Bug ID:                     422
Category:                   PCI - atiixp-modem
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 fixed
======================================================================
Date Submitted:             08-04-2004 01:13 CEST
Last Modified:              08-29-2004 12:10 CEST
======================================================================
Summary:                    snd-atiixp-modem driver: No CARRIER/DIALTONE.
Description: 
I am having issues with the modem, although not the sound card. Both
drivers load fine (CVS alsa-driver, kernel and lib), sound also works
fine, it is normally loaded as my second device "hw:1", fine, although the
problem is persistant with any combination of the two devices. When using
slmodemd with the "modem" device things seem ok until I try dialing and it
is reported to me that there is no DIALTONE. After disabling DIALTONE
detection with ATX3, subsequent ATDT attempts return NO CARRIER.  My
slmodemd was already fixed with a patch sasha sent me some time back.

When listening on the device with arecord for example and outputting to
STDOUT, I get a constant hiss, however when I pick up a phone on the line
it appears that the device does notice this as the constant hissing is
interupted when either opening or closing the line elsewhere.

I do not believe the modem is broken as has been suggested to me before.

Attatched is an slmodem log of a dialing attempt and some system
information including card register information whilst dialing. I hope
this helps.

slmodemd usage:

./slmodemd --alsa modem or modem:0 or modem:1 --country=UK  

 Depending on the card configurations tested.
======================================================================

----------------------------------------------------------------------
 netstar - 08-28-2004 04:20 CEST 
----------------------------------------------------------------------
It appears that the latest patch added by Sasha on the 25th of August fixes
to bug https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000432 resolves the issues with some modems reporting NO DIALTONE. 
Modem and sound card are working fine.

----------------------------------------------------------------------
 sashak - 08-29-2004 12:10 CEST 
----------------------------------------------------------------------
Related fix in cvs now.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
08-04-04 01:13 netstar        New Bug                                      
08-04-04 01:14 netstar        File Added: systeminfo.txt                    
08-04-04 01:16 netstar        File Added: slmodem.log.modem                    
08-04-04 01:17 netstar        File Added: slmodem-2.9.9-fix.patch                    
08-27-04 19:41 tiwai          Assigned To              tiwai =>            
08-27-04 19:42 tiwai          Assigned To               => sashak          
08-28-04 04:20 netstar        Bugnote Added: 0001659                       
08-29-04 12:10 sashak         Bugnote Added: 0001664                       
08-29-04 12:10 sashak         duplicate_id             0 => 432            
08-29-04 12:10 sashak         Resolution               open => fixed       
08-29-04 12:10 sashak         Status                   assigned => resolved
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
