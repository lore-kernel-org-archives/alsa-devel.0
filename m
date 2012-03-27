From: =?ISO-8859-1?B?ROFtYXNvIEzzcGV6?= <dlopezsk@gmail.com>
Subject: Re: How to cross compile the alsa ?
Date: Tue, 27 Mar 2012 09:39:33 +0200
Message-ID: <CAC-Zu+6Pb9jjT3-9iTwkQtwRpSd+A6-hsdoBTYFB28vATFbsGA@mail.gmail.com>
References: <CAC-Zu+6S4WNnqBf1fjbHAQnXwSOEOPQ4UQGBmd15jsZCvL_UHA@mail.gmail.com>
	<4F708A5C.3060406@ladisch.de>
	<CAC-Zu+4RUevh0biAWOJu6niCLpHdtzW-esY3B+X7vxi193AujQ@mail.gmail.com>
	<4F70CE4A.2020001@ladisch.de>
	<CAC-Zu+5N0cjZiGxsptnD165KJFUW9YOi3YVBKSZStAC4Yphwng@mail.gmail.com>
	<CAC-Zu+6+G=ceyy_r863a_f2e__nroNP=RVHaPvYscgYJyk3-Mg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f44.google.com (mail-qa0-f44.google.com
	[209.85.216.44])
	by alsa0.perex.cz (Postfix) with ESMTP id 38133104171
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Mar 2012 09:37:59 +0200 (CEST)
Received: by qadc14 with SMTP id c14so2900499qad.17
	for <alsa-devel@alsa-project.org>; Tue, 27 Mar 2012 00:39:33 -0700 (PDT)
In-Reply-To: <CAC-Zu+6+G=ceyy_r863a_f2e__nroNP=RVHaPvYscgYJyk3-Mg@mail.gmail.com>
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

Hi again :-P

Ok!! thanks for you, I finish to cross compile xDDDDD, but another
problem I need compile with parameter -static, but when put this line:

#arm-gp2x-linux -static -lasound -o micro micro.c

It returned :

Can't find -lasound
 collect2:ld returned 1 exit status

How cross compile statically alsa, please??, arg it's a handicap it

2012/3/27 D=E1maso L=F3pez <dlopezsk@gmail.com>:
> Hi again Clemens,
>
> I look differents files in tmp/blah ,thanks, I think that alonely copy
> lib/*.*, libasound.la. so ,etc in my directory
> /usr/arm-gp2x-linux/lib/*.*
>
> Is OK? or I copy all files in my directory? ainx :)
>
> 2012/3/27 D=E1maso L=F3pez <dlopezsk@gmail.com>:
>> Hi,
>>
>> But when I run make or make install ,the procedure is nok, it says:
>>
>> pcm/.libs/libpcm.a(atomic.o) couldn't read symbols:File in wrong format
>> collectt2:ld returned 1 exit status
>> make[2]:[libasound.la] error 1
>> to exit of directory /home/dam/alsa-lib.../src
>> make[1]: [all-recursive] error 1
>> to exit of directory /home/dam/alsa-lib.../src
>> make [all-recursive] error 1
>>
>> Are there modify any file to configure?? because of be able to motive
>> there are create nothing =A0and it's bad
>>
>> 2012/3/26 Clemens Ladisch <clemens@ladisch.de>:
>>> D=E1maso L=F3pez wrote:
>>>> Thanks for you response, but I don't find /root/of/target, where's
>>>> this route? I've installed a Fedora on Virtual Machine and host is a
>>>> Windows XP
>>>>
>>>> Another question is:
>>>>
>>>> Have I do this line "make install DESTDIR=3D..." on directory
>>>> /home/dam/lsa-lib-1.0.17 ?
>>>
>>> Run
>>> =A0 =A0 =A0 =A0make install DESTDIR=3D/tmp/blah
>>> then look in there to find out which files you need.
>>>
>>>
>>> Regards,
>>> Clemens
