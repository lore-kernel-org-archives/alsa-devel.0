From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000399]: Audigy ls + gameport
Date: Fri, 27 Aug 2004 20:17:31 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040827181731.450A02C008@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 760E71ED
	for <alsa-devel@alsa-project.org>; Fri, 27 Aug 2004 20:17:31 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000399
======================================================================
Reported By:                eric
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     399
Category:                   OTHERS
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     closed
Distribution:               Fedora core 1
Kernel Version:             kernel 2.6.7
======================================================================
Date Submitted:             07-20-2004 23:24 CEST
Last Modified:              08-27-2004 20:17 CEST
======================================================================
Summary:                    Audigy ls + gameport
Description: 
no audigy ls support for gameport analog in standard kernel 
(2.6.7)
and no patch in alsa cvs files.


======================================================================

----------------------------------------------------------------------
 jcdutton - 07-21-2004 20:47 CEST 
----------------------------------------------------------------------
I sent this patch to the maintainer for emu10k1-gp.c a few weeks ago.
So, it should be appearing in the kernel some time soon.
A similar line is used to the emu10k1x.

----------------------------------------------------------------------
 jcdutton - 08-27-2004 20:17 CEST 
----------------------------------------------------------------------
patch already sent to emu10k1-gp.c.
Not an ALSA related problem.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
07-20-04 23:24 eric           New Bug                                      
07-20-04 23:24 eric           Distribution              => Fedora core 1   
07-20-04 23:24 eric           Kernel Version            => kernel 2.6.7    
07-21-04 20:47 jcdutton       Bugnote Added: 0001463                       
08-27-04 20:17 jcdutton       Bugnote Added: 0001654                       
08-27-04 20:17 jcdutton       Status                   new => closed       
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
