From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001551]: No mute switch to mixer
	channel
Date: Tue, 18 Jul 2006 14:36:26 +0200
Message-ID: <9b88bdf04f17c6d11f765258551975e1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5B264150
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Jul 2006 14:36:26 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1551> 
======================================================================
Reported By:                Shogun
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1551
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo Linux 2005.1
Kernel Version:             2.6.13-gentoo-r3
======================================================================
Date Submitted:             11-13-2005 13:16 CET
Last Modified:              07-18-2006 14:36 CEST
======================================================================
Summary:                    No mute switch to mixer channel
Description: 
I have a SoundBlaster Audigy 2 ZS (without LiveDrive)...
When I load the modules the sound works perfectly, but in the mixer (both
alsa-mixer and kmix) I can't see any mute switch for the mixer
channel...The only channel which has the switch is the Headphone...

I don't know if previous version worked...
======================================================================

----------------------------------------------------------------------
 Shogun - 11-13-05 14:05 
----------------------------------------------------------------------
I forgot to mention that this issue is also present in 1.0.8 and in
1.0.10rc3...

----------------------------------------------------------------------
 Shogun - 05-06-06 01:22 
----------------------------------------------------------------------
Still here with kernel 2.6.16 and ALSA 1.0.11...
What's wrong guys? Why doesn't the mixer works?

As I read in source code, the master mute has no effect on the card...so I
think it's not supported...but is there any way to accomplish a standard
behaviour?

Thanks...

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-13-05 13:16 Shogun         New Issue                                    
11-13-05 13:16 Shogun         Distribution              => Gentoo Linux 2005.1
11-13-05 13:16 Shogun         Kernel Version            => 2.6.13-gentoo-r3
11-13-05 14:05 Shogun         Note Added: 0006691                          
05-06-06 01:22 Shogun         Note Added: 0009634                          
07-18-06 14:36 jcdutton       Status                   new => assigned     
07-18-06 14:36 jcdutton       Assigned To               => jcdutton        
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
