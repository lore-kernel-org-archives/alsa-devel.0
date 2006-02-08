From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001472]: Constant distortion noise on digital mixer
Date: Wed, 8 Feb 2006 19:58:56 +0100
Message-ID: <5337db4a0bf2b954a86c3f9eecf0adc0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 82C11197
	for <alsa-devel@alsa-project.org>; Wed,  8 Feb 2006 19:58:56 +0100 (MET)
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


The following issue has been set as RELATED TO issue 0001785.
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
Last Modified:              02-08-2006 19:58 CET
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
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0001785 ice1712 driver -cs8427 SPDIF chip not a...
======================================================================

----------------------------------------------------------------------
 tiwai - 10-12-05 13:50 
----------------------------------------------------------------------
Any chance to try the newer version of ALSA?

----------------------------------------------------------------------
 Atraides - 10-12-05 15:19 
----------------------------------------------------------------------
Done. With version 1.0.10RC2 no changes. If any hardware information is of
interest, please let me know. I'll send the output of hwscan or what ever
is necessary.

   M.Baehr

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

----------------------------------------------------------------------
 Atraides - 10-17-05 20:41 
----------------------------------------------------------------------
Investigation Update:

I played around with envy24control and alsamixer and found something
strange. I get that noise on digital mixer and if I use alsamixer if I set
H/W and H/W 1 (which corresponds to H/W Out 1(L) and H/W Out 2(R) in
envy24control)  to H/W In 7. I can see envy24control switching to the
actual settings when I switch  through the options in alsamixer but
envy24control doesn't know H/W In 6 and 7.

Hope this helps in some kind.

----------------------------------------------------------------------
 alanmann - 02-02-06 22:03 
----------------------------------------------------------------------
Refer to bug001785 -spdif not set up

That bug was one contribution to the noise problem -patches there fix
that, and now I am left with the touch-connector noise.

Further investigation shows it comes when touching cn10 pin17, which is
connected to the envy24 chip pin77.  That is labelled PSDIN(3) on the
brief data sheet I have.  It connects as mentioned above to a DXR
digital/MicroWAVE PC extension.  Clearly in normal set-up it is floating
but brings digital noise onto the digital mix channel without being on any
input channel.

Can any more knowledgable developer help out, please?

----------------------------------------------------------------------
 alanmann - 02-05-06 22:21 
----------------------------------------------------------------------
I have been able to fix this 'touch-noise'.  The unused envy24 input
digital lines need to be disabled, so it is only expecting 6 ADCs & DACs. 
The patch bug1472-dmx6fire-limit-to-6ADCs.patch sorts this out.

In conjunction with earlier fixes, I now have a well-behaved sound card
system with all I/O working.  Please report your results.

----------------------------------------------------------------------
 alanmann - 02-07-06 12:56 
----------------------------------------------------------------------
Slight typo in uploaded file '=' not '==' (compiled OK anyway). Amended
file uploaded; original can be deleted.

----------------------------------------------------------------------
 alanmann - 02-08-06 16:26 
----------------------------------------------------------------------
Added to patch:' ' to align comments following v2 change (might as well get
it right!); please use v3 of the file and delete the rest.

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
10-17-05 20:41 Atraides       Note Added: 0006488                          
02-02-06 22:03 alanmann       Note Added: 0007882                          
02-05-06 22:21 alanmann       Note Added: 0007942                          
02-05-06 22:22 alanmann       File Added: bug1472-dmx6fire-limit-to-6ADCs.patch 
                  
02-07-06 12:54 alanmann       File Added:
bug1472-dmx6fire-limit-to-6ADCs-v2.patch                    
02-07-06 12:56 alanmann       Note Added: 0007957                          
02-08-06 16:26 alanmann       Note Added: 0007966                          
02-08-06 16:27 alanmann       File Added:
bug1472-dmx6fire-limit-to-6ADCs-v3.patch                    
02-08-06 19:58 perex          Relationship added       related to 0001785  
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
