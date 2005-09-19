From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000885]: usx2y is unsupported in v 1.08 builds
Date: Mon, 19 Sep 2005 10:07:22 +0200
Message-ID: <694e74043fc0e15798278e51d812b559@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 27E4D13A
	for <alsa-devel@alsa-project.org>; Mon, 19 Sep 2005 10:07:22 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=885> 
======================================================================
Reported By:                hamishtpb
Assigned To:                karsten
======================================================================
Project:                    ALSA - driver
Issue ID:                   885
Category:                   USB - usb-usx2y
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               Gentoo 2004.3
Kernel Version:             2.4.28-Gentoo-r5
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             02-06-2005 05:57 CET
Last Modified:              09-19-2005 10:07 CEST
======================================================================
Summary:                    usx2y is unsupported in v 1.08 builds
Description: 
Whever I try to build any 1.0.8 alsa-driver I get "unsupported card error"
when I set usb-usx2y as my card. I have manually installed 1.0.7 and the
compile went smoothly.
======================================================================

----------------------------------------------------------------------
 hamishtpb - 02-18-05 16:27 
----------------------------------------------------------------------
OK - rested and refreshed - the problem yesterday was a driver missing from
Kernel :-| D'oh!


So with 2.6 kernel I now have the Tascam working fine. I seem to remember
that the usx2y support went AWOL in a release of ALSA 1.0.3 so maybe
something like that happened again with 1.0.8? Either way I have it
working now in the 2.6 kernel.

----------------------------------------------------------------------
 jdthood - 09-19-05 10:07 
----------------------------------------------------------------------
> I have it working now in the 2.6 kernel.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-06-05 05:57 hamishtpb      New Issue                                    
02-06-05 05:57 hamishtpb      Distribution              => Gentoo 2004.3   
02-06-05 05:57 hamishtpb      Kernel Version            => 2.4.28-Gentoo-r5
02-06-05 05:57 hamishtpb      Issue Monitored: hamishtpb                    
02-06-05 15:53 hamishtpb      Note Added: 0003525                          
02-09-05 11:55 tiwai          Note Added: 0003545                          
02-09-05 12:23 hamishtpb      Note Added: 0003549                          
02-09-05 12:44 hamishtpb      Note Added: 0003551                          
02-09-05 12:53 hamishtpb      Note Edited: 0003551                         
02-11-05 15:42 Clemens LadischNote Added: 0003564                          
02-11-05 17:22 hamishtpb      Note Added: 0003565                          
02-17-05 15:04 hamishtpb      Note Added: 0003628                          
02-17-05 15:05 hamishtpb      Issue End Monitor: hamishtpb                    
02-17-05 18:19 tiwai          Note Added: 0003630                          
02-17-05 20:00 hamishtpb      File Added: config-2.4.28-gentoo-r5               
    
02-17-05 20:02 hamishtpb      Note Added: 0003635                          
02-18-05 16:27 hamishtpb      Note Added: 0003656                          
09-19-05 10:07 jdthood        Status                   assigned => resolved
09-19-05 10:07 jdthood        Resolution               open => fixed       
09-19-05 10:07 jdthood        Note Added: 0006285                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
