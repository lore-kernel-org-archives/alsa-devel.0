From: noreply@alsa-project.org
Subject: [ALSA - lib 0000293]: alsa-lib does not compile with current GCC CVS head
Date: Fri, 16 Jul 2004 13:03:37 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716110337.3B37626008@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 724EC255
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 13:03:37 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000293
======================================================================
Reported By:                robmoss2k
Assigned To:                tiwai
======================================================================
Project:                    ALSA - lib
Bug ID:                     293
Category:                   general
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
======================================================================
Date Submitted:             05-21-2004 14:06 CEST
Last Modified:              07-16-2004 13:03 CEST
======================================================================
Summary:                    alsa-lib does not compile with current GCC CVS head
Description: 
GCC 3.3.x and 3.4.x deprecate the use of cast expressions as lvalues. This
behaviour causes an error, rather than a warning, in current GCC CVS head.
Also, there is an issue with the unary operator which I'm slightly unsure
of the fix on, although things do appear to work.

The patch attached allows the compilation of alsa-lib-1.0.4 with this
version of GCC.
======================================================================

----------------------------------------------------------------------
 robmoss2k - 05-21-2004 14:08 CEST 
----------------------------------------------------------------------
NB: The questionable bit of the patch is the very last bit. I just removed
the ampersand; I'm not sure if this is correct, I'm a little rusty!

----------------------------------------------------------------------
 tiwai - 05-21-2004 15:12 CEST 
----------------------------------------------------------------------
the last one is wrong.  simply removing the cast is ok.
snd_config_get_integer() takes long *, anyway.

the other parts were already fixed on ALSA cvs in other way...

----------------------------------------------------------------------
 tiwai - 05-25-2004 12:59 CEST 
----------------------------------------------------------------------
fixed on 1.0.5.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
05-21-04 14:06 robmoss2k      New Bug                                      
05-21-04 14:06 robmoss2k      File Added: alsa-lib-1.0.4-gcc35.patch                    
05-21-04 14:08 robmoss2k      Bugnote Added: 0001164                       
05-21-04 15:12 tiwai          Bugnote Added: 0001165                       
05-25-04 12:59 tiwai          Bugnote Added: 0001208                       
05-25-04 12:59 tiwai          Assigned To               => tiwai           
05-25-04 12:59 tiwai          Resolution               open => fixed       
05-25-04 12:59 tiwai          Status                   new => resolved     
07-16-04 13:03 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
