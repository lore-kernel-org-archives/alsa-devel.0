From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002164]: [Alsa-user] VIA 8235 -
	CMI9761A AC'97: 5.1, channels confused / vol controls without effect
Date: Fri, 26 May 2006 20:24:08 +0200
Message-ID: <1d378d3f8d5021f674db7d2eebcaccd8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6155E150
	for <alsa-devel@alsa-project.org>;
	Fri, 26 May 2006 20:24:08 +0200 (MEST)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2164> 
======================================================================
Reported By:                schorpp
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2164
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               debian sarge...sid
Kernel Version:             2.6.16.18
======================================================================
Date Submitted:             05-26-2006 20:24 CEST
Last Modified:              05-26-2006 20:24 CEST
======================================================================
Summary:                    [Alsa-user] VIA 8235 - CMI9761A AC'97: 5.1, channels
confused / vol controls without effect
Description: 
hi

1.
using ac3dec with vdr or /usr/bin/speaker-test with plug:surround51
(/usr/share/alsa/pcm/surround51.conf)
on a (crosschecked with linux cmi8738) sunnyline 5.1 headset it turns out
here that the channels arrangement on the analog output jacks does not 
conform to the "reference" channels order arrangement of the cmedia 9761A
ms-windows driver/user space sw...

a)
BTW in this operating mode the vol mixer controls have no effects here and
sounds seems to lack LFE. Mute controls work partially.
VLC fails using the 5.1 mode of this device, too.

b)
tried extra config without affect (channels order wrong and center/lfe,
rear sound low volume):

schorpp@tom1:~$ grep ac3dec /etc/default/vdr
OPTIONS="-a '/usr/bin/ac3dec -6 -D VIA8233.pcm.duplicate 2>>
/var/log/vdrac3' -w60"
#OPTIONS="-a '/usr/bin/ac3dec -6 -D CMI8738-MC6.pcm.duplicate 2>>
/var/log/vdrac3' -w 60"
#OPTIONS="-a '/usr/bin/ac3dec -D CMI8738-MC6.pcm.duplicate' -w 60"
schorpp@tom1:~$ 

schorpp@tom1:~$            

tom1:/home/schorpp# dpkg -l libasound2*
Desired=Unknown/Install/Remove/Purge/Hold
| Status=Not/Installed/Config-files/Unpacked/Failed-config/Half-installed
|/ Err?=(none)/Hold/Reinst-required/X=both-problems (Status,Err:
uppercase=bad)
||/ Name            Version         Description
+++-===============-===============-==============================================
ii  libasound2      1.0.11-3        ALSA library
ii  libasound2-dev  1.0.11-3        ALSA library development files
ii  libasound2-doc  1.0.11-3        ALSA library developer documentation
ii  libasound2-plug 1.0.11-1        ALSA library additional plugins
tom1:/home/schorpp# 

schorpp@tom1:~$ cat /proc/asound/*
cat: /proc/asound/CMI8738MC6: Is a directory
cat: /proc/asound/D3500: Is a directory
cat: /proc/asound/V8235: Is a directory
cat: /proc/asound/card0: Is a directory
cat: /proc/asound/card1: Is a directory
cat: /proc/asound/card2: Is a directory
 0 [CMI8738MC6     ]: CMI8738-MC6 - C-Media PCI CMI8738-MC6
                      C-Media PCI CMI8738-MC6 (model 55) at 0xd800, irq
177
 1 [V8235          ]: VIA8233 - VIA 8235
                      VIA 8235 with CMI9761 at 0xc800, irq 185
 2 [D3500          ]: USB-Audio - DV 3500
                       DV 3500 at usb-0000:00:10.1-1, full speed
  0: [ 0]   : control
  1:        : sequencer
  4: [ 0- 0]: hardware dependent
 16: [ 0- 0]: digital audio playback
 17: [ 0- 1]: digital audio playback
 18: [ 0- 2]: digital audio playback
 24: [ 0- 0]: digital audio capture
 26: [ 0- 2]: digital audio capture
 32: [ 1]   : control
 33:        : timer
 48: [ 1- 0]: digital audio playback
 49: [ 1- 1]: digital audio playback
 56: [ 1- 0]: digital audio capture
 57: [ 1- 1]: digital audio capture
 64: [ 2]   : control
 88: [ 2- 0]: digital audio capture
00-00: OPL3 FM
 0 snd_cmipci
 1 snd_via82xx
 2 snd_usb_audio
cat: /proc/asound/oss: Is a directory
00-02: CMI8738-MC6 : C-Media PCI IEC958 : playback 1 : capture 1
00-01: CMI8738-MC6 : C-Media PCI 2nd DAC : playback 1
00-00: CMI8738-MC6 : C-Media PCI DAC/ADC : playback 1 : capture 1
01-01: VIA 8235 : VIA 8235 : playback 1 : capture 1
01-00: VIA 8235 : VIA 8235 : playback 4 : capture 1
02-00: USB Audio : USB Audio : capture 1
cat: /proc/asound/seq: Is a directory
G0: system timer : 4000.000us (10000000 ticks)
P0-0-0: PCM playback 0-0-0 : SLAVE
P0-0-1: PCM capture 0-0-1 : SLAVE
P0-1-0: PCM playback 0-1-0 : SLAVE
P0-2-0: PCM playback 0-2-0 : SLAVE
P0-2-1: PCM capture 0-2-1 : SLAVE
P1-0-0: PCM playback 1-0-0 : SLAVE
P1-0-1: PCM capture 1-0-1 : SLAVE
P1-0-2: PCM playback 1-0-2 : SLAVE
P1-0-4: PCM playback 1-0-4 : SLAVE
P1-0-6: PCM playback 1-0-6 : SLAVE
P1-1-0: PCM playback 1-1-0 : SLAVE
P1-1-1: PCM capture 1-1-1 : SLAVE
P2-0-1: PCM capture 2-0-1 : SLAVE
Advanced Linux Sound Architecture Driver Version 1.0.11rc2 (Wed Jan 04
08:57:20 2006 UTC).
schorpp@tom1:~$                   
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-26-06 20:24 schorpp        New Issue                                    
05-26-06 20:24 schorpp        Distribution              => debian sarge...sid
05-26-06 20:24 schorpp        Kernel Version            => 2.6.16.18       
======================================================================
