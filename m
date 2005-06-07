From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001163]: Two modprobe calls lack path
Date: Tue, 7 Jun 2005 09:04:19 +0200
Message-ID: <c60be01aa76f80eecf2fad80f1f88052@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (unknown [195.113.161.147])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 18625142
	for <alsa-devel@alsa-project.org>; Tue,  7 Jun 2005 09:04:20 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1163> 
======================================================================
Reported By:                jdthood
Assigned To:                perex
======================================================================
Project:                    ALSA - utils
Issue ID:                   1163
Category:                   alsaconf
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             06-06-2005 19:50 CEST
Last Modified:              06-07-2005 09:04 CEST
======================================================================
Summary:                    Two modprobe calls lack path
Description: 
All but two calls to modprobe in alsaconf call it with the full path.  For
consistency the remaining two calls should also use the full path.

--- alsaconf.in_ORIG    2005-06-06 19:49:00.000000000 +0200
+++ alsaconf.in 2005-06-06 19:50:06.000000000 +0200
@@ -753,7 +753,7 @@
     if $lsmod | grep -q -E '^(snd-|snd_)'$1' '; then
        : ;
     else
-       modprobe -r snd-$1 >/dev/null 2>&1
+       /sbin/modprobe -r snd-$1 >/dev/null 2>&1
        return 1
     fi

@@ -792,7 +792,7 @@
     if $lsmod | grep -q -E '^(snd-|snd_)'$1' '; then
        : ;
     else
-       modprobe -r snd-$1 >/dev/null 2>&1
+       /sbin/modprobe -r snd-$1 >/dev/null 2>&1
        return 1
     fi

======================================================================

----------------------------------------------------------------------
 perex - 06-07-05 09:04 
----------------------------------------------------------------------
Fixed in CVS. Thanks.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-06-05 19:50 jdthood        New Issue                                    
06-07-05 09:04 perex          Status                   new => resolved     
06-07-05 09:04 perex          Resolution               open => fixed       
06-07-05 09:04 perex          Assigned To               => perex           
06-07-05 09:04 perex          Note Added: 0004911                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
