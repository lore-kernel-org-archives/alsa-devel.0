From: noreply@alsa-project.org
Subject: [ALSA - tools 0000340]: Error in alsa-tools/seq/sbiload/Makefile.am
Date: Fri, 16 Jul 2004 12:56:11 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716105611.9626D26008@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id CF210244
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 12:56:11 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000340
======================================================================
Reported By:                linus
Assigned To:                tiwai
======================================================================
Project:                    ALSA - tools
Bug ID:                     340
Category:                   firmware loaders
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
======================================================================
Date Submitted:             06-20-2004 09:55 CEST
Last Modified:              07-16-2004 12:56 CEST
======================================================================
Summary:                    Error in alsa-tools/seq/sbiload/Makefile.am
Description: 
In the alsa-tools module of the CVS, the seq/sbiload/Makefile.am has an
incomplete EXTRA_DIST line, omitting several important files that must be
included in the dist. tar.gz-files. It currently reads:
                                                                          
     
 EXTRA_DIST = README COPYING depcomp
                                                                          
     
But shall read:
                                                                          
     
 EXTRA_DIST = README COPYING depcomp drums.o3 drums.sb std.o3 std.sb
                                                                          
     
Or the instrument patches does not come with the install... Perhaps these
should also be:
                                                                          
     
 sbiload_DATA = drums.o3 drums.sb std.o3 std.sb
                                                                          
     
or similar so that the instruments get installed in /usr/share or
similar.
(Not 100% about the syntax here right now.)

======================================================================

----------------------------------------------------------------------
 tiwai - 06-30-2004 16:06 CEST 
----------------------------------------------------------------------
fixed on cvs.
also, sbiload has a new option -P option to specify the patch path.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
06-20-04 09:55 linus          New Bug                                      
06-30-04 16:06 tiwai          Bugnote Added: 0001354                       
06-30-04 16:06 tiwai          Assigned To               => tiwai           
06-30-04 16:06 tiwai          Resolution               open => fixed       
06-30-04 16:06 tiwai          Status                   new => resolved     
07-16-04 12:56 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
