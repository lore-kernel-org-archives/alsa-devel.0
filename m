From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001472]: Constant distortion noise on digital mixer
Date: Fri, 14 Oct 2005 12:55:56 +0200
Message-ID: <6aebe84aa13091ec1ffe49f97517da1c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 73CEA190
	for <alsa-devel@alsa-project.org>; Fri, 14 Oct 2005 12:55:56 +0200 (MEST)
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
Last Modified:              10-14-2005 12:55 CEST
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
 Atraides - 10-14-05 11:48 
----------------------------------------------------------------------
Ack. I did some homebrew shielding (self made cardboard with aluminium foil
between two cardboard layers on the back of the card, aluminium foil
around around the cable to the breakout box isolated with "MacGyver" like
tape) and it definitely lessens the problem but it doesn't disappear. Now
if I boot the machine there is no noise on the digital mixer which wasn't
so before but it comes back after a while. There seems to be an
(pre-)amplifier wide open to amplify any cross talk it can grab.

BTW.: I noticed a noise like such also on my WinXP machine with this card
but only when I pulled up the volume on the computer and the breakout box
or the hifi amplifier to its maximum but much more less loud even with
max. volume.

I don't know whether it has to do with this issue but I have found an AC97
error message in the log files: AC'97 0 access is not valid [0xffffffff],
removing mixer.
ice1712: cannot initialize ac97 for consumer, skipped

   M.Baehr



----------------------------------------------------------------------
 alanmann - 10-14-05 12:55 
----------------------------------------------------------------------
It does sound like the same problem if influenced by screening.  However I
think it is not pre-amp type, as it is linked to the digital DXF etc
connector not the analog lines, and most other physical areas of the card
are not involved.  Perhaps an unwanted clock input active?  I wonder if
anyone has data-info on this cards extra functions?

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
10-14-05 11:48 Atraides       Note Edited: 0006477                         
10-14-05 12:55 alanmann       Note Added: 0006478                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
