From: noreply@alsa-project.org
Subject: [ALSA - driver 0000144]: doc typo
Date: Fri, 16 Jul 2004 13:05:38 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716110538.9025226008@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 1F0A4255
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 13:05:39 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000144
======================================================================
Reported By:                piem
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Bug ID:                     144
Category:                   CORE - sequencer
Reproducibility:            N/A
Severity:                   trivial
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             03-18-2004 00:58 CET
Last Modified:              07-16-2004 13:05 CEST
======================================================================
Summary:                    doc typo
Description: 
on http://www.alsa-project.org/alsa-doc/alsa-lib/seq.html
in the filter application code snipnet, one should read
 snd_seq_event_output(seq, ev);
instead of
 snd_seq_event_output(seq, &ev);
since ev is declared as a pointer in this function.
======================================================================

----------------------------------------------------------------------
 perex - 03-23-2004 16:25 CET 
----------------------------------------------------------------------
Fixed in CVS. Thanks.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
03-18-04 00:58 piem           New Bug                                      
03-23-04 16:25 perex          Bugnote Added: 0000667                       
03-23-04 16:25 perex          Assigned To               => perex           
03-23-04 16:25 perex          Resolution               open => fixed       
03-23-04 16:25 perex          Status                   new => resolved     
07-16-04 13:05 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
