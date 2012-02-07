From: Jonathan Andrews <jon@jonshouse.co.uk>
Subject: Request for help CM109 on arm board
Date: Tue, 07 Feb 2012 16:00:52 +0000
Message-ID: <1328630452.28163.11.camel@jonspc>
Reply-To: jon@jonshouse.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.jonshouse.co.uk (unknown [91.84.151.33])
	by alsa0.perex.cz (Postfix) with ESMTP id 995CA244DE
	for <alsa-devel@alsa-project.org>; Tue,  7 Feb 2012 17:00:53 +0100 (CET)
Received: from [10.10.10.6] (jonspc [10.10.10.6])
	by mail.jonshouse.co.uk (8.14.1/8.13.8) with ESMTP id q17G0pKs028407
	for <alsa-devel@alsa-project.org>; Tue, 7 Feb 2012 16:00:58 GMT
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi all,

I've written an application on the PC that works with alsa, it uses 8
mono 22050Hz 16 bit audio channels via alsa.

I'm trying to port the application to an Arm board with only a CM109 via
USB.

I have a working alsa library, I can play raw audio via the aplay
utility and record via arecord ok.

My problem is I don't understand the alsa configuration in enough detail
to get it right. At the moment I have an alsa.conf cribbed from google,
seems to work but only as a passthough.

# cat /usr/share/alsa/alsa.conf_old 
pcm.!default {
    type hw
    card 0
}
ctl.!default {
    type hw
    card 0
} 


ARM / # lsmod
snd_usb_audio 65715 0 - Live 0xbf082000
snd_hwdep 4756 1 snd_usb_audio, Live 0xbf07b000
snd_pcm 54351 1 snd_usb_audio, Live 0xbf062000
snd_timer 14870 1 snd_pcm, Live 0xbf058000
snd_page_alloc 3336 1 snd_pcm, Live 0xbf052000
snd_usbmidi_lib 14853 1 snd_usb_audio, Live 0xbf048000
snd_rawmidi 14657 1 snd_usbmidi_lib, Live 0xbf03d000
snd_seq_device 4675 1 snd_rawmidi, Live 0xbf036000
cm109 6943 0 - Live 0xbf011000
dm9601 5583 0 - Live 0xbf00a000
usbnet 11888 1 dm9601, Live 0xbf000000
ARM / # cat /proc/asound/cards 
 0 [default        ]: USB-Audio - Generic USB Audio Device   
                      Generic USB Audio Device    at usb-ep93xx-3, full
speed
ARM / # cat /proc/asound/devices 
  0: [ 0]   : control
 16: [ 0- 0]: digital audio playback
 24: [ 0- 0]: digital audio capture
 33:        : timer
ARM / # 



I do not have enough of a machine or distribution to use the alsaconf
utility. Could someone help me with an alsa.conf that will do what
roughly what I am after : 

IE to allow an application to open N channels each 22050Hz 16 bit mono
to be mixed and resampled for an output via a CM109 that only provides
44.1 or 48Khz 16 bit interleaved ... phew ...

Thanks,
Jon
