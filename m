From: bugtrack@alsa-project.org
Subject: =?iso-8859-1?Q?[ALSA_-_liboss_0001518]:_dmix_plugin_doesn=B4t_work_with_O?=
 =?iso-8859-1?Q?SS_kernel_emulation?=
Date: Sat, 31 Dec 2005 00:22:00 +0100
Message-ID: <f7db1df6239b54441303df184d8123ab@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 97B3C194
	for <alsa-devel@alsa-project.org>; Sat, 31 Dec 2005 00:22:00 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1518> 
======================================================================
Reported By:                kyromaster
Assigned To:                
======================================================================
Project:                    ALSA - liboss
Issue ID:                   1518
Category:                   
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Resolution:                 reopened
Fixed in Version:           
======================================================================
Date Submitted:             10-31-2005 01:22 CET
Last Modified:              12-31-2005 00:21 CET
======================================================================
Summary:                    dmix plugin doesn´t work with OSS kernel emulation
Description: 
I hope this isn´t misplaced here, but IMHO this is a bug in the
architecture. Many people have those crappy AC97 codecs without hardware
mixing and want to use OSS apps beside their ALSA ones (like teamspeak
together with games). dmix works but not with the kernel emulation, and
"aoss" is not easy enough for newbies and also doesn´t work with all
apps.
So will dmix support be added to the kernel OSS emulation layer?+
======================================================================

----------------------------------------------------------------------
 kyromaster - 12-20-05 01:43 
----------------------------------------------------------------------
Sorry for reopening, but can´t you port dmix or just dmix in kernel-mode as
well? It´s not good for nen-experienced users if they have to run their
apps through a wrapper script.

----------------------------------------------------------------------
 rlrevell - 12-20-05 02:04 
----------------------------------------------------------------------
No.  It would defeat the purpose of implementing dmix in userspace if we
had to maintain a parallel implementation in the kernel.  It would also
preclude the use of SIMD instructions for mixing.

The kernel developers have spoken on this issue and they do not want
mixing in the kernel.  Your distro should just provide a wrapper script
for any OSS app so that it's invisible to the user.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-31-05 01:22 kyromaster     New Issue                                    
10-31-05 05:18 rlrevell       Note Added: 0006582                          
12-20-05 01:20 rlrevell       Status                   new => closed       
12-20-05 01:20 rlrevell       Note Added: 0007098                          
12-20-05 01:43 kyromaster     Status                   closed => feedback  
12-20-05 01:43 kyromaster     Resolution               open => reopened    
12-20-05 01:43 kyromaster     Note Added: 0007099                          
12-20-05 02:04 rlrevell       Note Added: 0007100                          
12-31-05 00:21 rlrevell       Status                   feedback => closed  
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
