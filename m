From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001442]: snapper: no sound after resume
Date: Sun, 30 Jul 2006 16:09:58 +0200
Message-ID: <27fd1e0bf1b195c3d3c22fbcc4152e1b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id F063A168
	for <alsa-devel@alsa-project.org>;
	Sun, 30 Jul 2006 16:09:58 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1442> 
======================================================================
Reported By:                Johannes Berg
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1442
Category:                   PPC - powermac
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               debian
Kernel Version:             2.6.13
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             09-22-2005 17:32 CEST
Last Modified:              07-30-2006 16:09 CEST
======================================================================
Summary:                    snapper: no sound after resume
Description: 
After resuming from suspend to disk there's no sound with a snapper chip on
a post-february 2005 powerbook.

alsactl restore doesn't help, the only way I have managed to work around
this is to reload the module
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0000057 Kernel device in bad state after suspen...
======================================================================

----------------------------------------------------------------------
 Johannes Berg - 07-07-06 19:37 
----------------------------------------------------------------------
Please close (I cannot) -- I've obsoleted snd-powermac for that hardware
with snd-aoa myself (and sleep works)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-22-05 17:32 Johannes Berg  New Issue                                    
09-22-05 17:32 Johannes Berg  Distribution              => debian          
09-22-05 17:32 Johannes Berg  Kernel Version            => 2.6.13          
09-22-05 17:32 Johannes Berg  Issue Monitored: Johannes Berg                    
09-29-05 20:55 jdthood        Relationship added       duplicate of 0000057
07-07-06 19:37 Johannes Berg  Note Added: 0010919                          
07-30-06 16:09 Adrian Bunk    Status                   assigned => resolved
07-30-06 16:09 Adrian Bunk    Resolution               open => fixed       
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
