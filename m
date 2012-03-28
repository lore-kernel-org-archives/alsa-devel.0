From: =?ISO-8859-1?B?ROFtYXNvIEzzcGV6?= <dlopezsk@gmail.com>
Subject: Re: How to cross compile the alsa ?
Date: Wed, 28 Mar 2012 13:08:19 +0200
Message-ID: <CAC-Zu+4WXgJB-7zcgJ2c6k90rEdVWAjXc1dKh+iKwi5VuPQumQ@mail.gmail.com>
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
	<CAC-Zu+7Goe2ROEzSNE1CwmQS-i5n=BMTGc1wQk9J4ay3pAUyBQ@mail.gmail.com>
	<4F71B479.5010408@ladisch.de>
	<CAC-Zu+5OYptjci2+tcoKQq8GZo94bEAqQoxqD0zrmqDYCjcfvQ@mail.gmail.com>
	<CAC-Zu+47SrCzFM_bLDYfahJFXRbxwsboy-Cf5ZM42oSoFXjZ=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f179.google.com (mail-qc0-f179.google.com
	[209.85.216.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 4C6A1103F4B
	for <alsa-devel@alsa-project.org>;
	Wed, 28 Mar 2012 13:08:20 +0200 (CEST)
Received: by qcha6 with SMTP id a6so569521qch.38
	for <alsa-devel@alsa-project.org>; Wed, 28 Mar 2012 04:08:19 -0700 (PDT)
In-Reply-To: <CAC-Zu+47SrCzFM_bLDYfahJFXRbxwsboy-Cf5ZM42oSoFXjZ=w@mail.gmail.com>
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

Hi Clemens and friends,

I've some problem referents with alsa and get volume from mircophone:

1.- When to compile the file ,returned these lines.Could be problem to keep?

arm-gp2x-linux-gcc -o micro micro.c -lasound -static -lpthread -ldl -lm -lrt
/usr/lib/gcc/arm-gp2x-linux/4.1.2/../../../../arm-gp2x-linux/lib/libasound.=
a(dlmisc.o):
In function `snd_dlopen':
/home/dam/alsa-lib-1.0.17/src/dlmisc.c:64: warning: Using 'dlopen' in
statically linked applications requires at runtime the shared
libraries from the glibc version used for linking

2.- The previous to say, despite being a warning can create executable
file. But when return:

ALSA lib conf.c:3009:(snd_config_update_r) Cannot access file
/usr/share/alsa/alsa.conf
ALSA lib control.c:909:(snd_ctl_open_noupdate) Invalid CTL default
Ret -2
Mic volume is -1

I'm sorpress because not exist this file, but the route /usr/share/
has others folders differents of alsa, Does it change the route?

2012/3/27 D=E1maso L=F3pez <dlopezsk@gmail.com>:
> Hi again,
>
> Another question, how I can get the volume of the microphone real=3D
> dynamic? I like getting volume of the micro, to change volume of
> speakers.
>
> I don't know if I will explain .
>
> 2012/3/27 D=E1maso L=F3pez <dlopezsk@gmail.com>:
>> Hi Clemens,
>>
>> I added 2 parameters and return:
>>
>> # arm-gp2x-linux-gcc -o microphone microphone.c -lasound -static -ldl -l=
pthread
>>
>> /usr/lib/gcc/arm-gp2x-linux/4.1.2/../../../../arm-gp2x-linux/lib/libasou=
nd.a(dlmisc.o):
>> In function `snd_dlopen':
>>
>> /home/dam/alsa-lib-1.0.17/src/dlmisc.c:64: warning: Using 'dlopen' in
>> statically linked applications requires at runtime the shared
>> libraries from the glibc version used for linking
>>
>>
>>
>>
>> 2012/3/27 Clemens Ladisch <clemens@ladisch.de>:
>>> D=E1maso L=F3pez wrote:
>>>> # arm-gp2x-linux-gcc -o micro micro.c -lasound -static
>>>
>>> You still do not have -ldl and -lpthread.
>>>
>>>
>>> Regards,
>>> Clemens
