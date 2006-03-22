From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000623]: No volume control on SPDIF on cmedia CMI8738-MC6
Date: Wed, 22 Mar 2006 02:43:26 +0100
Message-ID: <ac54749aac07c3ec8b749d73157648c3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4F34A18D
	for <alsa-devel@alsa-project.org>; Wed, 22 Mar 2006 02:43:26 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=623> 
======================================================================
Reported By:                mtempels
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   623
Category:                   PCI - cmipci
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               Ubuntu Linux 4.10
Kernel Version:             Linux bubbles 2.6.8.1-3-386 #1 Tue Oct 12 12:41:57
BST 2004 i686 GNU/Linux
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             11-02-2004 11:24 CET
Last Modified:              03-22-2006 02:43 CET
======================================================================
Summary:                    No volume control on SPDIF on cmedia CMI8738-MC6
Description: 
There is no way to control the output volume on the SPDIF/out on my CMI8738
soundcard. It can just be switched on or off..
======================================================================

----------------------------------------------------------------------
 tiwai - 11-12-04 14:32 
----------------------------------------------------------------------
The kernel context is non-preemtive unless the preemptive option is used. 
Also, no floating point calculation and no SIMD operations are allowed on
the kernel space.  Thus this kind of job can be better done on the user
space than on the kernel space.

In addition, the handling of intermediate buffer (not necessarily
physically linear) would be much easier on user space than on the kernel
space in general, too.

----------------------------------------------------------------------
 rlrevell - 03-22-06 02:43 
----------------------------------------------------------------------
Not a bug

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-02-04 11:24 mtempels       New Issue                                    
11-02-04 11:24 mtempels       Distribution              => Ubuntu Linux 4.10
11-02-04 11:24 mtempels       Kernel Version            => Linux bubbles
2.6.8.1-3-386 #1 Tue Oct 12 12:41:57 BST 2004 i686 GNU/Linux
11-09-04 18:56 tiwai          Note Added: 0002337                          
11-09-04 19:01 mtempels       Note Added: 0002340                          
11-09-04 19:18 tiwai          Note Added: 0002342                          
11-09-04 20:15 mtempels       Note Added: 0002352                          
11-10-04 03:56 cltien         Note Added: 0002355                          
11-10-04 03:59 cltien         Note Added: 0002356                          
11-10-04 10:12 mtempels       Note Added: 0002359                          
11-10-04 12:13 tiwai          Note Added: 0002366                          
11-12-04 14:03 cltien         Note Added: 0002395                          
11-12-04 14:32 tiwai          Note Added: 0002396                          
03-22-06 02:43 rlrevell       Status                   assigned => closed  
03-22-06 02:43 rlrevell       Note Added: 0008783                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
