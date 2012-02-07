From: Jonathan Andrews <jon@jonshouse.co.uk>
Subject: Re: Request for help CM109 on arm board
Date: Tue, 07 Feb 2012 20:35:29 +0000
Message-ID: <1328646929.31394.11.camel@jonspc>
References: <1328630452.28163.11.camel@jonspc>
Reply-To: jon@jonshouse.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.jonshouse.co.uk (unknown [91.84.151.33])
	by alsa0.perex.cz (Postfix) with ESMTP id B3E78103CA5
	for <alsa-devel@alsa-project.org>; Tue,  7 Feb 2012 21:35:30 +0100 (CET)
Received: from [10.10.10.6] (jonspc [10.10.10.6])
	by mail.jonshouse.co.uk (8.14.1/8.13.8) with ESMTP id q17KZSSb011790
	for <alsa-devel@alsa-project.org>; Tue, 7 Feb 2012 20:35:35 GMT
In-Reply-To: <1328630452.28163.11.camel@jonspc>
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

Its bad form, but here is a follow up to my own thread in the hope
somebody will guide my through this maze ?

ALSA lib timer.c:189:(snd_timer_open_noupdate) Unknown timer
hw:CLASS=3,SCLASS=0,CARD=0,DEV=0,SUBDEV=0
ALSA lib timer.c:189:(snd_timer_open_noupdate) Unknown timer
hw:CLASS=3,SCLASS=0,CARD=0,DEV=0,SUBDEV=0
ALSA lib pcm_direct.c:1118:(snd1_pcm_direct_initialize_poll_fd) unable
to open timer 'hw:CLASS=3,SCLASS=0,CARD=0,DEV=0,SUBDEV=0'
ALSA lib pcm_dmix.c:1095:(snd_pcm_dmix_open) unable to initialize
poll_fd
aplay: main:682: audio open error: No such file or directory
ARM # cat /usr/share/alsa/alsa.conf
pcm.snd_card {
    type hw
    card 0
    device 0
}

pcm.!default {
    type plug
    slave.pcm "dmixer"
}
 
pcm.dsp0 {
    type plug
    slave.pcm "dmixer"
}

pcm.dmixer  {
    type dmix
    ipc_key 1024
    slave {
        pcm "snd_card"
        period_time 0
        period_size 1024
        buffer_size 8192
        # periods 128
        rate 44100
    }
    bindings {
        0 0
        1 1
    }
}
 
ctl.mixer0 {
    type hw
    card 0
}


ARM # lsmod
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




this alsa.conf works, but with no digital mixer
pcm.!default {
    type hw
    card 0
}
ctl.!default {
    type hw
    card 0
}


# cat /proc/asound/version 
Advanced Linux Sound Architecture Driver Version 1.0.23.

ARM # cat /proc/asound/cards 
 0 [default        ]: USB-Audio - Generic USB Audio Device   
                      Generic USB Audio Device    at usb-ep93xx-3, full
speed
ARM # cat /proc/asound/devices 
  0: [ 0]   : control
 16: [ 0- 0]: digital audio playback
 24: [ 0- 0]: digital audio capture
 33:        : timer




http://alsa.opensrc.org/Dmix
NOTE: For ALSA 1.0.9rc2 and higher you don't need to setup dmix for
analogue output. Dmix is enabled by default for soundcards which don't
support hardware mixing. You still need to set it up for digital
outputs.

Yea .....  right .....
