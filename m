From: bugtrack@alsa-project.org
Subject: [ALSA - WWW server 0001743]: hardware compatibility report: Siig USB SoundWave Optical 5.1 works
Date: Fri, 13 Jan 2006 06:21:03 +0100
Message-ID: <17c4195a168b63d0d05baaa0224193f7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3D48413A
	for <alsa-devel@alsa-project.org>; Fri, 13 Jan 2006 06:21:03 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1743> 
======================================================================
Reported By:                salfter
Assigned To:                
======================================================================
Project:                    ALSA - WWW server
Issue ID:                   1743
Category:                   soundcard matrix
Reproducibility:            N/A
Severity:                   feature
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             01-13-2006 06:21 CET
Last Modified:              01-13-2006 06:21 CET
======================================================================
Summary:                    hardware compatibility report: Siig USB SoundWave
Optical 5.1 works
Description: 
I bought the aforementioned gadget eariler today, hoping to work around
buggy digital audio on my nForce4-chipset MythTV box.  It includes
2-channel analog and optical S/PDIF outputs and plugs into any USB port
that supports full-speed operation (which should be all of them).  I've
tested it against ALSA 1.0.10, and it Just Works with the usb-audio
driver.  As far as ALSA can see, it's just an output device with a single
volume control in the mixer (presumably for the analog output).  I've sent
PCM and AC3 output through it with no problems.

lsusb identifies it with vendor ID 0x0c45 and product ID 0x17c8.  The
vendor ID is for some company I've never heard of called Microdia; their
website has nothing on it about USB-to-S/PDIF dongles or other related
audio hardware.

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-13-06 06:21 salfter        New Issue                                    
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
