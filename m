From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: hdsp multiface.
Date: Wed, 02 Jul 2003 15:02:29 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F027575.2010306@boosthardware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from www3.webhosting.cx (IDENT:7hITkoWn4fR/usJRA/S/GLstu+L5GFtH@www3.webhosting.cx [207.44.248.26])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id IAA27892
	for <alsa-devel@alsa-project.org>; Wed, 2 Jul 2003 08:44:31 +0200
Received: from [61.73.34.157] (helo=boosthardware.com)
	by www3.webhosting.cx with asmtp (Exim 4.20)
	id 19XbLn-0002V6-22
	for alsa-devel@alsa-project.org; Wed, 02 Jul 2003 08:44:19 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I have this device and with the latest incarnation of the driver I 
cannot get audio out. I had it working about 6 months ago but things 
have changed a lot since then.

It will initialise and I provide an entry in /proc/asound/.


-----
./hdsploader
hdsploader - firmware loader for RME Hammerfall DSP cards
Looking for HDSP + Multiface or Digiface cards :
Card 0 : C-Media PCI CMI8738 (model 37) at 0x9800, irq 10
Card 1 : RME Hammerfall DSP (Multiface) at 0xe9000000, irq 11
Upload firmware for card hw:1
Error opening hwdep device on card hw:1.
-----

0 [first          ]: CMI8738 - C-Media PCI CMI8738
                      C-Media PCI CMI8738 (model 37) at 0x9800, irq 10
1 [hdsp           ]: H-DSP - Hammerfall DSP
                      RME Hammerfall DSP (Multiface) at 0xe9000000, irq 11
-----

I don't have a win partition so cannot check if it is the firmware 
loading problem others have witnessed.

This device has not been flashed.

//I'm not sure how to find out the firmware revision.

This is from lspci.

00:0d.0 Multimedia audio controller: Xilinx, Inc.: Unknown device 3fc5 
(rev 0a)

I use this command to set the mixer levels for the line out:
--------------
amixer -D hw:1 cset numid=5 0,0,16384
numid=5,iface=PCM,name='Mixer'
   ; type=INTEGER,access=rw---,values=3,min=0,max=65536,step=1
   : values=16384,0,0
--------------

This is what aplay returns but jack will connect:

--------------
aplay -f cd -D hw:1,0 file.wav
Playing WAVE '/art/1REC/020403-studio.wav' : Signed 16 bit Little 
Endian, Rate 44100 Hz, Stereo
aplay: set_params:800: Access type not available
--------------

With jack I can connect alsaplayer but I get not sound from the outputs.


  jack_lsp
alsa_pcm:capture_1
alsa_pcm:capture_2
alsa_pcm:capture_3
alsa_pcm:capture_4
alsa_pcm:capture_5
alsa_pcm:capture_6
alsa_pcm:capture_7
alsa_pcm:capture_8
alsa_pcm:capture_9
alsa_pcm:capture_10
alsa_pcm:capture_11
alsa_pcm:capture_12
alsa_pcm:capture_13
alsa_pcm:capture_14
alsa_pcm:capture_15
alsa_pcm:capture_16
alsa_pcm:capture_17
alsa_pcm:capture_18
alsa_pcm:playback_1
alsa_pcm:playback_2
alsa_pcm:playback_3
alsa_pcm:playback_4
alsa_pcm:playback_5
alsa_pcm:playback_6
alsa_pcm:playback_7
alsa_pcm:playback_8
alsa_pcm:playback_9
alsa_pcm:playback_10
alsa_pcm:playback_11
alsa_pcm:playback_12
alsa_pcm:playback_13
alsa_pcm:playback_14
alsa_pcm:playback_15
alsa_pcm:playback_16
alsa_pcm:playback_17
alsa_pcm:playback_18



-- 
Patrick Shirkey - Boost Hardware Ltd.
Http://www.boosthardware.com
Http://www.djcj.org - The Linux Audio Users guide
========================================

Being on stage with the band in front of crowds shouting, "Get off! No! 
We want normal music!", I think that was more like acting than anything 
I've ever done.

Goldie, 8 Nov, 2002
The Scotsman



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
