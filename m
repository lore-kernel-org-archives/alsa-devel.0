From: noreply@alsa-project.org
Subject: [ALSA - driver 0000123]: No sound output via SPDIF for unsupported sample rates
Date: Fri, 16 Jul 2004 14:29:35 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716122935.8DE802C005@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id DA7C1244
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 14:29:35 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000123
======================================================================
Reported By:                julian
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     123
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Debian unstable
Kernel Version:             kernel 2.4.24epia1
======================================================================
Date Submitted:             03-07-2004 21:46 CET
Last Modified:              07-16-2004 14:29 CEST
======================================================================
Summary:                    No sound output via SPDIF for unsupported sample rates
Description: 
The new AC97 SPDIF code switches off the SPDIF output if an unsupported PCM
sample rate is requested. The SPDIF rates are 48 kHz, 44.1 kHz and 32 kHz
only. Unfortunately the Via driver doesn't take this into account. The
consequence
is that if you send 16 kHz, or 22.5 kHz to the driver nothing comes out of
the SPDIF port. 



======================================================================

----------------------------------------------------------------------
 tiwai - 03-08-2004 11:45 CET 
----------------------------------------------------------------------
thanks!

your patch is applied to cvs now.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
03-07-04 21:46 julian         New Bug                                      
03-07-04 21:46 julian         File Added: via82xx.patch                    
03-08-04 11:45 tiwai          Bugnote Added: 0000528                       
03-08-04 11:45 tiwai          Assigned To               => tiwai           
03-08-04 11:45 tiwai          Resolution               open => fixed       
03-08-04 11:45 tiwai          Status                   new => resolved     
07-16-04 14:29 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
