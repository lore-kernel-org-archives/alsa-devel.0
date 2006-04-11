From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001138]: errors when installing au8820 modules
Date: Tue, 11 Apr 2006 04:41:53 +0200
Message-ID: <15059b86afd2a2a8963de7d4831293e8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7272F128
	for <alsa-devel@alsa-project.org>; Tue, 11 Apr 2006 04:41:53 +0200 (MEST)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1138> 
======================================================================
Reported By:                penguinparty
Assigned To:                mjander
======================================================================
Project:                    ALSA - driver
Issue ID:                   1138
Category:                   PCI - au88x0
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     assigned
Distribution:               ubuntu 5.04
Kernel Version:             2.6.11.11 2.6.11.8 and 2.6.10
======================================================================
Date Submitted:             05-28-2005 22:22 CEST
Last Modified:              04-11-2006 04:41 CEST
======================================================================
Summary:                    errors when installing au8820 modules
Description: 
Please see the section additional information for a dump of my dmesg output
regarding the au8820 module.

I have tried installing this module using 2.6.11.11 2.6.11.8 and 2.6.10
kernels. The shipping alsa support under each of these kerenls provies me
with the same result. I have also tried installing each of these kernels
without alsa support only CONFIG_SOUND and then installing the
alsa-drivers 1.0.9rc4a

I get the same result every time I do the modprobe snd-au8820

Using older versions of debian as well as the ubuntu live cd's I am able
to get this sound card working.
======================================================================

----------------------------------------------------------------------
 Raymond - 03-01-06 08:14 
----------------------------------------------------------------------
Would any of you try the au88x0_surround40.patch (alsa-driver-1.0.11rc3) to
see if there is any side effect on au8820 ? 

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1726

----------------------------------------------------------------------
 Raymond - 04-11-06 04:41 
----------------------------------------------------------------------
Do you get oops when using aplaymidi on your 64-bits machines with
alsa-1.0.11rc4 ?

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1833

Do that bug only occur on EM64T ?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-28-05 22:22 penguinparty   New Issue                                    
05-28-05 22:22 penguinparty   Distribution              => ubuntu 5.04     
05-28-05 22:22 penguinparty   Kernel Version            => 2.6.11.11 2.6.11.8
and 2.6.10
05-28-05 22:22 penguinparty   Issue Monitored: penguinparty                    
06-08-05 04:41 penguinparty   File Added: typescript                       
06-08-05 04:43 penguinparty   Note Added: 0004914                          
08-24-05 10:55 Raymond        Note Added: 0005925                          
08-24-05 10:58 Raymond        Note Added: 0005926                          
08-24-05 10:59 Raymond        Note Deleted: 0005926                        
09-01-05 04:24 penguinparty   File Added: make-typescript                    
09-01-05 04:25 penguinparty   Note Added: 0005993                          
09-01-05 05:58 Raymond        Note Added: 0005994                          
09-02-05 02:49 penguinparty   Note Added: 0006002                          
09-02-05 05:49 Raymond        Note Added: 0006003                          
11-16-05 06:29 Raymond        Note Added: 0006736                          
11-23-05 13:50 Raymond        Note Added: 0006810                          
01-02-06 10:07 Raymond        Note Deleted: 0006810                        
01-05-06 09:51 Raymond        Note Deleted: 0006736                        
01-05-06 10:01 Raymond        Note Added: 0007465                          
03-01-06 08:14 Raymond        Note Added: 0008276                          
04-11-06 04:41 Raymond        Note Added: 0009225                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
