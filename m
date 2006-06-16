From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002214]: Problem recording sound from
	an USB device.
Date: Fri, 16 Jun 2006 23:53:46 +0200
Message-ID: <32ec3926cda8c92c6e8cfdbfc78e1ee0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DCA2E181
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Jun 2006 23:53:46 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2214> 
======================================================================
Reported By:                nbaggus
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   2214
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               gentoo
Kernel Version:             2.6.16-r9
======================================================================
Date Submitted:             06-16-2006 23:41 CEST
Last Modified:              06-16-2006 23:53 CEST
======================================================================
Summary:                    Problem recording sound from an USB device.
Description: 
Equipment used: yealink usb Cyber phone
Sound applications just hang when trying to read from the device.

(kphone, arecord etc.) 
This is equivalent to bug 1903, except that now the kernel standard
version is used and not a whole range of alsa-driver kits.


======================================================================

----------------------------------------------------------------------
 nbaggus - 06-16-06 23:53 
----------------------------------------------------------------------
Dmesg output...

usb 2-2: new full speed USB device using ohci_hcd and address 6
usb 2-2: new full speed USB device using ohci_hcd and address 7
usb 2-2: configuration #1 chosen from 1 choice
usbaudio: device 7 audiocontrol interface 0 has 1 input and 1 output
AudioStreaming interfaces
usbaudio: valid input sample rate 8000
usbaudio: device 7 interface 1 altsetting 1: format 0x00000010 sratelo
8000 sratehi 8000 attributes 0x00
usbaudio: valid output sample rate 8000
usbaudio: device 7 interface 2 altsetting 1: format 0x00000010 sratelo
8000 sratehi 8000 attributes 0x00
usbaudio: registered dsp 14,19
usbaudio: constructing mixer for Terminal 3 type 0x0301
usbaudio: registered mixer 14,16
usbaudio: constructing mixer for Terminal 4 type 0x0101
usbaudio: registered mixer 14,32
usb_audio_parsecontrol: usb_audio_state at d9cf0360
input: Yealink usb-p1k as /class/input/input4

Here the kphone program just hangs....
after kill kphone nothing happens:

Unplugging the device gives:

drivers/usb/input/yealink.c: urb_irq_callback - urb status -110
drivers/usb/input/yealink.c: urb_ctl_callback - urb status -110
usb 2-2: USB disconnect, address 7
drivers/usb/input/yealink.c: urb_irq_callback - urb status -108
drivers/usb/input/yealink.c: urb_irq_callback - usb_submit_urb failed -19
usbaudio: unregister dsp 14,19
usbaudio: unregister mixer 14,16
usbaudio: unregister mixer 14,32

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-16-06 23:41 nbaggus        New Issue                                    
06-16-06 23:41 nbaggus        Distribution              => gentoo          
06-16-06 23:41 nbaggus        Kernel Version            => 2.6.16-r9       
06-16-06 23:53 nbaggus        Note Added: 0010260                          
======================================================================
