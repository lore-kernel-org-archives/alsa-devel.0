From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: hdsp multiface.
Date: Wed, 02 Jul 2003 21:55:32 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F02D644.4070106@boosthardware.com>
References: <3F027575.2010306@boosthardware.com> <s5h8yrhkyv1.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (UNKNOWN@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id SAA05453
	for <alsa-devel@alsa-project.org>; Wed, 2 Jul 2003 18:45:30 +0200
Received: from www3.webhosting.cx (www3.webhosting.cx [207.44.248.26])
	by gate.perex.cz (Perex's E-mail Delivery System) with ESMTP id 4F3E8DC
	for <alsa-devel@alsa-project.org>; Wed,  2 Jul 2003 16:41:01 +0200 (MEST)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> 
>>Error opening hwdep device on card hw:1.
> 
>   ^^^^^^^^^^^^^^^^^^^
> 
> this message appears when snd_hwdep_open() fails.
> do you have /dev/snd/hwC1D0 with the proper permission?
> 

I realised that cvs is still broken.

So now I'm trying with the 0.9.4 tarballs because cvs is at version 
0.9.0rc6 and I get about ten sets of this from hdsploader if I don't 
modprobe snd-hdsp first. hdsploader will still load the modules:

06903:  symbol=__deregister_frame_info;  lookup in file=hdsploader
06903:  symbol=__deregister_frame_info;  lookup in 
file=/usr/lib/libasound.so.2
06903:  symbol=__deregister_frame_info;  lookup in file=/lib/libm.so.6
06903:  symbol=__deregister_frame_info;  lookup in file=/lib/libdl.so.2
06903:  symbol=__deregister_frame_info;  lookup in file=/lib/libpthread.so.0
06903:  symbol=__deregister_frame_info;  lookup in file=/lib/libc.so.6
06903:  symbol=_IO_flush_all;  lookup in file=hdsploader
06903:  symbol=_IO_flush_all;  lookup in file=/usr/lib/libasound.so.2
06903:  symbol=_IO_flush_all;  lookup in file=/lib/libm.so.6
06903:  symbol=_IO_flush_all;  lookup in file=/lib/libdl.so.2
06903:  symbol=_IO_flush_all;  lookup in file=/lib/libpthread.so.0
06903:  symbol=_IO_flush_all;  lookup in file=/lib/libc.so.6
06903:  symbol=_exit;  lookup in file=hdsploader
06903:  symbol=_exit;  lookup in file=/usr/lib/libasound.so.2
06903:  symbol=_exit;  lookup in file=/lib/libm.so.6
06903:  symbol=_exit;  lookup in file=/lib/libdl.so.2
06903:  symbol=_exit;  lookup in file=/lib/libpthread.so.0
06903:  symbol=_exit;  lookup in file=/lib/libc.so.6


I'm testing as root so these settings should be correct right?

crw-rw----    1 root     audio    116,   4 Jul  3 08:41 hwC0D0
crw-rw----    1 root     audio    116,   5 Jul  3 08:41 hwC0D1


If I load the module before running modprobe snd-hdsp I can see the card
in /proc/asound/cards but then hdsploader says this:

hdsploader - firmware loader for RME Hammerfall DSP cards
Looking for HDSP + Multiface or Digiface cards :
Card 0 : C-Media PCI CMI8738 (model 37) at 0x9800, irq 10
19612:  symbol=strncmp;  lookup in file=hdsploader
19612:  symbol=strncmp;  lookup in file=/usr/lib/libasound.so.2
19612:  symbol=strncmp;  lookup in file=/lib/libm.so.6
19612:  symbol=strncmp;  lookup in file=/lib/libdl.so.2
19612:  symbol=strncmp;  lookup in file=/lib/libpthread.so.0
19612:  symbol=strncmp;  lookup in file=/lib/libc.so.6
Card 1 : RME Hammerfall DSP (Multiface) at 0xe9000000, irq 11
Upload firmware for card hw:1
Error opening hwdep device on card hw:1.

Either way I still get this message from aplay:

aplay -f cd -D hw:1,0 /art/1REC/020403-studio.wav
Playing WAVE '/art/1REC/020403-studio.wav' : Signed 16 bit Little 
Endian, Rate 44100 Hz, Stereo
aplay: set_params:800: Access type not available



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
