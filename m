From: =?ISO-8859-1?B?ROFtYXNvIEzzcGV6?= <dlopezsk@gmail.com>
Subject: Re: How to cross compile the alsa ?
Date: Tue, 27 Mar 2012 13:47:51 +0200
Message-ID: <CAC-Zu+7Goe2ROEzSNE1CwmQS-i5n=BMTGc1wQk9J4ay3pAUyBQ@mail.gmail.com>
References: <CAC-Zu+6S4WNnqBf1fjbHAQnXwSOEOPQ4UQGBmd15jsZCvL_UHA@mail.gmail.com>
	<4F708A5C.3060406@ladisch.de>
	<CAC-Zu+4RUevh0biAWOJu6niCLpHdtzW-esY3B+X7vxi193AujQ@mail.gmail.com>
	<4F70CE4A.2020001@ladisch.de>
	<CAC-Zu+5N0cjZiGxsptnD165KJFUW9YOi3YVBKSZStAC4Yphwng@mail.gmail.com>
	<CAC-Zu+6+G=ceyy_r863a_f2e__nroNP=RVHaPvYscgYJyk3-Mg@mail.gmail.com>
	<CAC-Zu+6Pb9jjT3-9iTwkQtwRpSd+A6-hsdoBTYFB28vATFbsGA@mail.gmail.com>
	<4F718047.2090405@ladisch.de>
	<CAC-Zu+7ZyJuVRriEW84p4K+TpfmcZo1fRXkDCiQ2AK66kp9r3Q@mail.gmail.com>
	<CAC-Zu+4O8uG=hHHrPaO4mKJatpVbHZqVsBi9vyfMAzRTc3DYWQ@mail.gmail.com>
	<CAC-Zu+55WZfGze3Jk0QNimu+S7jWT1_eDbOs+yVeQOC33PEfzQ@mail.gmail.com>
	<4F719DBF.2060507@ladisch.de>
	<CAC-Zu+55ShwctKwN3bH=efTS_kuPTz_mvo2DVqfoXWhCmpmWqQ@mail.gmail.com>
	<4F71A70A.5050200@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f179.google.com (mail-qc0-f179.google.com
	[209.85.216.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 1233824339
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Mar 2012 13:47:50 +0200 (CEST)
Received: by qcha6 with SMTP id a6so3923744qch.38
	for <alsa-devel@alsa-project.org>; Tue, 27 Mar 2012 04:47:51 -0700 (PDT)
In-Reply-To: <4F71A70A.5050200@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The error messages are:

# arm-gp2x-linux-gcc -o micro micro.c -lasound -static
/usr/lib/gcc/arm-gp2x-linux/4.1.2/../../../../arm-gp2x-linux/lib/libasound.=
a(conf.o):
In function `snd_config_update_free_global':
/home/dam/alsa-lib-1.0.17/src/conf.c:3142: undefined reference to
`pthread_mutex_lock'
/home/dam/alsa-lib-1.0.17/src/conf.c:3151: undefined reference to
`pthread_mutex_unlock'
/usr/lib/gcc/arm-gp2x-linux/4.1.2/../../../../arm-gp2x-linux/lib/libasound.=
a(conf.o):
In function `snd_config_update':
/home/dam/alsa-lib-1.0.17/src/conf.c:3109: undefined reference to
`pthread_mutex_lock'
/home/dam/alsa-lib-1.0.17/src/conf.c:3113: undefined reference to
`pthread_mutex_unlock'
/usr/lib/gcc/arm-gp2x-linux/4.1.2/../../../../arm-gp2x-linux/lib/libasound.=
a(dlmisc.o):
In function `snd_dlsym_verify':
/home/dam/alsa-lib-1.0.17/src/dlmisc.c:115: undefined reference to `dlsym'
/usr/lib/gcc/arm-gp2x-linux/4.1.2/../../../../arm-gp2x-linux/lib/libasound.=
a(dlmisc.o):
In function `snd_dlsym':
/home/dam/alsa-lib-1.0.17/src/dlmisc.c:161: undefined reference to `dlsym'
/usr/lib/gcc/arm-gp2x-linux/4.1.2/../../../../arm-gp2x-linux/lib/libasound.=
a(dlmisc.o):
In function `snd_dlclose':
/home/dam/alsa-lib-1.0.17/src/dlmisc.c:85: undefined reference to `dlclose'
/usr/lib/gcc/arm-gp2x-linux/4.1.2/../../../../arm-gp2x-linux/lib/libasound.=
a(dlmisc.o):
In function `snd_dlopen':
/home/dam/alsa-lib-1.0.17/src/dlmisc.c:64: undefined reference to `dlopen'
/home/dam/alsa-lib-1.0.17/src/dlmisc.c:58: undefined reference to `dladdr'
collect2: ld returned 1 exit status

I repeat that think all copy to generate when I did make install
DESTDIR=3D/tmp/blah, and compile --enable-static=3Dyes

On folder arm-gp2x-linux/lib


2012/3/27 Clemens Ladisch <clemens@ladisch.de>:
> D=E1maso L=F3pez wrote:
>> Ok, I've all files, but to be continued fail
>
> And what error message is it now?
>
>
> Regards,
> Clemens
