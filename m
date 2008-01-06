From: "Adrian McMenamin" <lkmladrian@gmail.com>
Subject: Cross compiling alsa-lib (again)
Date: Sun, 6 Jan 2008 23:42:40 +0000
Message-ID: <8b67d60801061542o2673384oad87e11bd56012d4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.191])
	by alsa0.perex.cz (Postfix) with ESMTP id DBC36103810
	for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2008 00:42:42 +0100 (CET)
Received: by mu-out-0910.google.com with SMTP id i10so5551183mue.3
	for <alsa-devel@alsa-project.org>; Sun, 06 Jan 2008 15:42:42 -0800 (PST)
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
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Well, I searched through 96 weeks of archived alsa-devel postings to
get to this one:

http://article.gmane.org/gmane.linux.alsa.devel/37120

(Which shows I am doing the right thing in any case.)

This post recommends this:

CFLAGS="-Os -m4 -ml" ./configure --prefix=/usr
--host=sh4-unknown-linux-gnu --target=sh4-unknown-linux-gnu
--build=i686-pc-linux-gnu

I admit to not using the additional cflags stuff before, but even if I use this:

CFLAGS="-Os -m4 -ml" ./configure --host=sh4-linux --prefix=/usr
CC=/home/adrian/dreamy-linux/buildroot/build_sh4/staging_dir/bin/sh4-linux-gcc
--disable-python --disable-rawmidi --enable-static
--with-confdir=/home/adrian/dreamy-linux/buildroot/project_build_sh4/dreamcast/root/usr/share/alsa
 --disable-mixer --enable-static=yes --enable-shared=no
--target=sh4-linux --build=i686-linux

Followed by:

make and
make DESTDIR=/home/adrian/dreamy-linux/buildroot/project_build_sh4/dreamcast/root
install

I still get this:

$ aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: AICA [AICA], device 0: AICA PCM [AICA PCM]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

Followed by:

$ aplay -L
null
    Discard all samples (playback) or generate zero samples (capture)

$ aplay /aine-email.wav
Playing WAVE '/aine-email.wav' : Unsigned 8 bit, Rate 8000 Hz, Mono
ALSA lib pcm_plug.c:773:(snd_pcm_plug_hw_refine_schange) Unable to
find an usable access for '(null)'
aplay: set_params:895: Access type not available

$ aplay -D hw:0,0 /aine-email.wav
Playing WAVE '/aine-email.wav' : Unsigned 8 bit, Rate 8000 Hz, Mono
aplay: set_params:895: Access type not available

Just as before. Any clues?
