From: =?ISO-8859-1?B?ROFtYXNvIEzzcGV6?= <dlopezsk@gmail.com>
Subject: Re: How to cross compile the alsa ?
Date: Mon, 26 Mar 2012 18:00:12 +0200
Message-ID: <CAC-Zu+4=vMo=+V+sBwm2prUNk2rWtrNQGWYiqZ99O3DDhyJRjg@mail.gmail.com>
References: <CAC-Zu+6S4WNnqBf1fjbHAQnXwSOEOPQ4UQGBmd15jsZCvL_UHA@mail.gmail.com>
	<4F708A5C.3060406@ladisch.de>
	<CAC-Zu+4RUevh0biAWOJu6niCLpHdtzW-esY3B+X7vxi193AujQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f51.google.com (mail-qa0-f51.google.com
	[209.85.216.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 790031040AA
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Mar 2012 17:58:45 +0200 (CEST)
Received: by qaea16 with SMTP id a16so2430182qae.17
	for <alsa-devel@alsa-project.org>; Mon, 26 Mar 2012 09:00:18 -0700 (PDT)
In-Reply-To: <CAC-Zu+4RUevh0biAWOJu6niCLpHdtzW-esY3B+X7vxi193AujQ@mail.gmail.com>
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

Sorry Clemens, I didn't see correctly you answer last post, but I
can't across compile :(

2012/3/26 D=E1maso L=F3pez <dlopezsk@gmail.com>:
> Hi Clemens,
>
> Thanks for you response, but I don't find /root/of/target, where's
> this route? I've installed a Fedora on Virtual Machine and host is a
> Windows XP
>
> Another question is:
>
> Have I do this line "make install DESTDIR=3D..." on directory
> /home/dam/lsa-lib-1.0.17 ?
>
> Best Regards,
>
> Dam
>
> 2012/3/26 Clemens Ladisch <clemens@ladisch.de>:
>> D=E1maso L=F3pez wrote:
>>> # CC=3Darm-gp2x-linux ./configure --host=3Di686.linux --target=3Darm-li=
nux
>>> #make
>>> #make install
>>
>> When cross-compiling, you cannot simply install on your host system.
>> Use
>> =A0 =A0 =A0 =A0make install DESTDIR=3D/root/of/target/machine's/filesyst=
em
>>
>>> When it finish I copy all include from alsa-lib-1.0.17 in my directory
>>> /usr/arm-gp2x-linux/include.
>>>
>>> After I did:
>>>
>>> #arm-gp2x-linux -o micro micro.c -lasound
>>>
>>> But it say that can't find -lasound
>>
>> The library is not an include file.
>>
>>
>> Regards,
>> Clemens
