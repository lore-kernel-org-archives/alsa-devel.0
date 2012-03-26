From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: How to cross compile the alsa ?
Date: Mon, 26 Mar 2012 17:25:16 +0200
Message-ID: <4F708A5C.3060406@ladisch.de>
References: <CAC-Zu+6S4WNnqBf1fjbHAQnXwSOEOPQ4UQGBmd15jsZCvL_UHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 6735924A72
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Mar 2012 17:20:27 +0200 (CEST)
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 1DFAF20A72
	for <alsa-devel@alsa-project.org>; Mon, 26 Mar 2012 11:21:53 -0400 (EDT)
In-Reply-To: <CAC-Zu+6S4WNnqBf1fjbHAQnXwSOEOPQ4UQGBmd15jsZCvL_UHA@mail.gmail.com>
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
> # CC=3Darm-gp2x-linux ./configure --host=3Di686.linux --target=3Darm-linux
> #make
> #make install

When cross-compiling, you cannot simply install on your host system.
Use
	make install DESTDIR=3D/root/of/target/machine's/filesystem

> When it finish I copy all include from alsa-lib-1.0.17 in my directory
> /usr/arm-gp2x-linux/include.
>
> After I did:
>
> #arm-gp2x-linux -o micro micro.c -lasound
>
> But it say that can't find -lasound

The library is not an include file.


Regards,
Clemens
