From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000163]: Noisy sound
Date: Fri, 1 Apr 2005 22:51:56 +0200
Message-ID: <646b62593e686a6300682dd3a9b24ac9@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 14BDA235
	for <alsa-devel@alsa-project.org>; Fri,  1 Apr 2005 22:51:57 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=163> 
======================================================================
Reported By:                eduardolinux
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   163
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Slackware
Kernel Version:             2.4.22
======================================================================
Date Submitted:             03-29-2004 15:39 CEST
Last Modified:              04-01-2005 22:51 CEST
======================================================================
Summary:                    Noisy sound
Description: 
I have a ECS K7VTA3v5 maniboard with a KT333 chipset with a onboard sound
witch uses the via82cxxx_audio module on OSS. Well, I tried to use ALSA on
Slackware 9.1 (kernel 2.4.22) and the sound has a noisy background sound.
======================================================================

----------------------------------------------------------------------
 tiwai - 04-13-04 19:44 
----------------------------------------------------------------------
try a different value of dxs_support module option.

----------------------------------------------------------------------
 jdthood - 04-01-05 22:51 
----------------------------------------------------------------------
Submitter: Has there been any improvement with more recent ALSA releases?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-29-04 15:39 eduardolinux   New Issue                                    
03-29-04 15:39 eduardolinux   Distribution              => Slackware       
03-29-04 15:39 eduardolinux   Kernel Version            => 2.4.22          
04-06-04 09:56 robin_root     Issue Monitored: robin_root                    
04-13-04 19:44 tiwai          Note Added: 0000797                          
04-01-05 22:51 jdthood        Note Added: 0004293                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
