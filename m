From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000735]: Big noise sound at resume
	(back from suspend)
Date: Sun, 30 Jul 2006 16:08:21 +0200
Message-ID: <655e41ee3bbac3e74103d1ebdb1c569a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 446C815E
	for <alsa-devel@alsa-project.org>;
	Sun, 30 Jul 2006 16:08:22 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=735> 
======================================================================
Reported By:                djdeath
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   735
Category:                   PPC - powermac
Reproducibility:            sometimes
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               Debian
Kernel Version:             2.6.9
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             12-20-2004 01:19 CET
Last Modified:              07-30-2006 16:08 CEST
======================================================================
Summary:                    Big noise sound at resume (back from suspend)
Description: 
Sometimes when putting my ibook G4 to suspend, I have a big noise sound at
resume.
About 2 seconds of noise (very near of cat /boot/vmlinuz > /dev/dsp).

======================================================================

----------------------------------------------------------------------
 djdeath - 12-29-04 05:57 
----------------------------------------------------------------------
> No, there is no problem when sound is muted.

Sorry, but after a few new test, it seems it happens when sound is muted
too.



----------------------------------------------------------------------
 djdeath - 04-24-05 22:29 
----------------------------------------------------------------------
fixed since 2.6.12-rc2-mm2

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-20-04 01:19 djdeath        New Issue                                    
12-20-04 01:19 djdeath        Distribution              => Debian          
12-20-04 01:19 djdeath        Kernel Version            => 2.6.9           
12-20-04 01:21 djdeath        Note Added: 0002864                          
12-23-04 16:11 tiwai          Note Added: 0002924                          
12-26-04 04:09 djdeath        Note Added: 0002934                          
12-26-04 13:30 djdeath        Note Edited: 0002934                         
12-29-04 05:57 djdeath        Note Edited: 0002934                         
04-24-05 22:29 djdeath        Note Added: 0004567                          
07-30-06 16:08 Adrian Bunk    Status                   assigned => resolved
07-30-06 16:08 Adrian Bunk    Resolution               open => fixed       
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
