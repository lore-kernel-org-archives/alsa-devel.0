From: =?ISO-8859-1?B?ROFtYXNvIEzzcGV6?= <dlopezsk@gmail.com>
Subject: Re: How to cross compile the alsa ?
Date: Thu, 29 Mar 2012 09:24:48 +0200
Message-ID: <CAC-Zu+5pyC9=yYH=CsbY5v_3uEoicwuvka3FoC_rfy==Gz+GdA@mail.gmail.com>
References: <CAC-Zu+6S4WNnqBf1fjbHAQnXwSOEOPQ4UQGBmd15jsZCvL_UHA@mail.gmail.com>
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
	<CAC-Zu+4WXgJB-7zcgJ2c6k90rEdVWAjXc1dKh+iKwi5VuPQumQ@mail.gmail.com>
	<CAC-Zu+6S49pR0P_s1k8nLdJHE3pnrkWnhk4fqWOTNxHOCFsAtg@mail.gmail.com>
	<4F74073E.5090300@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f51.google.com (mail-qa0-f51.google.com
	[209.85.216.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 492B2104385
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Mar 2012 09:24:50 +0200 (CEST)
Received: by qaea16 with SMTP id a16so161367qae.17
	for <alsa-devel@alsa-project.org>; Thu, 29 Mar 2012 00:24:48 -0700 (PDT)
In-Reply-To: <4F74073E.5090300@ladisch.de>
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

Thanks Clemens, no problem .

But not affect this warning? It can affect how can to fix it? And you
know how I can get the volume that enters the microphone at the time?



2012/3/29 Clemens Ladisch <clemens@ladisch.de>:
> D=E1maso L=F3pez wrote:
>> HI? Any answer? please, I'm in a loop and not to exit
>
> We apologize again for the delay. =A0Those responsible for sacking the
> people who have just been sacked have been sacked.
>
>>> I've some problem referents with alsa and get volume from mircophone:
>>>
>>> 1.- When to compile the file ,returned these lines.Could be problem to =
keep?
>>>
>>> warning: Using 'dlopen' in statically linked applications requires at r=
untime the shared
>>> libraries from the glibc version used for linking
>
> This message means exactly what it says.
>
>>> 2.- The previous to say, despite being a warning can create executable
>>> file. But when return:
>>>
>>> ALSA lib conf.c:3009:(snd_config_update_r) Cannot access file /usr/shar=
e/alsa/alsa.conf
>>> ALSA lib control.c:909:(snd_ctl_open_noupdate) Invalid CTL default
>>>
>>> I'm sorpress because not exist this file
>
> So you didn't copy this directory to the target system?
> (With the earlier install command, it would be at /tmp/blah/usr/share/als=
a.)
>
> Please note that _all_ files installed by 'make install' are needed for
> either compiling/linking or at runtime.
>
>
> Regards,
> Clemens
