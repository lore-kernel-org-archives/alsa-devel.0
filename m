From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000749]: Buzz from ALSA setup
Date: Sun, 26 Dec 2004 18:07:50 +0100
Message-ID: <7d0b78b01233bf698aca445a098e1c72@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 3F07929B
	for <alsa-devel@alsa-project.org>; Sun, 26 Dec 2004 18:07:51 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=749> 
======================================================================
Reported By:                misnagid
Assigned To:                pzad
======================================================================
Project:                    ALSA - driver
Issue ID:                   749
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Fedora FC3
Kernel Version:             2.6.9
======================================================================
Date Submitted:             12-26-2004 15:37 CET
Last Modified:              12-26-2004 18:07 CET
======================================================================
Summary:                    Buzz from ALSA setup
Description: 
I get an almost constant buzz from speakers when I've tried to use ALSA. 
Have followed your directions from the online web page directions to the
letter.  Still buzz.
Have brought all sound levels up ising alsamixer and Kmix.  Of no help. 
Have tried everything I've seen about this problem.
OnBoard NVidia audio from Asus A7N8X-E Deluxe disabled.  Using emu10k1
driver for installed Creative Labs Audigy 2 soundcard. This is a brand new
successful in all other regards install of Fedora FC3.

======================================================================

----------------------------------------------------------------------
 misnagid - 12-26-04 17:47 
----------------------------------------------------------------------
Interesting.  Yes I see that alsa mixer has more columns to the right by
scrolling to the right.  I see that the switches that have been selected
off by KMix are off in AlsaMixer.  I don't see how AlsaMixer can re-enable
those switches that have been turned off by Kmix, to be returned on in
AlsaMixer.

Nonetheless though, AlsaMixer does show that both Audigy Analog/Digital
Output Jack [Off] is off and IEC958 Optical Raw [Off] is off.  Which items
should be on then?  I am using a 2.1 speaker system and I don't have much
interest in ever using more than that.

Presently Sigmatel 4 speaker stereo, Sigmatel Surround Phase Inversion
Playback, and External Amplifier are all on.  Audigy Analog/Digital Output
Jack, IEC958 Optical Raw, Mic Boost (+20dB), 3D Control - Switch, Tone are
all off. 

However though both Sigmatel switches are shown on in KMix, AlsaMixer
shows them as off.  As I said external amplifies in KMix is shown as on,
Kmix is shown as: Item: External Amplifier.  I assume that means on too
since it doesn't say Off but the volume is all the way down in Alsamixer
and cannot be raised with the Up keyboard keys no matter how I fudge with
them.  Tried NumLock on, tried NumLock off.  Tried up arrow and tried up
arrow in numlock section of keyboard.  Tried PageUp, tried +, tried
Contrl+, tried most everything...

Exactly which of these 8 switches shoulkd be on, which off?

Seems a bit convoluted...  Been using alsactl store to store the
settings.

Please assist.

Thanks,
Jerry

----------------------------------------------------------------------
 misnagid - 12-26-04 18:07 
----------------------------------------------------------------------
Could ArtsD be causing this proble?  I see notes about the latest ArtsD
being buggy but that downfrading to older version didn't help.

G-d, I really don't know what to here.  What should I di regarding this
ArtsD thing?  Nothing?  I am getting no sounds at all right now, whether
it be KDE sounds, applications sounds, sounds from playback of whatever
kinds of mucic files, gurnischt!  Nothing!

Could use you help I admit!

Thanks,
Jerry

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-26-04 15:37 misnagid       New Issue                                    
12-26-04 15:37 misnagid       Distribution              => Fedora FC3      
12-26-04 15:37 misnagid       Kernel Version            => 2.6.9           
12-26-04 15:58 pzad           Note Added: 0002935                          
12-26-04 16:31 misnagid       Note Added: 0002936                          
12-26-04 16:44 misnagid       Note Added: 0002937                          
12-26-04 16:56 pzad           Note Added: 0002938                          
12-26-04 17:47 misnagid       Note Added: 0002939                          
12-26-04 18:07 misnagid       Note Added: 0002940                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
