From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000683]: sound works through speakers
	only not through headphones
Date: Sat, 29 Jul 2006 19:24:07 +0200
Message-ID: <c68af9264be2b955b35833b2c541fb45@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 00E08181
	for <alsa-devel@alsa-project.org>;
	Sat, 29 Jul 2006 19:24:07 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=683> 
======================================================================
Reported By:                michaelhoy2
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   683
Category:                   PCI - atiixp
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               fedora core 3
Kernel Version:             2.6.9-1.667
Resolution:                 unable to duplicate
Fixed in Version:           
======================================================================
Date Submitted:             11-28-2004 05:05 CET
Last Modified:              07-29-2006 19:24 CEST
======================================================================
Summary:                    sound works through speakers only not through
headphones
Description: 
the sound works in fedora core 3, so far the only distro to properly handle
your driver, but one small problem, it's a laptop and i HAVE to HAVE
headphones because otherwise I'll be bothering people at work. Can I get
some support to make the headphones work. BTW the volume mute and vol up
and vol down on the side of the laptop don't work either, it's a compaq
r3000 p4 2.8ghz laptop
======================================================================

----------------------------------------------------------------------
 tiwai - 12-02-04 19:29 
----------------------------------------------------------------------
Please show the contents of /proc/asound/card0/codec97#0/* files and
/etc/asound.state.
On some codecs, 'External Amplifier' control tunrs on/off the speaker.
On some, you can turn on/off via 'Mono Playback Switch'.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-28-04 05:05 michaelhoy2    New Issue                                    
11-28-04 05:05 michaelhoy2    Distribution              => fedora core 3   
11-28-04 05:05 michaelhoy2    Kernel Version            => 2.6.9-1.667     
12-02-04 19:29 tiwai          Note Added: 0002693                          
07-29-06 19:24 Adrian Bunk    Status                   assigned => closed  
07-29-06 19:24 Adrian Bunk    Resolution               open => unable to
duplicate
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
