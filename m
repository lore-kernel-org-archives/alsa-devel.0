From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001663]: LW20 bugs with headphone input, realtek.com.tw has a fix, please intergrate it!
Date: Thu, 19 Jan 2006 18:27:10 +0100
Message-ID: <26121ffb7ed2c45ca2d0c50119dcbc0b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2BD1F142
	for <alsa-devel@alsa-project.org>; Thu, 19 Jan 2006 18:27:11 +0100 (MET)
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


The following issue has been set as DUPLICATE OF issue 0001572.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1663> 
======================================================================
Reported By:                mikael
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1663
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               Archlinux
Kernel Version:             2.4.13.4
======================================================================
Date Submitted:             12-20-2005 19:11 CET
Last Modified:              01-19-2006 18:27 CET
======================================================================
Summary:                    LW20 bugs with headphone input, realtek.com.tw has a
fix, please intergrate it!
Description: 
My new laptop has a HDA Intel (Realtek ALC880) soundcard. 

It though for some reason do not turn off the main speaker when you insert
headphones. On the site
http://www.realtek.com.tw/downloads/dlhd-2.aspx?lineid=2004052&famid=2004052&series=2004061&Software=True
there is a patched alsa package available which fixes this issue by adding
a "Headphone" mixer which you can turn on/off and also gives you the
availability to mute the main speakers without (as in 1.0.10/11-rc1)
muting the headphones aswell.

Can you please intergrate this? I struggled trying to intergrate this
properly but their alsa is built on 1.0.9 and I suppose I am not the
sharpest of programers either for the job.

Greets,
  Mikael
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0001572 Simultaneous sound from speakers and he...
======================================================================

----------------------------------------------------------------------
 mikael - 01-16-06 16:22 
----------------------------------------------------------------------
I realize this is a low prio matter but an update/status notification or
anything would be very appreciated after one months time.

----------------------------------------------------------------------
 rlrevell - 01-16-06 19:24 
----------------------------------------------------------------------
All of the Realtek code should have been merged into the latest ALSA
drivers, is it still broken with 1.0.11-rc2?

----------------------------------------------------------------------
 mikael - 01-17-06 00:05 
----------------------------------------------------------------------
I think you misinterpretated the bug report. 

I have just tried the 1.0.11-rc2 with the same result. 

To clarify the bug report:

 * My laptop has a set of stereo front speakers
 * It has 1 mic input and 1 lineout and 1 headphone jack
 * When inserting the headphones to either lineout or headphone jack the
front speakers will not mute
 * If you mute the "Front" bar in alsamixer both front speakers and
headphones mute
 * Realtek.com.tw has implemented a bar named "Headphone" which you can by
software mute / unmute in combination of muting only the "Front" bar,
which solves the problem.

Screenshots:

 * Realtek.com.tw drivers:
http://ircgeeks.net/~nicon/pics/rlt_alsamixer.png
 * Alsa-project.org drivers:
http://ircgeeks.net/~nicon/pics/11rc2_alsamixer.png

Please add a comment if you need a more clear bug report.

----------------------------------------------------------------------
 mjsb - 01-19-06 14:05 
----------------------------------------------------------------------
I had submited bug #0001572 describing the same problem back in November
17, 2005.
The bug still applies to current alsa-driver 1.0.11_rc2.
I'm running the same laptop LG LW20 with gentoo linux (kernel 2.6.14).

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-20-05 19:11 mikael         New Issue                                    
12-20-05 19:11 mikael         Distribution              => Archlinux       
12-20-05 19:11 mikael         Kernel Version            => 2.4.13.4        
01-16-06 16:22 mikael         Note Added: 0007688                          
01-16-06 19:24 rlrevell       Note Added: 0007691                          
01-17-06 00:05 mikael         Note Added: 0007693                          
01-19-06 14:05 mjsb           Note Added: 0007720                          
01-19-06 14:31 mjsb           Issue Monitored: mjsb                        
01-19-06 18:27 rlrevell       Relationship added       duplicate of 0001572
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
