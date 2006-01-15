From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001753]: M-Audio Revolution 5.1: Mute Line-In / Mic
Date: Sun, 15 Jan 2006 15:49:48 +0100
Message-ID: <1d11626b4188b277899ff1ab5e7510a1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 602BCE2
	for <alsa-devel@alsa-project.org>; Sun, 15 Jan 2006 15:49:48 +0100 (MET)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1753> 
======================================================================
Reported By:                wollschaf
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1753
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.6.15
======================================================================
Date Submitted:             01-15-2006 15:49 CET
Last Modified:              01-15-2006 15:49 CET
======================================================================
Summary:                    M-Audio Revolution 5.1: Mute Line-In / Mic
Description: 
There is no mixer element to enable or disable Line and Mic inputs.

The problem is that even with all DAC mixers set to zero, white noise can
be heard . It is pretty loud, and too loud to enjoy music / the good SNR
of the card ;)

Setting 
#define VT1724_REVO_MUTE        (1<<22)

to 
#define VT1724_REVO_MUTE        (0<<22)

gets rid of the noise, but playback volume is pretty low, especially for
headphones - even with the DAC mixer set to 100%.

Even if there is no way to adjust input gain in hardware (correct?), there
should be a possibility to disable / mute the inputs or change the routing
so they are not played back internally.


======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-15-06 15:49 wollschaf      New Issue                                    
01-15-06 15:49 wollschaf      Kernel Version            => 2.6.15          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
