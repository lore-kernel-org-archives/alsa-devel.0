From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002123]: Power Management is broken
	following changes from 1.0.10 to 1.0.11.x versions
Date: Sat, 22 Jul 2006 22:49:14 +0200
Message-ID: <51b175cc3d56b3a90b14f6f4bc4769fe@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2349824E
	for <alsa-devel@alsa-project.org>;
	Sat, 22 Jul 2006 22:49:15 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2123> 
======================================================================
Reported By:                jovial
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2123
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               gentoo
Kernel Version:             2.6.16
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             05-13-2006 17:37 CEST
Last Modified:              07-22-2006 22:49 CEST
======================================================================
Summary:                    Power Management is broken following changes from
1.0.10 to 1.0.11.x versions
Description: 
I had linux kernel 2.6.15 on my machine (with alsa version 1.0.10).
I could place my laptop on standby while playing music, and onced resumed
the playback would also continue..... proper functionality and power
management.

following an upgrade to kernel 2.6.16 with latest patches (includes alsa
1.0.11-rc4), the power management does not function correctly.
basically, i have to restart the alsasound service after resume to have
any sound again.
======================================================================

----------------------------------------------------------------------
 tiwai - 05-15-06 12:11 
----------------------------------------------------------------------
ALSA CVS repo is dead and the code there is pretty outdated.
Use HG repo (better from rsync) instead.

----------------------------------------------------------------------
 jovial - 05-15-06 13:15 
----------------------------------------------------------------------
OMG, i have no idea how i got mislead into CVS sources...
the good news is that the HG sources have resolved my issue...
I couldn't get the alsa in kernel-2.6.17-rc4 working, but alsa-driver is
working fine, so i've disabled alsa in kernel.

i'm surprised how much your latest alsa-kernel files differ from the alsa
files on kernel-2.6.17-rc4 source tree. i guess once your latest
alsa-kernel files make it into kernel source, the alsa in kernel would be
fixed too.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-13-06 17:37 jovial         New Issue                                    
05-13-06 17:37 jovial         Distribution              => gentoo          
05-13-06 17:37 jovial         Kernel Version            => 2.6.16          
05-13-06 17:41 jovial         Note Added: 0009797                          
05-13-06 18:27 rlrevell       Note Added: 0009798                          
05-14-06 00:11 jovial         Note Added: 0009801                          
05-14-06 00:27 rlrevell       Note Added: 0009802                          
05-14-06 02:32 jovial         Note Added: 0009804                          
05-14-06 02:42 rlrevell       Note Added: 0009805                          
05-14-06 05:16 jovial         Note Added: 0009806                          
05-15-06 12:11 tiwai          Note Added: 0009819                          
05-15-06 13:15 jovial         Note Added: 0009821                          
07-22-06 22:49 Adrian Bunk    Status                   assigned => resolved
07-22-06 22:49 Adrian Bunk    Resolution               open => fixed       
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
