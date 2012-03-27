From: =?ISO-8859-1?B?ROFtYXNvIEzzcGV6?= <dlopezsk@gmail.com>
Subject: Re: How to cross compile the alsa ?
Date: Tue, 27 Mar 2012 13:20:14 +0200
Message-ID: <CAC-Zu+55ShwctKwN3bH=efTS_kuPTz_mvo2DVqfoXWhCmpmWqQ@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f179.google.com (mail-qc0-f179.google.com
	[209.85.216.179])
	by alsa0.perex.cz (Postfix) with ESMTP id E26DC1041E9
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Mar 2012 13:45:00 +0200 (CEST)
Received: by qcha6 with SMTP id a6so3922273qch.38
	for <alsa-devel@alsa-project.org>; Tue, 27 Mar 2012 04:45:00 -0700 (PDT)
In-Reply-To: <4F719DBF.2060507@ladisch.de>
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

Ok, I've all files, but to be continued fail and I don't know why
can't send new posts in forum alsa-devel

2012/3/27 Clemens Ladisch <clemens@ladisch.de>:
> D=E1maso L=F3pez wrote:
>> Hi?
>
> We apologize for the delay. =A0Those responsible have been sacked.
>
>> You look this file jpeg that I send us
>
> You forgot the wooden table:
> http://thedailywtf.com/Articles/Web_0_0x2e_1.aspx
>
>> #arm-gp2x-linux -static -lasound -o micro micro.c
>
> You have to add all the other libraries that libasound depends
> on, such as libdl and libpthread.
>
>
> Regards,
> Clemens
