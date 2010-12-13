From: Amit Nagal <helloin.amit@gmail.com>
Subject: Re: regarding setting of fragment size in usbaudio
	driver
Date: Mon, 13 Dec 2010 23:11:55 +0900
Message-ID: <AANLkTi=XTZGC08sq4XfjgEgBH7Aamct75D-XE0wQjciH@mail.gmail.com>
References: <AANLkTimCg0kxCU1By9eg0Qba5hKMseS5rAZXsE_a4hOF@mail.gmail.com>
	<4D05E19D.7010405@ladisch.de>
	<AANLkTi=S732=Wj572Th860PpBYE0fkJ97JH2CwitZ4ah@mail.gmail.com>
	<4D0621D0.1040403@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qw0-f51.google.com (mail-qw0-f51.google.com
	[209.85.216.51]) by alsa0.perex.cz (Postfix) with ESMTP id 03E6B245FD
	for <alsa-devel@alsa-project.org>; Mon, 13 Dec 2010 15:11:58 +0100 (CET)
Received: by qwj8 with SMTP id 8so6370169qwj.38
	for <alsa-devel@alsa-project.org>; Mon, 13 Dec 2010 06:11:55 -0800 (PST)
In-Reply-To: <4D0621D0.1040403@ladisch.de>
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
Cc: alsa-user@lists.sourceforge.net, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> (please don't top-post)
>
Extremely sorry for that .  will take care reagarding this from now on .

> If, when read() is called, there is enough data in the buffer, it will
> return that data and return immediately. =A0Otherwise, it will wait for
> the hardware to reach the next period boundary (in OSS: fragment
> boundary) and try again.
>
> If you want to have shorter waits, use lower fragment sizes.

yes ,  setting of lower fragment size is my requirement at the moment
in OSS application .
i tried to use SNDCTL_DSP_SETFRAGMENT ioctl to set lower fragment size .
but audio driver uses default fragment size only and not the fragment
size desired by application .
Is it  possible to change fragment size in kernel space ?

Thanx & Regards
Amit Nagal
