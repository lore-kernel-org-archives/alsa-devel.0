From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001663]: LW20 bugs with headphone input, realtek.com.tw has a fix, please intergrate it!
Date: Tue, 17 Jan 2006 00:05:27 +0100
Message-ID: <352b6a5f1eb53e2d2214cfb661ba4ed6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 042F4149
	for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2006 00:05:27 +0100 (MET)
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
Last Modified:              01-17-2006 00:05 CET
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-20-05 19:11 mikael         New Issue                                    
12-20-05 19:11 mikael         Distribution              => Archlinux       
12-20-05 19:11 mikael         Kernel Version            => 2.4.13.4        
01-16-06 16:22 mikael         Note Added: 0007688                          
01-16-06 19:24 rlrevell       Note Added: 0007691                          
01-17-06 00:05 mikael         Note Added: 0007693                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
