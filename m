From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000474]: Compiling with -Wshadow generates warning messages with gcc-2.95
Date: Tue, 31 Aug 2004 12:42:52 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040831104252.4D73D3F019@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id A9B231C6
	for <alsa-devel@alsa-project.org>; Tue, 31 Aug 2004 12:42:52 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000474
======================================================================
Reported By:                erikd-alsa
Assigned To:                
======================================================================
Project:                    ALSA - lib
Bug ID:                     474
Category:                   pcm - digital audio
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             08-30-2004 12:52 CEST
Last Modified:              08-31-2004 12:42 CEST
======================================================================
Summary:                    Compiling with -Wshadow generates warning messages with gcc-2.95
Description: 
In file included from /usr/include/alsa/asoundlib.h:49,
                 from alsa.c:3:
/usr/include/alsa/pcm.h:535: warning: declaration of `access' shadows
global declaration
/usr/include/alsa/pcm.h:536: warning: declaration of `access' shadows
global declaration
/usr/include/alsa/pcm.h:537: warning: declaration of `access' shadows
global declaration
/usr/include/alsa/pcm.h:538: warning: declaration of `access' shadows
global declaration
/usr/include/alsa/pcm.h:539: warning: declaration of `access' shadows
global declaration
/usr/include/alsa/pcm.h:1260: warning: declaration of `access' shadows
global declaration
/usr/include/alsa/pcm.h:1270: warning: declaration of `access' shadows
global declaration
In file included from /usr/include/alsa/asoundlib.h:52,
                 from alsa.c:3:
/usr/include/alsa/hwdep.h:142: warning: declaration of `index' shadows
global declaration
In file included from /usr/include/alsa/asoundlib.h:56,
                 from alsa.c:3:
/usr/include/alsa/seq.h:363: warning: declaration of `index' shadows
global declaration

======================================================================

----------------------------------------------------------------------
 tiwai - 08-31-2004 12:42 CEST 
----------------------------------------------------------------------
They are quite harmless, although it'd be better to be fixed.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
08-30-04 12:52 erikd-alsa     New Bug                                      
08-31-04 12:42 tiwai          Bugnote Added: 0001672                       
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
