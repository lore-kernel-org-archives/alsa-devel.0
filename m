From: Nicolas Krieger <khenyh@gmail.com>
Subject: Blocked in snd_pcm_open
Date: Wed, 22 Jul 2009 12:01:26 +0200
Message-ID: <3afeb4060907220301l7fc817dblf860aa61c887dedc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.157])
	by alsa0.perex.cz (Postfix) with ESMTP id 7FEB51037E3
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Jul 2009 12:01:46 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id 13so864740fge.21
	for <alsa-devel@alsa-project.org>; Wed, 22 Jul 2009 03:01:46 -0700 (PDT)
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

Hello,

I don't know if I am in the right place to expose my problem, if not, excuse
me.

I have a problem with snd_pcm_open function. The program seems to be blocked
and gdb output shows this is happening while using snd_pcm_open.
I am upgrading a program that reads videos so as to use alsa now. On my
computer, there is no problem. But the problem appears on test computer.

My questions are :

   - is it only a configuration problem (.asoundrc) ?
   - if not, what else could it be ?




_rc = snd_pcm_open(&_handle, "defaultTEST", SND_PCM_STREAM_PLAYBACK,
SND_PCM_NONBLOCK); <= this is line *42 in ../../src/CAudio.cpp* in gdb
output


This a part of gdb when the progam is blocked :

*0x009877a2 in _dl_sysinfo_int80 () from /lib/ld-linux.so.2
(gdb) bt
#0  0x009877a2 in _dl_sysinfo_int80 () from /lib/ld-linux.so.2
#1  0x00bdbd4b in __open_nocancel () from /lib/tls/libpthread.so.0
#2  0xf6fedb9d in open () from /usr/lib/libesddsp.so.0
#3  0x04e7e5f2 in snd_pcm_hw_open () from /lib/libasound.so.2
#4  0x04e7ea90 in _snd_pcm_hw_open () from /lib/libasound.so.2
#5  0x04e70893 in snd_pcm_close () from /lib/libasound.so.2
#6  0x04e70e78 in snd_pcm_close () from /lib/libasound.so.2
#7  0x04e710c9 in snd_pcm_open_slave () from /lib/libasound.so.2
#8  0x04ea4541 in snd_pcm_dmix_open () from /lib/libasound.so.2
#9  0x04ea4aea in _snd_pcm_dmix_open () from /lib/libasound.so.2
#10 0x04e70893 in snd_pcm_close () from /lib/libasound.so.2
#11 0x04e70e78 in snd_pcm_close () from /lib/libasound.so.2
#12 0x04e710c9 in snd_pcm_open_slave () from /lib/libasound.so.2
#13 0x04ea8186 in _snd_pcm_asym_open () from /lib/libasound.so.2
#14 0x04e70893 in snd_pcm_close () from /lib/libasound.so.2
#15 0x04e70e78 in snd_pcm_close () from /lib/libasound.so.2
#16 0x04e710c9 in snd_pcm_open_slave () from /lib/libasound.so.2
#17 0x04e8e1de in _snd_pcm_plug_open () from /lib/libasound.so.2
#18 0x04e70893 in snd_pcm_close () from /lib/libasound.so.2
#19 0x04e70e78 in snd_pcm_close () from /lib/libasound.so.2
#20 0x08065543 in CAudio::openDevice (this=0x87795e0,
sampleRate=@0x8884558<https://messagerie.si.c-s.fr/horde/imp/message.php?index=988#>,
nbChannels=@0x888455c<https://messagerie.si.c-s.fr/horde/imp/message.php?index=988#>,
devicename=@0xfeee8670<https://messagerie.si.c-s.fr/horde/imp/message.php?index=988#>)
at ../../src/CAudio.cpp:42*




.asoundrc I am using :

*pcm.card0 {
    type hw
    card 0
    device 0
}

pcm.card1 {
    type hw
    card 1
    device 0
}

pcm.dmixerDEF {
    type dmix
    ipc_key 1025
    slave {
        pcm card0
        period_time 0
        period_size 2048
        buffer_size 32768
        rate 44100
    }
    bindings {
        0 0
        1 1
    }
}

pcm.dmixerTEST {
    type dmix
    ipc_key 1027
    slave {
        pcm card1
        format S16_LE
        period_time 0
        period_size 2048
        buffer_size 32768
        rate 44100
    }
    #bindings {
    #    0 0
    #    1 1
    #}
}

pcm.DEF {
    type asym

    playback.pcm "dmixerDEF"
    capture.pcm "card0"
}

pcm.TEST {
    type asym

    playback.pcm "dmixerTEST"
    capture.pcm "card1"
}


pcm.!default {
    type plug
    slave.pcm "DEF"
}

pcm.defaultTEST {
    type plug
    slave.pcm "TEST"
}*


Nicolas Krieger
