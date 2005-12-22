From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001673]: Optical audio output (S/PDIF=IEC958) not enabled
Date: Thu, 22 Dec 2005 17:07:49 +0100
Message-ID: <e30042246a57aa4cac1ad5a422bb09b5@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id EE95B1C3
	for <alsa-devel@alsa-project.org>; Thu, 22 Dec 2005 17:07:49 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1673> 
======================================================================
Reported By:                polt
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1673
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Standard Ubuntu 5.10 (out of box)
Kernel Version:             2.6.12
======================================================================
Date Submitted:             12-22-2005 17:07 CET
Last Modified:              12-22-2005 17:07 CET
======================================================================
Summary:                    Optical audio output (S/PDIF=IEC958) not enabled
Description: 
This system is a 64-bit Pentium on an Intel D945PVS mobo with onboard
STAC9223 sound. It uses the ICH7 chipset. The sound has 5 analog and 1
digital connector on the back, 2 analog on the front. No output except the
green analog (line out) is active.

The default install picked up the snd-hda-intel driver. Stereo sound comes
out as device 0, e.g., aplay -D hw:0,0 test.wav, but no sound (no light)
comes out as hw:0,1 (the optical output, I think).  There is a delay while
running aplay, as if sound file is being processed, but no output. No
other device numbers are used (aplay generates an error with hw:0,2, but
not with hw:0,1).

alsamixer shows nothing except a switch for IEC958. The switch/mute has no
effect on the situation.  XMMS has a setting for hw:0,1, but alas that
does not activate the optical port either.


======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-22-05 17:07 polt           New Issue                                    
12-22-05 17:07 polt           Distribution              => Standard Ubuntu 5.10
(out of box)
12-22-05 17:07 polt           Kernel Version            => 2.6.12          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
