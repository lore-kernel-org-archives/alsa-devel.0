From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001749]: SPDIF sound only in stereo
Date: Sun, 15 Jan 2006 13:59:27 +0100
Message-ID: <f006480afcaf98dd8a42bff0965eb7f7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DEA9912B
	for <alsa-devel@alsa-project.org>; Sun, 15 Jan 2006 13:59:27 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1749> 
======================================================================
Reported By:                MechCow
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1749
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               Debian
Kernel Version:             2.6.12
======================================================================
Date Submitted:             01-15-2006 04:56 CET
Last Modified:              01-15-2006 13:59 CET
======================================================================
Summary:                    SPDIF sound only in stereo
Description: 
I can only get stereo sound out of the ca0106. All other volumes are at
standard levels. 

I'm using the SB Live 24Bit card. 

0000:00:09.0 Multimedia audio controller: Creative Labs SB Audigy LS

I'm using a 2.6.12 kernel I compiled myself and alsa installed from debian
unstable. 

I have connected the soundcard up as it specifies in the manual, the top
slot connected by a miniplug-to-rca into the coaxial of my panasonic 5.1
surround sound system. 
======================================================================

----------------------------------------------------------------------
 MechCow - 01-15-06 06:37 
----------------------------------------------------------------------
I installed alsa-driver and alsa-lib 1.0.11-rc2 . Modules installed fine
and loaded fine, prints this as output 

ACPI: PCI Interrupt 0000:00:09.0[A] -> GSI 17 (level, low) -> IRQ 193
Model 1006 Rev 00000000 Serial 10061102

I'm using gcc version 3.3.6 (Debian 1:3.3.6-12) cause its the one I've had
the least problems with.

Driver still does not output sound to the center speaker. Sound system
unit identifies only a left and right channel.

----------------------------------------------------------------------
 rlrevell - 01-15-06 13:59 
----------------------------------------------------------------------
"Driver still does not output sound to the center speaker. Sound system
unit identifies only a left and right channel."

How are you testing this?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-15-06 04:56 MechCow        New Issue                                    
01-15-06 04:56 MechCow        Distribution              => Debian          
01-15-06 04:56 MechCow        Kernel Version            => 2.6.12          
01-15-06 05:22 rlrevell       Note Added: 0007661                          
01-15-06 06:37 MechCow        Note Added: 0007662                          
01-15-06 13:59 rlrevell       Note Added: 0007664                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
