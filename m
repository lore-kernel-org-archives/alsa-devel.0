From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000449]: unresolved symbol snd_compat_strlcpy_Rb4409a1e
Date: Thu, 7 Apr 2005 00:09:43 +0200
Message-ID: <653e9a24dd10326ba66c73dbd0c26571@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 3E14D1A3
	for <alsa-devel@alsa-project.org>; Thu,  7 Apr 2005 00:09:43 +0200 (MEST)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=449> 
======================================================================
Reported By:                isotrope
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   449
Category:                   PCI - ens1370
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     closed
Distribution:               Tao Linux (RHEL 3 clone)
Kernel Version:             2.4.21-15.0.4.TL
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             08-17-2004 14:15 CEST
Last Modified:              04-07-2005 00:09 CEST
======================================================================
Summary:                    unresolved symbol snd_compat_strlcpy_Rb4409a1e
Description: 
I am unable to load the kernel module for ALSA. While loading snd.o, I get
the message:
snd-ens1370 /lib/modules/2.4.21-15.0.4.TL/kernel/sound/snd.o: unresolved
symbol snd_compat_strlcpy_Rb4409a1e
/lib/modules/2.4.21-15.0.4.TL/kernel/sound/snd.o: insmod
/lib/modules/2.4.21-15.0.4.TL/kernel/sound/snd.o failed
/lib/modules/2.4.21-15.0.4.TL/kernel/sound/snd.o: insmod snd-ens1370
failed

======================================================================

----------------------------------------------------------------------
 jdthood - 04-07-05 00:09 
----------------------------------------------------------------------
Presumably a local problem.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-17-04 14:15 isotrope       New Issue                                    
08-17-04 14:15 isotrope       Distribution              => Tao Linux (RHEL 3
clone)
08-17-04 14:15 isotrope       Kernel Version            => 2.4.21-15.0.4.TL
04-07-05 00:09 jdthood        Note Added: 0004353                          
04-07-05 00:09 jdthood        Status                   new => closed       
04-07-05 00:09 jdthood        Resolution               open => not an issue
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
