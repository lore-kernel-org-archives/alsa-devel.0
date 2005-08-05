From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001310]: Driver cant find firmware for Layla24
Date: Fri, 5 Aug 2005 13:26:39 +0200
Message-ID: <9044442012a212f6f105fe9855ba4615@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D2B6820E
	for <alsa-devel@alsa-project.org>; Fri,  5 Aug 2005 13:26:39 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1310> 
======================================================================
Reported By:                oxi
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1310
Category:                   PCI - echoaudio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian Sarge AMD64
Kernel Version:             2.6.12.3
======================================================================
Date Submitted:             08-04-2005 22:50 CEST
Last Modified:              08-05-2005 13:26 CEST
======================================================================
Summary:                    Driver cant find firmware for Layla24
Description: 
Hello,

After modprobe snd-layla24 ,
in dmesg|tail:

ACPI: PCI Interrupt 0000:00:0e.0[A] -> GSI 19 (level, low) -> IRQ 19
ALSA /usr/src/alsa-driver-1.0.9b/pci/echoaudio/echoaudio.c:41:
get_firmware(): Firmware not available (-2)
Echoaudio Layla24: probe of 0000:00:0e.0 failed with error -2

Same issue that another guy is experiencing with a Layla20:
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1244
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0001244 error with firmware with echo layla20
======================================================================

----------------------------------------------------------------------
 rlrevell - 08-05-05 06:03 
----------------------------------------------------------------------
If you just installed the firmware you might also need to restart hotplug:

/etc/init.d/hotplug restart

----------------------------------------------------------------------
 oxi - 08-05-05 13:26 
----------------------------------------------------------------------
debian:/home/oxi# /etc/init.d/alsasound stop
Shutting down sound driver: done
debian:/home/oxi# /etc/init.d/hotplug restart
Stopping hotplug subsystem:
   pci
   pci      [success]
   usb
   usb      [success]
   isapnp
   isapnp   [success]
   ide
   ide      [success]
   input
   input    [success]
   scsi
   scsi     [success]
done.
Starting hotplug subsystem:
   pci
     ohci1394: already loaded
     sata_promise: already loaded
     bttv: already loaded
     bt878: already loaded
     sk98lin: already loaded
     snd-layla24: loaded successfully
     sata_via: already loaded
     via82cxxx: already loaded
     uhci-hcd: loaded successfully
     uhci-hcd: already loaded
     uhci-hcd: already loaded
     uhci-hcd: already loaded
     ehci-hcd: loaded successfully
     i2c-viapro: already loaded
     snd-via82xx: loaded successfully
     ohci1394: already loaded
     ignoring pci display device 02:00.0
     ignoring pci display device 02:00.1
   pci      [success]
   usb
     hci_usb: loaded successfully
     usbhid: already loaded
     hci_usb: already loaded
     hci_usb: already loaded
     hci_usb: already loaded
   usb      [success]
   isapnp
   isapnp   [success]
   ide
   ide      [success]
   input
     evdev: already loaded
     tsdev: already loaded
     mousedev: already loaded
     evdev: already loaded
   input    [success]
   scsi
   scsi     [success]
   ide
   ide      [success]
   input
     evdev: already loaded
     tsdev: already loaded
     mousedev: already loaded
     evdev: already loaded
   input    [success]
   scsi
   scsi     [success]
done.

However when running alsaconf the card isnt there.

And after that, if I run:
debian:/home/oxi# /etc/init.d/alsasound stop
Shutting down sound driver: done
debian:/home/oxi# modprobe snd-layla24

In dmesg|tail, again:
ACPI: PCI Interrupt 0000:00:0e.0[A] -> GSI 19 (level, low) -> IRQ 19
ALSA /usr/src/alsa-driver-1.0.9b/pci/echoaudio/echoaudio.c:41:
get_firmware(): Firmware not available (-2)
Echoaudio Layla24: probe of 0000:00:0e.0 failed with error -2

Btw, thank you very much for the help and support :)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-04-05 22:50 oxi            New Issue                                    
08-04-05 22:50 oxi            Distribution              => Debian Sarge AMD64
08-04-05 22:50 oxi            Kernel Version            => 2.6.12.3        
08-04-05 23:48 rlrevell       Note Added: 0005653                          
08-05-05 04:57 oxi            Note Added: 0005656                          
08-05-05 04:59 oxi            Issue Monitored: oxi                         
08-05-05 05:00 rlrevell       Note Added: 0005657                          
08-05-05 05:20 oxi            Note Added: 0005658                          
08-05-05 05:25 oxi            Note Added: 0005659                          
08-05-05 06:03 rlrevell       Note Added: 0005660                          
08-05-05 08:48 perex          Relationship added       related to 0001244  
08-05-05 13:26 oxi            Note Added: 0005666                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
