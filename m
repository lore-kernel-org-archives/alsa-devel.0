From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001006]: soundcard not supported
Date: Mon, 19 Sep 2005 10:14:52 +0200
Message-ID: <6e5d2864897f3721b96c52d77bd432b3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6223F13A
	for <alsa-devel@alsa-project.org>; Mon, 19 Sep 2005 10:14:52 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1006> 
======================================================================
Reported By:                devas
Assigned To:                jdthood
======================================================================
Project:                    ALSA - driver
Issue ID:                   1006
Category:                   ISA - cs4236
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     resolved
Distribution:               c't-debian
Kernel Version:             2.4.27
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             03-22-2005 21:18 CET
Last Modified:              09-19-2005 10:14 CEST
======================================================================
Summary:                    soundcard not supported
Description: 
configure: error: Unsupported soundcard cs4236

======================================================================

----------------------------------------------------------------------
 devas - 03-22-05 21:49 
----------------------------------------------------------------------
./configure --with-cards=emu10k1 tells me same message: seems to be a
problem with the kernel and/or the sources (kernel-headers), i suppose (as
i have a custom kernel).

----------------------------------------------------------------------
 jdthood - 09-19-05 10:14 
----------------------------------------------------------------------
This was a local problem.  The user could not compile the drivers.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-22-05 21:18 devas          New Issue                                    
03-22-05 21:18 devas          Distribution              => c't-debian      
03-22-05 21:18 devas          Kernel Version            => 2.4.27          
03-22-05 21:28 devas          Note Added: 0004132                          
03-22-05 21:49 devas          Note Added: 0004133                          
09-19-05 10:14 jdthood        Status                   new => resolved     
09-19-05 10:14 jdthood        Resolution               open => not an issue
09-19-05 10:14 jdthood        Assigned To               => jdthood         
09-19-05 10:14 jdthood        Note Added: 0006289                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
