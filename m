From: Tommi Rantala <tt.rantala@gmail.com>
Subject: =?windows-1252?Q?sound=2Foss=2Fad1848=2Ec=3A2867=3A32=3A_warning=3A_=91id=5Ftable=92_?=
	=?windows-1252?Q?defined_but_not_used?=
Date: Thu, 13 Jun 2013 18:23:02 +0300
Message-ID: <CA+ydwtrDxmywNPmJZqviYWNPUhati=Khq764cDN06uKKRo3xUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hello, I'm seeing the following compiler warning, does it look useful?
I'm doing a v3.10-rc5 x86-64 build.

/build/linux/sound/oss/ad1848.c:2867:32: warning: =91id_table=92 define=
d
but not used [-Wunused-variable]

$ gcc --version
gcc (Ubuntu/Linaro 4.7.3-1ubuntu1) 4.7.3
Copyright (C) 2012 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is=
 NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURP=
OSE.

config:
http://fpaste.org/18443/13711363/

Tommi
