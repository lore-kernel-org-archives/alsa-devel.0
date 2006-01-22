From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001748]: sound driver will not load (CS4237B chip)
Date: Sun, 22 Jan 2006 20:52:04 +0100
Message-ID: <a4cb907bbf492f0d4ac4676e454165b2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7DC47FE
	for <alsa-devel@alsa-project.org>; Sun, 22 Jan 2006 20:52:04 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1748> 
======================================================================
Reported By:                briand
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1748
Category:                   ISA - cs4236
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Fedora Core 3
Kernel Version:             2.6.9-1.667
======================================================================
Date Submitted:             01-14-2006 23:47 CET
Last Modified:              01-22-2006 20:52 CET
======================================================================
Summary:                    sound driver will not load (CS4237B chip)
Description: 
with BIOS set to "PnPOS" for sound chip:
  `/sbin/modprobe snd-cs4236` produces the following on stdout:
  "FATAL: Error inserting snd_cs4236 \
   (/lib/modules/2.6.9-1.667/kernel/sound/isa/cs423x/snd-cs4236.ko): \
   No such device"

   -- occurs with 1.0.10, 1.0.11rc1, and (currently) 1.0.11rc2
   alsaconf reports I have no sound card.
   cat /proc/asound/cards reports I have no sound card.


with BIOS set to "Enable" for sound chip:

 `/sbin/modprobe snd-cs4236 port=0x530 cport=0x538 isapnp=0 dma1=1 dma2=0
irq=5`

  ..produces nothing on stdout/stderr, but the laptop speakers click once,
and dmesg shows:

 "ALSA /path/to/alsa/source/isa/cs423x/cs4236_lib.c:305: CS4236+ chip
detected, but control port 0x538 is not valid"

  - that message shows up in dmesg regardless of what i specify for
'cport=' parameter (with, of course, the corresponding port value in the
error message).

  alsaconf seems to find the card, test the card, and reports all is fine;
offers to modify /etc/modprobe.conf (with parameters shown above), and
congratulates me.
  cat /proc/asound/cards reports I have no sound card.


In looking at cs4236_lib.c, lines 301-307:

        ver1 = snd_cs4236_ctrl_in(chip, 1);
        ver2 = snd_cs4236_ext_in(chip, CS4236_VERSION);
        snd_printdd("CS4236: [0x%lx] C1 (version) = 0x%x, ext = 0x%x\n",
cport, ver1, ver2);
        if (ver1 != ver2) {
                snd_printk("CS4236+ chip detected, but control port 0x%lx
is not valid\n", cport);
                snd_device_free(card, chip);
                return -ENODEV;
        }

  ...it looks like ver1 and ver2 aren't agreeing.  ;)   Okay, so I
experimented a bit.  I commented out (#if 0 ... #endif) the if (ver1 !=
ver2) {...} block, and added:

   snd_printk("CS4236: [0x%lx] C1 (version) = 0x%x, ext = 0x%x\n", cport,
ver1, ver2);

 ...recompiled, reinstalled... and then:

  `modprobe snd-cs4236 port=0x530 cport=0x538 isapnp=0 dma1=1 dma2=0
irq=5`

  results in:

   /dev/dsp, /dev/audio, /dev/snd/* all appear, laptop speakers click once
(as before), followed quickly by a <blart>, and we're on our way...
almost.

  my shorthand dmesg (printk) shows me that the driver was unloading
because 0xFF did not equal 0xE8. (I'm going from memory here.  I'm
positive that the value of "ver1" was 0xFF -- not quite sure about "ver2",
but it's close.  ..it definitely wasn't 0xFF (obviously!) which is why the
driver load aborted).

  cat /proc/asound/cards reports card 0 is a CS4237B at IRQ 5, DMA 1,0

  in KDE, kmix loads and allows me to play with buttons/sliders - I can
get CD audio to play out the laptop speakers, but other audio does not
work.  xmms will load an mp3 file, but when I click the play button, the
display shows 0:00, and nothing plays.  No sound, and the "progress bar"
and "time remaining" stay at 0.

  in terminal, `alsamixer` results in a segmentation fault.

  ..incidentally, in this "hacked" module, it doesn't really matter what
(reasonable) value I specify for cport= in /etc/modprobe.conf (0x538,
0x120, 0x110 ...).  The result is the same.  kmix allows some adjustment,
cd audio plays, no other sound, and alsamixer seg faults.  No doubt, if I
were to work at it, I could generate a kernel panic with the right
value... ;)




======================================================================

----------------------------------------------------------------------
 perex - 01-22-06 19:45 
----------------------------------------------------------------------
hmm. does FC3 have sysfs enabled (post output from mount here)? the
directory /sys/bus/pnp should exist...

----------------------------------------------------------------------
 briand - 01-22-06 20:52 
----------------------------------------------------------------------
[root@scribbler ~]# mount
/dev/hda5 on / type ext3 (rw)
none on /proc type proc (rw)
none on /sys type sysfs (rw)
none on /dev/pts type devpts (rw,gid=5,mode=620)
usbfs on /proc/bus/usb type usbfs (rw)
/dev/hda2 on /boot type ext3 (rw)
none on /dev/shm type tmpfs (rw)
none on /proc/sys/fs/binfmt_misc type binfmt_misc (rw)
sunrpc on /var/lib/nfs/rpc_pipefs type rpc_pipefs (rw)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-14-06 23:47 briand         New Issue                                    
01-14-06 23:47 briand         Distribution              => Fedora Core 3   
01-14-06 23:47 briand         Kernel Version            => 2.6.9-1.667     
01-14-06 23:51 briand         Issue Monitored: briand                      
01-21-06 03:48 briand         Note Added: 0007733                          
01-21-06 04:13 rlrevell       Note Added: 0007734                          
01-21-06 14:41 briand         Note Added: 0007739                          
01-22-06 10:18 perex          Note Added: 0007744                          
01-22-06 17:38 briand         Note Added: 0007750                          
01-22-06 19:45 perex          Note Added: 0007751                          
01-22-06 20:52 briand         Note Added: 0007752                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
