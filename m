From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001153]: Unresolved class_device_* symbols with Linux 2.4.27
Date: Wed, 8 Jun 2005 15:09:32 +0200
Message-ID: <e88c7143301dcd2e0b8696639fec436b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5F704172
	for <alsa-devel@alsa-project.org>; Wed,  8 Jun 2005 15:09:32 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1153> 
======================================================================
Reported By:                jdthood
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1153
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             06-04-2005 16:06 CEST
Last Modified:              06-08-2005 15:09 CEST
======================================================================
Summary:                    Unresolved class_device_* symbols with Linux 2.4.27
Description: 
I built 1.0.9a --with-cards=all against Debian's latest 2.4.27 kernel
headers and got unresolved symbols:

# depmod -e -a -F /boot/System.map-2.4.27-2-686 2.4.27-2-686depmod: ***
Unresolved symbols in /lib/modules/2.4.27-2-686/updates/alsa/snd.o
depmod:         class_device_destroy
depmod:         class_device_create

======================================================================

----------------------------------------------------------------------
 jdthood - 06-06-05 14:11 
----------------------------------------------------------------------
I attached a patch that fixes the problem well enough to allow modules to
be loaded on Linux 2.4.  The patch suppresses the apparently unused (under
Linux 2.4) declarations of class_device_create() and
class_device_destroy().   I don't know whether or not the patch solves the
problem in a kosher way and I don't know whether sensible arguments for
KERNEL_VERSION() have been used.

----------------------------------------------------------------------
 tiwai - 06-08-05 15:09 
----------------------------------------------------------------------
Fixed on 1.0.9b.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-04-05 16:06 jdthood        New Issue                                    
06-04-05 23:24 jdthood        Note Added: 0004888                          
06-04-05 23:25 jdthood        Description Updated                          
06-06-05 14:07 jdthood        File Added: 17_class_device_fix.dpatch            
       
06-06-05 14:11 jdthood        Note Added: 0004908                          
06-08-05 15:09 tiwai          Status                   assigned => resolved
06-08-05 15:09 tiwai          Resolution               open => fixed       
06-08-05 15:09 tiwai          Note Added: 0004930                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
