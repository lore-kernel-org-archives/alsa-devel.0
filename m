From: "Marc Nostromo [M-.-n]" <marc.nostromo@gmail.com>
Subject: Getting alsa on Caanoo
Date: Fri, 11 May 2012 11:16:38 +0200
Message-ID: <CAEQ8eXOzGoF55nwa0W=GvSwf63tZ1jkp0sQDXMP-0Of=frWKeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f173.google.com (mail-wi0-f173.google.com
	[209.85.212.173])
	by alsa0.perex.cz (Postfix) with ESMTP id 07A3010BB5D
	for <alsa-devel@alsa-project.org>;
	Fri, 11 May 2012 11:16:39 +0200 (CEST)
Received: by wibhj6 with SMTP id hj6so38452wib.2
	for <alsa-devel@alsa-project.org>; Fri, 11 May 2012 02:16:39 -0700 (PDT)
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

Hi,

I'm trying to get alsa to work on an open source korean game console called
the caanoo

http://en.wikipedia.org/wiki/CAANOO

It's open source and pretty cheap with respect to the horse power it
delivers, so using it as base for an embedded synth / sequencer makes a lot
of sense to me.
I've successfully compiled and loaded the modules for audio & midi support
but I'm still stuck with the last step so I wondered if I could get any
help over here, I hope it's the right place to ask.

Right now, when I connect a midi device through USB, I get the following
console message

root@wiz:/mnt/sd/ko_s# dmesg
> usb 1-1: new full speed USB device using UBI9032 Test HCD and address 2
> usb 1-1: configuration #1 chosen from 1 choice
> MIDIStreaming version 01.00
> EP 82: 1 jack(s)
> EP 02: 1 jack(s)
> created 1 output and 1 input ports


And querying /proc/asound gives me


root@wiz:/mnt/sd/ko_s# cat /proc/asound/*
> 0 [nanoKONTROL    ]: USB-Audio =96 nanoKONTROL
> KORG INC. nanoKONTROL at usb-ubisys-usb-1, full speed
> 0: [ 0]   : control
> 1:        : sequencer
> 8: [ 0- 0]: raw midi
> 33:        : timer 0 snd_usb_audio
> G0: system timer : 10000.000us (10000000 ticks)
> Advanced Linux Sound Architecture Driver Version 1.0.15 (Tue Nov 20
> 19:16:42 2007 UTC).



So I'm thinking I'm on the right track.

But I don't see anything in /dev to connect to so I can't really do
anything with my device.

>From what I read here

http://www.gp32x.com/board/index.php?/topic/60064-usbrs232-device-with-the-=
caanoo/page__p__954641&#entry954641

it could be due to the fact /dev is mounted in read-only (and that there's
no /dev/midiXX present) and that I need to create the device file with
mknod.

However I'm not sure of what I should do in the specific context of
midi/audio with alsa. Right now all I'm looking for is raw midi & pcm out.

Could anyone give me a clue as what to try next ?

Thanks a lot
Marc

---
http://www.marc-nostromo.com
