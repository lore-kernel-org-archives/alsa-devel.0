From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000809]: asfxload + aconnect called before dsp used causes dsp to be locked
Date: Wed, 12 Jan 2005 15:16:16 +0100
Message-ID: <d1deb8bcc66f904803d91516253afb39@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 8DB1731A
	for <alsa-devel@alsa-project.org>; Wed, 12 Jan 2005 15:16:16 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=809> 
======================================================================
Reported By:                vinyvat
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   809
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian testing
Kernel Version:             2.6.8.1
======================================================================
Date Submitted:             01-12-2005 09:34 CET
Last Modified:              01-12-2005 15:16 CET
======================================================================
Summary:                    asfxload + aconnect called before dsp used causes
dsp to be locked
Description: 
PS: This bug is present in the alsa version in stock kernel 2.6.8.1 up to
1.0.8-rc2.

For convienience I like to have my wavetable loaded and midi connections
setup during bootup so I can use my midi keyboard by just turning on the
computer.

This worked OK with stock kernel 2.6.3 ( and whatever alsa version came
with it ).

Recently upgraded to stock 2.6.8.1 which had the modprobe
snd-emu10k1-synth freeze bug, but was able to work around this by
launching my wavetable loading script post the modprobe. Play back from my
keyboard worked great.

This is when I began to notice apps that accessed the dsp reporting that
they were locked out ( and did not produce any sound ). First would be
arts when kde started up, and then any dvd playing app ( ogle, mplayer,
xine, all of them setup to use alsa ).

Strangely though, alsaplayer still worked despite the fact that the other
apps didn't - could it be using some other way of plugin to the emu10k1
mixer ? 

Have tried upgrading to alsa-driver-1.0.7 ( which didn't play any
wavetable sounds at all - strange ), then to alsa-driver-1.0.8-rc2 ( which
does play wavetable sounds ) but none of these fixes this problem.

If I change the order of things - have artsd start up, start a dvd
playback, and then call asfxload + aconnect, then everything is mixed and
sounds great.
======================================================================

----------------------------------------------------------------------
 tiwai - 01-12-05 15:16 
----------------------------------------------------------------------
Please elaborate the procedure causing the problem.
Which command sequences did the crash?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-12-05 09:34 vinyvat        New Issue                                    
01-12-05 09:34 vinyvat        Distribution              => Debian testing  
01-12-05 09:34 vinyvat        Kernel Version            => 2.6.8.1         
01-12-05 15:16 tiwai          Note Added: 0003171                          
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
