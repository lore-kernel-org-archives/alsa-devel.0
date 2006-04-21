From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002051]: USB control failure
Date: Fri, 21 Apr 2006 15:17:10 +0200
Message-ID: <55f24621a8f112715d2f2214aaea85c7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 258BF137
	for <alsa-devel@alsa-project.org>; Fri, 21 Apr 2006 15:17:11 +0200 (MEST)
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
Category:                   CORE - control
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.6.15
======================================================================
Date Submitted:             04-21-2006 14:55 CEST
Last Modified:              04-21-2006 15:17 CEST
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
 xatt - 04-21-06 15:17 
----------------------------------------------------------------------
When working in XWindow i get sometimes 
ALSA lib pcm_direct.c:904:(snd_pcm_direct_initialize_slave) unable to
install hw params
ALSA lib pcm_dmix.c:877:(snd_pcm_dmix_open) unable to initialize slave
libao - OSS cannot set channels to 1

from applications which probably try to play some sound

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-21-06 14:55 xatt           New Issue                                    
04-21-06 14:55 xatt           File Added: config                           
04-21-06 14:55 xatt           Kernel Version            => 2.6.15          
04-21-06 15:17 xatt           Note Added: 0009412                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
