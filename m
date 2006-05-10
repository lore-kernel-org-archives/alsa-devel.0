From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002051]: USB control failure
Date: Wed, 10 May 2006 09:14:27 +0200
Message-ID: <c1402bc5e1341637cb436b1dfb6932b0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 29D6816D
	for <alsa-devel@alsa-project.org>; Wed, 10 May 2006 09:14:27 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2051> 
======================================================================
Reported By:                xatt
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2051
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.6.15
======================================================================
Date Submitted:             04-21-2006 14:55 CEST
Last Modified:              05-10-2006 09:14 CEST
======================================================================
Summary:                    USB control failure
Description: 
  Hi!
  I have Audigy 2 NX USB sound card and was trying to install it on my
Fedora Core5. The version of my kernel is 2.6.15. Recompiled it hundred
times :). All work with sound card ends up with message from kernel:

ALSA /root/ALSA/alsa-driver-1.0.11/usb/usbaudio.c:1330: 2:1:3:
usb_set_interface failed

  I thought that it was some other module blocking the USB control and
turned off all unnecessary options in kernel, but that doesn't seem to
help.
  I checked 'aplay -l' and /proc/asound, 

[root@ghostchaser ~]# aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: NX [SB Audigy 2 NX], device 0: USB Audio [USB Audio]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

   Soundcard also detected in /proc/asound.

   I'm stumped around this problem and submit some additional
files.(kernel config, modprobe.conf, asound.conf)
======================================================================

----------------------------------------------------------------------
 xatt - 05-10-06 09:05 
----------------------------------------------------------------------
Sorry for too late answer, was training and just couldn't get to my working
place.
  File /proc/asound/card0/stream0   does not exist
  
  /proc/asound/card0 exists and has some info on sound card, but file
  /proc/asound/card0/audigy2nx has the following contents:

SB Audigy 2 NX jacks

dig in : ?
line in: ?
spk out: ?
hph out: ?

Tried:
[root@ghostchaser ~]# aplay -D plughw:0 /mnt/winD/mp3/cc/i_am.wav
Playing WAVE '/mnt/winD/mp3/cc/i_am.wav' : Signed 16 bit Little Endian,
Rate 22050 Hz, Mono
aplay: set_params:961: Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 16
CHANNELS: 1
RATE: 22050
PERIOD_TIME: 125000
PERIOD_SIZE: (2756 2757)
PERIOD_BYTES: (5512 5514)
PERIODS: (3 5)
BUFFER_TIME: 500000
BUFFER_SIZE: 11025
BUFFER_BYTES: 22050
TICK_TIME: 4000

----------------------------------------------------------------------
 xatt - 05-10-06 09:14 
----------------------------------------------------------------------
I put error return in usbaudio.c

        int my_res;
        /* set interface */
        if (subs->interface != fmt->iface || subs->format !=
fmt->altset_idx) {
                if ((my_res = usb_set_interface(dev, fmt->iface,
fmt->altsetting)) < 0) {
                        snd_printk(KERN_ERR "%d:%d:%d: usb_set_interface
failed,err = %d\n",
                                   dev->devnum, fmt->iface,
fmt->altsetting,my_res);



This returns -71, now trying to identify error

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-21-06 14:55 xatt           New Issue                                    
04-21-06 14:55 xatt           File Added: config                           
04-21-06 14:55 xatt           Kernel Version            => 2.6.15          
04-21-06 15:17 xatt           Note Added: 0009412                          
04-21-06 17:09 Clemens LadischCategory                 CORE - control => USB -
usb-audio
04-21-06 17:13 Clemens LadischNote Added: 0009419                          
05-10-06 09:05 xatt           Note Added: 0009703                          
05-10-06 09:14 xatt           Note Added: 0009704                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
