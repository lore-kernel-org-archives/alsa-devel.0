From: noreply@alsa-project.org
Subject: [ALSA - lib 0000246]: Mixer: callbacks not triggered for mixer elements of type ENUMERATED
Date: Fri, 16 Jul 2004 12:51:40 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716105140.509F426008@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 89903255
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 12:51:40 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000246
======================================================================
Reported By:                sshedden
Assigned To:                tiwai
======================================================================
Project:                    ALSA - lib
Bug ID:                     246
Category:                   mixer
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
======================================================================
Date Submitted:             04-28-2004 23:06 CEST
Last Modified:              07-16-2004 12:51 CEST
======================================================================
Summary:                    Mixer: callbacks not triggered for mixer elements of type ENUMERATED
Description: 
I noticed this problem with my own client code, but for the sake of
simplicity it can be demonstrated using amixer.



Running "amixer sevent" registers a callback for each mixer element. In
the case of amixer the callback just prints a message whenever the value
of the element changes. This all works perfectly except, it would seem, in
the case of mixer elements of type ENUMERATED where the associated
callback is not triggered.
======================================================================

----------------------------------------------------------------------
 tiwai - 05-02-2004 14:00 CEST 
----------------------------------------------------------------------
fixed on CVS.
(note that SF's anon-cvs will take a bit time to be sync'ed.)

Bug History
Date Modified  Username       Field                    Change              
======================================================================
04-28-04 23:06 sshedden       New Bug                                      
04-28-04 23:11 sshedden       Bug Monitored: sshedden                      
05-02-04 14:00 tiwai          Bugnote Added: 0001008                       
05-02-04 14:00 tiwai          Assigned To               => tiwai           
05-02-04 14:00 tiwai          Resolution               open => fixed       
05-02-04 14:00 tiwai          Status                   new => resolved     
07-16-04 12:51 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
