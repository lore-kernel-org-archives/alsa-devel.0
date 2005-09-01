From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001138]: errors when installing au8820 modules
Date: Thu, 1 Sep 2005 05:58:09 +0200
Message-ID: <915deb795d3410be6793bc698b3ee0b7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C3ECD1D9
	for <alsa-devel@alsa-project.org>; Thu,  1 Sep 2005 05:58:09 +0200 (MEST)
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
Last Modified:              09-01-2005 05:58 CEST
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
 penguinparty - 09-01-05 04:25 
----------------------------------------------------------------------
Compile fails . . . see makefile-typescript

----------------------------------------------------------------------
 Raymond - 09-01-05 05:58 
----------------------------------------------------------------------
There is a thread related to the AMD64 problems for au88x0 in openvortex
developer mailing list mailto:openvortex-dev@nongnu.org

http://lists.nongnu.org/archive/html/openvortex-dev/2005-06/msg00002.html

The error in you make-typescript is related to au8810


You should use ./configure --with-cards=au8820

You can ask Maarten Vanraes for his au8810 patch in
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0001047

or 

Igor V. Kovalenko au8820 patch in #3948 overview: patch to fix oopses on
amd64

http://savannah.nongnu.org/patch/?group=openvortex


Do you have left/right channels problem on your au8820 ?
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0000059

lspci -vvn

cat /proc/asound/au8820/codec97#0/ac97#0-0+regs

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
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
