From: Jason Heeris <heerij01@student.uwa.edu.au>
Subject: Set fragment size for USB sound card
Date: Tue, 01 May 2007 12:15:33 +0800
Message-ID: <1177992933.4464.20.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vscan03.westnet.com.au (vscan03.westnet.com.au [203.10.1.142])
	by alsa0.perex.cz (Postfix) with ESMTP id 04F2624399
	for <alsa-devel@alsa-project.org>;
	Tue,  1 May 2007 06:12:31 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by localhost (Postfix) with ESMTP id 9C5AFB60336
	for <alsa-devel@alsa-project.org>; Tue,  1 May 2007 12:12:26 +0800 (WST)
Received: from vscan03.westnet.com.au ([127.0.0.1])
	by localhost (vscan03.westnet.com.au [127.0.0.1]) (amavisd-new,
	port 10024) with ESMTP id 13536-01 for <alsa-devel@alsa-project.org>;
	Tue,  1 May 2007 12:12:06 +0800 (WST)
Received: from [192.168.1.101] (dsl-58-7-135-118.wa.westnet.com.au
	[58.7.135.118])
	by vscan03.westnet.com.au (Postfix) with ESMTP id 9E957B602B8
	for <alsa-devel@alsa-project.org>; Tue,  1 May 2007 12:12:02 +0800 (WST)
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

System: NEC Versa M540 laptop
Dist: Debian Etch/Lenny
Kernel: 2.6.18
Alsa: using drivers in kernel, although no difference when compiled from
alsa-source package.
Card in question: C-Media USB sound card (more info below)

Hi there,

I realise that this may not be strictly a developer list question, but
someone on the alsa-user list suggested I try here. Any help would be
appreciated.

The question is a continuation of:

http://sourceforge.net/mailarchive/forum.php?thread_name=1176015858.4497.9.camel%40localhost.localdomain&forum_name=alsa-user
and
http://www.linuxquestions.org/questions/showthread.php?t=540205

Essentially, I have a C-Media USB audio adaptor with which to use my
headphones, and it only works with a fragment size of 2048 or less
(discovered using 'alsaplayer -f 2048'). I would like to be able to plug
it in, have ALSA recognise it and use this fragment size for it.

Without specifying this fragment size, I get:

--
$ alsaplayer -i text -o alsa -d hw:2 /usr/share/sounds/generic.wav 
Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 32
CHANNELS: 2
RATE: 44100
PERIOD_TIME: (23219 23220)
PERIOD_SIZE: 1024
PERIOD_BYTES: 4096
PERIODS: 8
BUFFER_TIME: (185759 185760)
BUFFER_SIZE: 8192
BUFFER_BYTES: 32768
TICK_TIME: 1000
failed to configure output device...trying OSS


...done playing
--

...and the sound comes through the laptop speakers. I tried defining a
slave PCM:

--
pcm.usbtest {
        type dmix
        ipc_key 192837465
        ipc_key_add_uid true
        slave {
                pcm "hw:2,0"
                # period_size 2048
                buffer_size 2048
        }
}
--

But trying 'alsaplayer -i text -o alsa -d
usbtest /usr/share/sounds/generic.wav' gave exactly the same error.

>From my previous post:

--

...I also tried forcing the index of the card by adding the
following to /etc/modprobe.d/alsa-base, but even this only works half of
the time:

--
# Prevent abnormal drivers from grabbing index 0
options snd-bt87x index=-2
options snd-cx88_alsa index=-2
options snd-atiixp-modem index=-2
# options snd-intel8x0m index=-2
options snd-via82xx-modem index=-2

options snd-intel8x0 index=0
options snd-intel8x0m index=1
options snd-usb-audio index=2 vid=0d8c pid=000c
options snd-usb-audio index=3
--

The contents of '/proc/asound/cards' are:

--
 0 [I82801DBICH4   ]: ICH4 - Intel 82801DB-ICH4
                      Intel 82801DB-ICH4 with ALC655 at 0xf0000400, irq
5
 1 [Modem          ]: ICH-MODEM - Intel 82801DB-ICH4 Modem
                      Intel 82801DB-ICH4 Modem at 0xe200, irq 5
 2 [default        ]: USB-Audio - C-Media USB Headphone Set  
                      C-Media USB Headphone Set   at usb-0000:00:1d.1-1,
full speed
--

...although sometimes the ICH-MODEM is missing and the C-Media card is
at #1.

Card information from 'lsusb':

Bus 002 Device 003: ID 0d8c:000c C-Media Electronics, Inc. Audio Adapter

Usually I boot with the card plugged in, but if I plug it in after
booting, the new modules loaded are: snd_hwdep, snd_rawmidi,
snd_usb_audio and snd_usb_lib.
--

Anyway, as I said, any help would be appreciated.

Cheers,
Jason
