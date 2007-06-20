From: "Paul Kavan" <pkavan@gmail.com>
Subject: Re: Using aplay and arecord on an ARM
Date: Wed, 20 Jun 2007 12:04:08 -0500
Message-ID: <61c0054e0706201004o2aac3328me0912debd94feba2@mail.gmail.com>
References: <61c0054e0706191237n666fd422wcf13f874f108e64a@mail.gmail.com>
	<61c0054e0706200739k2b934a9avbffb133937adba4c@mail.gmail.com>
	<61c0054e0706200824v444d6c8dr6b6023b16043fa7@mail.gmail.com>
	<61c0054e0706200827h389e2c6v46dfc544def95e82@mail.gmail.com>
	<61c0054e0706200840k2b0f13c9q57581c380d39d2fc@mail.gmail.com>
	<s5hwsxyaa5r.wl%tiwai@suse.de>
	<61c0054e0706200912m1779bef8gfab9da178bd888b4@mail.gmail.com>
	<75b66ecd0706200916i2105cb49xf40313e0440bc821@mail.gmail.com>
	<61c0054e0706200918pbc56676h60640cb08de633b8@mail.gmail.com>
	<s5htzt2a938.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.174])
	by alsa0.perex.cz (Postfix) with ESMTP id F1A3924347
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Jun 2007 19:04:09 +0200 (CEST)
Received: by ug-out-1314.google.com with SMTP id o2so387662uge
	for <alsa-devel@alsa-project.org>; Wed, 20 Jun 2007 10:04:08 -0700 (PDT)
In-Reply-To: <s5htzt2a938.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Lee Revell <rlrevell@joe-job.com>, Nobin Mathew <nobin.mathew@gmail.com>
List-Id: alsa-devel@alsa-project.org

Gentleman:

I have the alsa-libs and alsa-utils on my board now. I want to thank all for
the time and advice.

For the benefit of the archives, I have a at91sam9260ek running Linux
2.6.22-rc1. I am using buildroot to for my cross-compiling tools and to
generate my rfs. To get the alsa libs and utils on board, I did the
following:

For alsa-libs:
CC=arm-linux-gcc ./configure --target=arm-linux --host=i686-pc-linux-gnu
--prefix=/usr

and then
make install DESTDIR=$HOME/buildroot/build_arm/root/

where the rfs for my target is built in $HOME/buildroot/build_arm/root
before making the image.

For alsa-utils:
CC=arm-linux-gcc ./configure --target=arm-linux --host=i686-pc-linux-gnu
--prefix=/usr
--with-alsa-inc-prefix=$HOME/Linux_Builds/buildroot/build_arm/root/usr/include
--with-alsa-prefix=$HOME/Linux_Builds/buildroot/build_arm/root/usr/lib
--disable-alsamixer

and then
make install DESTDIR=/home/grhuser/buildroot/build_arm/root/

Then I remade the image and booted my board. I do not have the nodes built
automatically yet, so I had to do that....giving me:

/dev/snd $ ls -l
crw-rw-rw-    1 root     root     116,   0 Dec 31 17:08 controlC0
crw-rw-rw-    1 root     root     116,  24 Dec 31 17:09 pcmC0D0c
crw-rw-rw-    1 root     root     116,  16 Dec 31 17:10 pcmC0D0p

when I check with aplay, I get:

/dev/snd $ aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: GRHEKW6811 [GRH_EK_W6811], device 0: W6811 W6811-PCM-0 []
  Subdevices: 1/1
  Subdevice #0: subdevice #0

and with arecord:
/dev/snd $ arecord -l
**** List of CAPTURE Hardware Devices ****
card 0: GRHEKW6811 [GRH_EK_W6811], device 0: W6811 W6811-PCM-0 []
  Subdevices: 1/1
  Subdevice #0: subdevice #0


However, I have been unable to achieve any kind of playback using
speaker-test or aplay. The speaker pops like it wants to play, but I get the
following when trying speaker test:

/dev/snd $ speaker-test -D default -r 8000 -f 1020 -F S8

speaker-test 1.0.14

Playback device is default
Stream parameters are 8000Hz, S8, 1 channels
Using 16 octaves of pink noise
Rate set to 8000Hz (requested 8000Hz)
Buffer size range from 64 to 32768
Period size range from 32 to 8192
Using max buffer size 32768
Periods = 4
was set period_size = 0
was set buffer_size = 32768
Unable to set sw params for playback: Invalid argument
Setting of swparams failed: Invalid argument
/dev/snd $


Anyone know where I should look for the problem?

Thanks.

Paul

***************************************
Paul David Kavan
Project Engineer
GRH Electronics, Inc.
402-734-4900
pkavan@gmail.com
***************************************
