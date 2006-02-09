From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001828]: Patch to get Miditech Play'n Roll Keyboard to work with ALSA
Date: Thu, 9 Feb 2006 09:26:43 +0100
Message-ID: <5b1f26f67123c533f6bd07bc647da43e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id AF7B01C8
	for <alsa-devel@alsa-project.org>; Thu,  9 Feb 2006 09:26:43 +0100 (MET)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1828> 
======================================================================
Reported By:                skupin
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1828
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             02-07-2006 11:15 CET
Last Modified:              02-09-2006 09:26 CET
======================================================================
Summary:                    Patch to get Miditech Play'n Roll Keyboard to work
with ALSA
Description: 
With the following patch the Miditech Play'n Roll Keyboard works with
ALSA:

--- usbquirks.h.org     2005-08-29 01:41:01.000000000 +0200
+++ usbquirks.h 2006-02-06 10:34:05.000000000 +0100
@@ -1396,6 +1396,15 @@
                .type = QUIRK_MIDI_MIDITECH
        }
 },
+{
+       USB_DEVICE(0x0ccd, 0x0035),
+       .driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
+               .vendor_name = "Miditech",
+               .product_name = "Play'n Roll",
+               .ifnum = 0,
+               .type = QUIRK_MIDI_MIDITECH
+       }
+},

 {
        /*

======================================================================

----------------------------------------------------------------------
 Clemens Ladisch - 02-09-06 09:26 
----------------------------------------------------------------------
Applied; thanks!

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-07-06 11:15 skupin         New Issue                                    
02-09-06 09:26 Clemens LadischStatus                   assigned => resolved
02-09-06 09:26 Clemens LadischResolution               open => fixed       
02-09-06 09:26 Clemens LadischNote Added: 0007972                          
02-09-06 09:26 Clemens LadischStatus                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
