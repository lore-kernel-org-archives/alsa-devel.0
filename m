From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000474]: Compiling with -Wshadow generates warning messages with gcc-2.95
Date: Tue, 21 Sep 2004 12:38:23 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040921103823.37E4832005@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 0EC462FA
	for <alsa-devel@alsa-project.org>; Tue, 21 Sep 2004 12:38:23 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000474
======================================================================
Reported By:                erikd-alsa
Assigned To:                tiwai
======================================================================
Project:                    ALSA - lib
Bug ID:                     474
Category:                   pcm - digital audio
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
======================================================================
Date Submitted:             08-30-2004 12:52 CEST
Last Modified:              09-21-2004 12:38 CEST
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

----------------------------------------------------------------------
 tiwai - 09-21-2004 12:38 CEST 
----------------------------------------------------------------------
Fixed on CVS.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
08-30-04 12:52 erikd-alsa     New Bug                                      
08-31-04 12:42 tiwai          Bugnote Added: 0001672                       
09-21-04 12:38 tiwai          Bugnote Added: 0001799                       
09-21-04 12:38 tiwai          Assigned To               => tiwai           
09-21-04 12:38 tiwai          Resolution               open => fixed       
09-21-04 12:38 tiwai          Status                   new => resolved     
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
