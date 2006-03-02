From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001864]: ADC/DAC Volume should be stereo controls instead of two independent mono controls
Date: Thu, 2 Mar 2006 15:58:51 +0100
Message-ID: <d66f98d67886773699d7fa63a09eb2e2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B862B156
	for <alsa-devel@alsa-project.org>; Thu,  2 Mar 2006 15:58:51 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1864> 
======================================================================
Reported By:                karrikuh
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1864
Category:                   PCI - ice1712
Reproducibility:            always
Severity:                   trivial
Priority:                   normal
Status:                     new
Distribution:               Ubuntu Breezy
Kernel Version:             2.6.14
======================================================================
Date Submitted:             02-21-2006 17:10 CET
Last Modified:              03-02-2006 15:58 CET
======================================================================
Summary:                    ADC/DAC Volume should be stereo controls instead of
two independent mono controls
Description: 
Until now the ice1712 driver provides 4 mono controls for ADC, ADC2, DAC,
DAC2.
I'm using a Terratec EWX24/96 soundcard for which ADC and ADC2 mean the
left/right channel of the analog input. Right now everytime I want to
change the input or output level, I have to adjust two faders in
gnome-mixer-applet.

It should be obvious that it makes more sense to combine the two controls
(ADC/ADC2) into one stereo fader pair (the same for DAC). I guess most
other envy24-based cards use the same scheme though I'm not sure.



======================================================================

----------------------------------------------------------------------
 rlrevell - 02-22-06 19:40 
----------------------------------------------------------------------
Someone needs to implement that in the mixer app or alsa-lib, it does not
belong in the driver.

----------------------------------------------------------------------
 tiwai - 03-02-06 15:58 
----------------------------------------------------------------------
IMO, it's OK to implement this feature in the driver level although we may
work around with alsa-lib level.  The question is which is easier and more
efficient.  I guess the driver change would be suitable in this case.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-21-06 17:10 karrikuh       New Issue                                    
02-21-06 17:10 karrikuh       Distribution              => Ubuntu Breezy   
02-21-06 17:10 karrikuh       Kernel Version            => 2.6.14          
02-21-06 20:27 rlrevell       Note Added: 0008154                          
02-22-06 11:48 karrikuh       Note Added: 0008157                          
02-22-06 19:40 rlrevell       Note Added: 0008161                          
03-02-06 15:58 tiwai          Note Added: 0008316                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
