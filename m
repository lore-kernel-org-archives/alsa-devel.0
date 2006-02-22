From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001864]: ADC/DAC Volume should be stereo controls instead of two independent mono controls
Date: Wed, 22 Feb 2006 19:40:25 +0100
Message-ID: <5f09014c20d102123db85a2170cac9dc@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E970B1AA
	for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2006 19:40:25 +0100 (MET)
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
Last Modified:              02-22-2006 19:40 CET
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
 karrikuh - 02-22-06 11:48 
----------------------------------------------------------------------
If I remember correctly, stereo controls still have one fader per channel,
just that their positions are linked by default (but can be unlinked if
you want to use the channels independently).

In gnome-volume-control it looks like this:
http://ronald.bitfreak.net/images/gvc11.png

BTW, the Windows control panel for my card has the same type of control.
You see, ADC and DAC are really ment to be stereo channel pairs.

----------------------------------------------------------------------
 rlrevell - 02-22-06 19:40 
----------------------------------------------------------------------
Someone needs to implement that in the mixer app or alsa-lib, it does not
belong in the driver.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-21-06 17:10 karrikuh       New Issue                                    
02-21-06 17:10 karrikuh       Distribution              => Ubuntu Breezy   
02-21-06 17:10 karrikuh       Kernel Version            => 2.6.14          
02-21-06 20:27 rlrevell       Note Added: 0008154                          
02-22-06 11:48 karrikuh       Note Added: 0008157                          
02-22-06 19:40 rlrevell       Note Added: 0008161                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
