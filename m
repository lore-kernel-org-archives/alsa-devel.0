From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000934]: crash in snd-serial-u16550 as non-root user
Date: Wed, 23 Feb 2005 07:42:22 +0100
Message-ID: <6733b8612b669e9ac7641ee65e2783cd@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 5505E1D4
	for <alsa-devel@alsa-project.org>; Wed, 23 Feb 2005 07:42:22 +0100 (MET)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=934> 
======================================================================
Reported By:                laurent
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   934
Category:                   GENERIC - serial-u16550
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.4.29 and 2.6.10
======================================================================
Date Submitted:             02-23-2005 07:42 CET
Last Modified:              02-23-2005 07:42 CET
======================================================================
Summary:                    crash in snd-serial-u16550 as non-root user
Description: 
Whenever I try to use a sequencer application (I tried: seq24, museseq,
rosegarden) as a non-root user, I get a kernel Oops.

I was using alsa-driver 1.0.8 with the 2.4.29 kernel, and the built-in
modules for the 2.6.10 kernel.

If you need more information than the stacks traces and lsmod please ask
and I will do my best to provide them.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-23-05 07:42 laurent        New Issue                                    
02-23-05 07:42 laurent        Distribution              => Gentoo          
02-23-05 07:42 laurent        Kernel Version            => 2.4.29 and 2.6.10
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
