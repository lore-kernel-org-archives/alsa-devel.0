From: noreply@alsa-project.org
Subject: [ALSA - lib 0000161]: EVERY time a sound is played a kernel message is generated - Unexpected hw_pointer value etc.
Date: Fri, 16 Jul 2004 13:03:02 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716110302.F00F326008@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 71FD3255
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 13:03:03 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000161
======================================================================
Reported By:                andywebsdale
Assigned To:                tiwai
======================================================================
Project:                    ALSA - lib
Bug ID:                     161
Category:                   general
Reproducibility:            always
Severity:                   trivial
Priority:                   normal
Status:                     closed
======================================================================
Date Submitted:             03-28-2004 00:07 CET
Last Modified:              07-16-2004 13:03 CEST
======================================================================
Summary:                    EVERY time a sound is played a kernel message is generated - Unexpected hw_pointer value etc.
Description: 
EVERY time a sound is played (on a cm8738 card) a kernel message is
generated - 
"ALSA sound/core/pcm_lib.c:195: Unexpected hw_pointer value [1] (stream =
0, delta: -4, max jitter = 5512): wrong interrupt acknowledge?" It doesn't
affect sound quality, I know BUT it does happen a lot & probably
represents 50%+ of non-boot kernel messages logged 
======================================================================

----------------------------------------------------------------------
 tiwai - 03-28-2004 17:34 CEST 
----------------------------------------------------------------------
the message is suppressed as default in 1.0.4.

----------------------------------------------------------------------
 andywebsdale - 04-01-2004 22:05 CEST 
----------------------------------------------------------------------
I am running alsa-lib version 1.0.4 & a message is still appearing.However
I am using the 2.6.4 kernel - will this disappear with 2.6.5?
Sorry If I've reopened this in error as I've just checked & I see that my
driver is 1.0.2, tho' my alsa-lib is 1.0.4- you should probably disregard
this mistaken reopening by me.

edited on: 04-01-04 22:05

----------------------------------------------------------------------
 tiwai - 04-13-2004 19:23 CEST 
----------------------------------------------------------------------
yes, you have to update ALSA kernel drivers, not only library.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
03-28-04 00:07 andywebsdale   New Bug                                      
03-28-04 00:57 andywebsdale   Bug Monitored: andywebsdale                    
03-28-04 17:34 tiwai          Bugnote Added: 0000712                       
03-28-04 17:34 tiwai          Assigned To               => tiwai           
03-28-04 17:34 tiwai          Resolution               open => fixed       
03-28-04 17:34 tiwai          Status                   new => resolved     
04-01-04 15:47 andywebsdale   Status                   resolved => feedback
04-01-04 15:47 andywebsdale   Bugnote Added: 0000731                       
04-01-04 15:47 andywebsdale   Resolution               fixed => reopened   
04-01-04 22:05 andywebsdale   Bugnote Edited: 0000731                      
04-13-04 19:23 tiwai          Bugnote Added: 0000789                       
04-13-04 19:23 tiwai          Resolution               reopened => fixed   
04-13-04 19:23 tiwai          Status                   feedback => resolved
07-13-04 16:13 wacsob         Bug Monitored: wacsob                        
07-16-04 13:03 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
