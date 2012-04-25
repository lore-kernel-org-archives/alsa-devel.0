From: Guillaume Clement <gclement@baobob.org>
Subject: Re: [snd-usb-audio] frequent "delay: estimated xxx,
	actual yyy" messages
Date: Wed, 25 Apr 2012 20:06:57 +0200
Message-ID: <1376468.6QcoDNaDHT@siegfried>
References: <3172169.OcqrdKakkS@siegfried> <1383683.z6YHnxXImd@siegfried>
	<4F96B1B3.1060606@ladisch.de>
Reply-To: Guillaume Clement <gclement@baobob.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net
	[217.70.183.195])
	by alsa0.perex.cz (Postfix) with ESMTP id 1FF5A104A13
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Apr 2012 20:07:05 +0200 (CEST)
In-Reply-To: <4F96B1B3.1060606@ladisch.de>
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

Le mardi 24 avril 2012 15:59:15 vous avez =E9crit :
> Guillaume Clement wrote:
> > Could the delay not be the cause, but a side effect ?
> =

> Yes, that's probable.  It might be possible that some interrupt got
> delayed too much, or that packets were completed in wrong order.

I've noticed that using the touchpad triggers the issues, even in console m=
ode =

when I don't start X. Some other factors seem to trigger it, like some =

graphical operations or hard disk usage (but again, only when the CPU is lo=
w =

usage).

I forgot to mention that my integrated soundcard does not have this issue. =
I =

deactivated the integrated soundcard  in the BIOS and that didn't help.

> =

> > Do you have any idea why keeping my CPU busy removes the problem ?
> =

> I'd guess that an idle CPU needs a longer time to wake up.
> What CPU and what CPU frequency governor are you using?


On my laptop, I've got an Atom Z520 @ 1.33GHz. I was using the ondemand =

governor. I switched to performance, with no effect.

I tried to disable as many modules as possible (even my graphics card, wifi=
, =

touchscreen) with no luck so far.

I tried again on several of my other computers and I could not reproduce th=
e =

problem, even on another netbook. It's quite weird becaues I thought I =

reproduced it with several hardware back in December, but I guess I was =

mistaken, sorry about that. =
