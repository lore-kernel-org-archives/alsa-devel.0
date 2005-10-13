From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001472]: Constant distortion noise on digital mixer
Date: Thu, 13 Oct 2005 13:39:50 +0200
Message-ID: <5aea441a01e1ccd65a0936192b9e7c0a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0B8B8177
	for <alsa-devel@alsa-project.org>; Thu, 13 Oct 2005 13:39:50 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1472> 
======================================================================
Reported By:                Atraides
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1472
Category:                   PCI - ice1712
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Suse
Kernel Version:             2.6.11.4-21.9
======================================================================
Date Submitted:             10-12-2005 02:02 CEST
Last Modified:              10-13-2005 13:39 CEST
======================================================================
Summary:                    Constant distortion noise on digital mixer
Description: 
The hardware in question is a Terratec DMX 6Fire 24/96. I have a constant
crackling (like an old UKW radio between to stations) on the digital
mixer. The noise disappears for a few seconds if I switch the Phono Input,
the Breakout LED or Line In Selector. It changes the noise character when
switching the S/PDIF Input from coaxial to optical. Even if all ins and
outs are muted or tracked down its still there (I can see it in the
Monitor Mixer).
======================================================================

----------------------------------------------------------------------
 alanmann - 10-13-05 10:19 
----------------------------------------------------------------------
I can also report similar problems; I think there are several distinct
occurances.
The DMX6fire has extra connectors for DXF or DXR DigitalXtension.  The
back of these connectors is sensitive to touching or cable proximity under
linux which does not occur under W2000, causing crackling etc.  Sometimes
this is worse than other times, and lessens the longer the system is
switched on for.  This suggests to me that part of this hardware is not
properly configured or deselected.  Fingering skillfully can stop the
crackling most days!
Separately, I also get the crackling that can be influenced by phono/mic
IPGA, as reported inm the archive 13904.
There is another similar strange occurance after using SPDIF input when
clocks do not seem properly working and crackles and odd sounds are heard,
but I suspect this is unrelated.

----------------------------------------------------------------------
 Atraides - 10-13-05 13:39 
----------------------------------------------------------------------
Ack. I did some homebrew shielding (self made cardboard with aluminium foil
between two cardboard layers on the back of the card, aluminium foil
around around the cable to the breakout box isolated with "MacGyver" like
tape) and it definitely lessens the problem but it doesn't disappear. Now
if I boot the machine there is no noise on the digital mixer which wasn't
so before. There seems to be an (pre-)amplifier wide open to amplify any
cross talk it can grab.

BTW.: I noticed a noise like such also on my WinXP machine with this card
but only when I pulled up the volume on the computer and the breakout box
or the hifi amplifier to its maximum but much more less loud even with
max. volume.

   M.Baehr

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-12-05 02:02 Atraides       New Issue                                    
10-12-05 02:02 Atraides       Distribution              => Suse            
10-12-05 02:02 Atraides       Kernel Version            => 2.6.11.4-21.9   
10-12-05 13:50 tiwai          Note Added: 0006465                          
10-12-05 15:19 Atraides       Note Added: 0006467                          
10-13-05 10:19 alanmann       Note Added: 0006475                          
10-13-05 13:39 Atraides       Note Added: 0006477                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
