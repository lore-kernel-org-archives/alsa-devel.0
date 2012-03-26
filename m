From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: How to cross compile the alsa ?
Date: Mon, 26 Mar 2012 22:15:06 +0200
Message-ID: <4F70CE4A.2020001@ladisch.de>
References: <CAC-Zu+6S4WNnqBf1fjbHAQnXwSOEOPQ4UQGBmd15jsZCvL_UHA@mail.gmail.com>	<4F708A5C.3060406@ladisch.de>
	<CAC-Zu+4RUevh0biAWOJu6niCLpHdtzW-esY3B+X7vxi193AujQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 2F5B624AC5
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Mar 2012 22:13:37 +0200 (CEST)
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 6D7B121228
	for <alsa-devel@alsa-project.org>; Mon, 26 Mar 2012 16:15:11 -0400 (EDT)
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
To: =?ISO-8859-1?Q?D=E1maso_L=F3pez?= <dlopezsk@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

D=E1maso L=F3pez wrote:
> Thanks for you response, but I don't find /root/of/target, where's
> this route? I've installed a Fedora on Virtual Machine and host is a
> Windows XP
>
> Another question is:
>
> Have I do this line "make install DESTDIR=3D..." on directory
> /home/dam/lsa-lib-1.0.17 ?

Run
	make install DESTDIR=3D/tmp/blah
then look in there to find out which files you need.


Regards,
Clemens
