From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001642]: System lockup when recording
Date: Mon, 26 Dec 2005 02:20:09 +0100
Message-ID: <d4797e86eba86227a8c4df02148787b0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id EA692147
	for <alsa-devel@alsa-project.org>; Mon, 26 Dec 2005 02:20:09 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1642> 
======================================================================
Reported By:                oryn
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1642
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               Debian
Kernel Version:             2.6.14.3
======================================================================
Date Submitted:             12-12-2005 00:31 CET
Last Modified:              12-26-2005 02:20 CET
======================================================================
Summary:                    System lockup when recording
Description: 
When I try to open a usb device for recording it locks up the system
I have to power cycle the system to recover.
It makes no difference what application I use and whether it wants to open
the alsa device directly or via the oss emulation.
======================================================================

----------------------------------------------------------------------
 oryn - 12-12-05 19:48 
----------------------------------------------------------------------
I was able to (by using vnc to run my app) to capture an error on the
console.
See usbsound.jpg
I didn't see if there was an oops as the console gets flooded with what
looks like the following lines:
"cannot submit datapipe for urb 0, err = -22"
and
"cannot submit datapipe for urb 3, err = -28"
Its going so fast that the 2 errors are blured into one, only by setting a
fast shutter speed was i able to get this picture.

----------------------------------------------------------------------
 oryn - 12-26-05 02:20 
----------------------------------------------------------------------
I would like to add that it seems I cant play sounds to my usb device
ether
I get this error:
ALSA /usr/src/alsa-driver/usb/usbaudio.c:819: cannot submit datapipe for
urb 5, err = -28

I'm running Linux-2.6.14.4 with cvs alsa 26/DEC/2006
The audio device is a plantronics DA50 usb headset
Bus 002 Device 002: ID 047f:0301 Plantronics, Inc.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-12-05 00:31 oryn           New Issue                                    
12-12-05 00:31 oryn           Distribution              => Debian          
12-12-05 00:31 oryn           Kernel Version            => 2.6.14.3        
12-12-05 01:01 rlrevell       Note Added: 0006981                          
12-12-05 17:23 oryn           Note Added: 0006984                          
12-12-05 19:41 oryn           File Added: usbsound.jpg                     
12-12-05 19:48 oryn           Note Added: 0006985                          
12-26-05 02:20 oryn           Note Added: 0007146                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
