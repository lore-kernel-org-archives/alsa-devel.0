From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001730]: Unplug/replug of USB audio device causes snd_usb_audio and/or snd_pcm usage count to stick at 1 => no sound
Date: Tue, 10 Jan 2006 09:25:05 +0100
Message-ID: <8a61218f40b404bc29719e0bf02aeda2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A272C13D
	for <alsa-devel@alsa-project.org>; Tue, 10 Jan 2006 09:25:05 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1730> 
======================================================================
Reported By:                stuge
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1730
Category:                   CORE - pcm
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Gentoo Linux
Kernel Version:             2.6.15
======================================================================
Date Submitted:             01-10-2006 09:25 CET
Last Modified:              01-10-2006 09:25 CET
======================================================================
Summary:                    Unplug/replug of USB audio device causes
snd_usb_audio and/or snd_pcm usage count to stick at 1 => no sound
Description: 
Actually I'm using 1.0.11rc2 drivers, utils, libs and headers.
Filed under CORE/pcm as per crimsun's suggestion in #alsa.

I had this issue also with Gentoo 1.0.10-r1 but then I got an oops and a
double exception that looked pretty nasty. After updating to 1.0.11rc2 I
don't get the oops but still get the bug.

The USB device is a self-made TI PCM2902 reference design.

Sometimes I have to unplug/replug the device twice to tickle the bug,
sometimes just once is enough.

Kernel error message:
ALSA
/var/tmp/portage/alsa-driver-1.0.11_rc2/work/alsa-driver-1.0.11rc2/acore/timer.c:876:
timer 0xf7fa4200 is busy?

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-10-06 09:25 stuge          New Issue                                    
01-10-06 09:25 stuge          Distribution              => Gentoo Linux    
01-10-06 09:25 stuge          Kernel Version            => 2.6.15          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
