From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000505]: SPDIF sound distorted on non-48000 rates
Date: Tue, 9 Nov 2004 16:41:59 +0100
Message-ID: <500033d510b72391a49486831e514990@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 6E25D2B1
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2004 16:41:59 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=505> 
======================================================================
Reported By:                ramendik
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   505
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               RH-based
Kernel Version:             2.6.8.1
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             09-19-2004 10:03 CEST
Last Modified:              11-09-2004 16:41 CET
======================================================================
Summary:                    SPDIF sound distorted on non-48000 rates
Description: 
I have an Intel ICH AC97 sound subsystem, on an Intel i865 motherboard(ASUS
P4P800). It has an analog output and an SPDIF output.When I play 48Khz
files, thinks are OK on all outputs. But when I play 44.1 Khz files, the
sound on the SPDIF output is audibly distorted. The analog output is OK.

I am using the 2.6.8.1 kernel, and tried both the ALSA inside it (1.0.4)
and newer alsa-driver 1.0.7rc1. This same problem shows up with 2.6.6 and
2.6.7 kernels. So apparently it's present across several versons of ALSA.

======================================================================

----------------------------------------------------------------------
 ramendik - 09-29-04 23:11 
----------------------------------------------------------------------
Oops. I wish I could close the bug again. That was an test of the wrong
kernel version.

The version with the patches simply does not output anything to SPDIF when
playing to hw:0,0 .

Somehow some signal did reach SPDIF with the old, wrong version... But
this is no longer a bug, just a missing feature. So please close this bug
again.

----------------------------------------------------------------------
 tiwai - 10-01-04 17:05 
----------------------------------------------------------------------
closed again.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-19-04 10:03 ramendik       New Issue                                    
09-19-04 10:03 ramendik       Distribution              => RH-based        
09-19-04 10:03 ramendik       Kernel Version            => 2.6.8.1         
09-19-04 10:05 ramendik       Issue Monitored: ramendik                    
09-23-04 18:37 tiwai          Note Added: 0001831                          
09-23-04 19:50 ramendik       Note Added: 0001839                          
09-23-04 19:51 ramendik       File Added: ac97#0-0                         
09-23-04 19:52 ramendik       File Added: ac97#0-0+regs                    
09-23-04 19:52 ramendik       Note Added: 0001843                          
09-23-04 19:58 ramendik       Note Added: 0001845                          
09-23-04 20:06 tiwai          Note Added: 0001846                          
09-23-04 20:06 tiwai          File Added: intel-spdif-fix.dif                   

09-23-04 22:16 ramendik       Note Added: 0001852                          
09-24-04 12:14 tiwai          Note Added: 0001871                          
09-24-04 12:16 tiwai          Note Added: 0001872                          
09-24-04 23:42 ramendik       Note Added: 0001906                          
09-27-04 05:20 ramendik       Note Added: 0001931                          
09-27-04 15:14 tiwai          Note Added: 0001938                          
09-27-04 15:14 tiwai          File Added: ich4-spdif.dif                    
09-27-04 15:15 tiwai          File Added: ich4-spdif-lib.dif                    
09-27-04 18:20 Clemens LadischFile Added: ich4-spdif.dif                    
09-27-04 18:22 Clemens LadischNote Added: 0001941                          
09-28-04 23:37 ramendik       Note Added: 0001961                          
09-28-04 23:42 ramendik       Note Added: 0001962                          
09-29-04 18:02 tiwai          Status                   new => resolved     
09-29-04 18:02 tiwai          Resolution               open => fixed       
09-29-04 18:02 tiwai          Assigned To               => tiwai           
09-29-04 18:02 tiwai          Note Added: 0001974                          
09-29-04 21:22 ramendik       Status                   resolved => feedback
09-29-04 21:22 ramendik       Resolution               fixed => reopened   
09-29-04 21:22 ramendik       Note Added: 0001975                          
09-29-04 23:11 ramendik       Note Added: 0001977                          
10-01-04 17:05 tiwai          Status                   feedback => resolved
10-01-04 17:05 tiwai          Resolution               reopened => fixed   
10-01-04 17:05 tiwai          Note Added: 0002001                          
11-09-04 16:41 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
