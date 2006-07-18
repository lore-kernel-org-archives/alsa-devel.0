From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000979]: Feature Request : Bass
	redirection on emu10k1 cards
Date: Tue, 18 Jul 2006 14:48:23 +0200
Message-ID: <e370fea470f69eca967c33a46f970d36@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3075613B
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Jul 2006 14:48:23 +0200 (MEST)
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


The following issue has been ASSIGNED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=979> 
======================================================================
Reported By:                Casper
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   979
Category:                   PCI - emu10k1
Reproducibility:            N/A
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.6.10-gentoo-r4
======================================================================
Date Submitted:             03-10-2005 19:40 CET
Last Modified:              07-18-2006 14:48 CEST
======================================================================
Summary:                    Feature Request : Bass redirection on emu10k1 cards
Description: 
The goal of this feature is to generate a LFE channel from a stereo source
by removing low frequencies of this source and sending them to the LFE
output. I think this can be made by the DSP.

I own a Creative SB Audigy, and a home-made 5.1 sound system with only
amplifiers and no filters. So when I listen to music, all my speakers
works fine with channel mirroring, but the LFE output is not filtered and
the sound is awful. And when I use mplayer to play music with the option
"-af sub" which generates a LFE channel, the low frequencies are already
present on the others speakers and then bass are too loud.

Is this possible to add this feature ?
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-10-05 19:40 Casper         New Issue                                    
03-10-05 19:40 Casper         Distribution              => Gentoo          
03-10-05 19:40 Casper         Kernel Version            => 2.6.10-gentoo-r4
03-19-05 14:23 Casper         Issue Monitored: Casper                      
07-18-06 14:48 jcdutton       Status                   new => assigned     
07-18-06 14:48 jcdutton       Assigned To               => jcdutton        
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
