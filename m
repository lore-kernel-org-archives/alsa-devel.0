From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002314]: ice1724: PCM playback stalled
	and outputs mute on resume from software suspend
Date: Sat, 29 Jul 2006 16:57:12 +0200
Message-ID: <ffdbc425cd5db039bd772eca7d6b13c5@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E2E2818E
	for <alsa-devel@alsa-project.org>;
	Sat, 29 Jul 2006 16:57:12 +0200 (MEST)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2314> 
======================================================================
Reported By:                ikari_01
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2314
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               Debian unstable
Kernel Version:             2.6.17.7
======================================================================
Date Submitted:             07-29-2006 16:57 CEST
Last Modified:              07-29-2006 16:57 CEST
======================================================================
Summary:                    ice1724: PCM playback stalled and outputs mute on
resume from software suspend
Description: 
ice1724 does not handle suspend/resume; on resume, audio outputs are muted
and PCM playback is frozen. snd_ice1724 has to be reloaded to fix the
problem.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-29-06 16:57 ikari_01       New Issue                                    
07-29-06 16:57 ikari_01       Distribution              => Debian unstable 
07-29-06 16:57 ikari_01       Kernel Version            => 2.6.17.7        
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
