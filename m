From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001357]: Add a Capture setting
Date: Tue, 18 Jul 2006 11:59:53 +0200
Message-ID: <0004a4183d5b6d20355e3d934cf058ee@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A682F21A
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Jul 2006 11:59:53 +0200 (MEST)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1357> 
======================================================================
Reported By:                Electro
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1357
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     closed
Distribution:               Gentoo
Kernel Version:             2.6.12-gentoo-r6
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             08-22-2005 09:37 CEST
Last Modified:              07-18-2006 11:59 CEST
======================================================================
Summary:                    Add a Capture setting
Description: 
In order to record with an Audiotrak Prodigy 7.1 (snd-1724), I have to
first set the IGAIN setting using aumix. Also I have to use aumix to set
what input I want to capture from. Then I can record with any program. I
would like to a way to set what input to be use for capture and a setting
for the capture level accessible through alsamixer, so it can be changed,
stored, restored. I could use aumix to load the save settings but
sometimes it screws up and only the left channel is recorded.
======================================================================

----------------------------------------------------------------------
 tiwai - 08-23-05 16:53 
----------------------------------------------------------------------
Everything you can do through OSS mixer can be done via alsamixer, too.
You must have missed something in alsamixer (e.g. didn't change the view
mode).

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-22-05 09:37 Electro        New Issue                                    
08-22-05 09:37 Electro        Distribution              => Gentoo          
08-22-05 09:37 Electro        Kernel Version            => 2.6.12-gentoo-r6
08-23-05 16:53 tiwai          Note Added: 0005911                          
07-18-06 11:59 Adrian Bunk    Status                   new => closed       
07-18-06 11:59 Adrian Bunk    Resolution               open => not an issue
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
