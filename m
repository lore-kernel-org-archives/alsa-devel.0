From: noreply@alsa-project.org
Subject: [ALSA - driver 0000152]: driver does not detect my soundcard
Date: Fri, 16 Jul 2004 13:00:27 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716110027.4011A26008@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 988A3244
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 13:00:27 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000152
======================================================================
Reported By:                winjer
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Bug ID:                     152
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Debian
Kernel Version:             2.6.4
======================================================================
Date Submitted:             03-23-2004 16:22 CET
Last Modified:              07-16-2004 13:00 CEST
======================================================================
Summary:                    driver does not detect my soundcard
Description: 
I have an onboard Envy24 on my Chaintech ZNF3-150 mainboard.  The ice1724
driver cannot find it.



======================================================================

----------------------------------------------------------------------
 perex - 03-23-2004 16:30 CET 
----------------------------------------------------------------------
What's in /var/log/messages?
But, I suspect that it's similar problem as https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000142 .

----------------------------------------------------------------------
 winjer - 03-23-2004 16:34 CET 
----------------------------------------------------------------------
The dmesg shows a number of these errors:

invalid EEPROM (size = 255)
ICE1724: probe of 0000:01:0f.0 failed with error -5

----------------------------------------------------------------------
 jcdutton - 03-23-2004 16:39 CET 
----------------------------------------------------------------------
This person is using the following card: 
01:0f.0 Class 0401: 1412:1724 (rev 01)
	Subsystem: 270f:f641
	Flags: bus master, medium devsel, latency 32, IRQ 12
	I/O ports at ac00 [size=32]
	I/O ports at b000 [size=128]
	Capabilities: [80] Power Management version 1

----------------------------------------------------------------------
 perex - 03-23-2004 19:00 CET 
----------------------------------------------------------------------
Yes, it's exactly same hardware as in bug https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000142, so move there.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
03-23-04 16:22 winjer         New Bug                                      
03-23-04 16:22 winjer         Distribution              => Debian          
03-23-04 16:22 winjer         Kernel Version            => 2.6.4           
03-23-04 16:30 perex          Bugnote Added: 0000669                       
03-23-04 16:34 winjer         Bugnote Added: 0000670                       
03-23-04 16:39 jcdutton       Bugnote Added: 0000673                       
03-23-04 19:00 perex          Status                   new => resolved     
03-23-04 19:00 perex          Bugnote Added: 0000690                       
03-23-04 19:00 perex          duplicate_id             0 => 142            
03-23-04 19:00 perex          Assigned To               => perex           
03-23-04 19:00 perex          Resolution               open => duplicate   
07-16-04 13:00 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
