From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000683]: sound works through speakers only not through headphones
Date: Thu, 2 Dec 2004 19:29:38 +0100
Message-ID: <efcb4965f071a0cbfe7daa6c57d65d33@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 019FB17E
	for <alsa-devel@alsa-project.org>; Thu,  2 Dec 2004 19:29:38 +0100 (MET)
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
Status:                     assigned
Distribution:               fedora core 3
Kernel Version:             2.6.9-1.667
======================================================================
Date Submitted:             11-28-2004 05:05 CET
Last Modified:              12-02-2004 19:29 CET
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
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
