From: Maarten de Boer <maarten@resorama.com>
Subject: Re: bug
Date: Tue, 31 Mar 2015 12:26:04 +0200
Message-ID: <D1185AE0-6829-4E51-AD60-EED3D63B677F@resorama.com>
References: <1427551386.3092172.246393281.691C33A7@webmail.messagingengine.com>
 <5518F8F3.10304@ladisch.de>
 <1427711234.231499.246955417.6E2E7C65@webmail.messagingengine.com>
 <55192FBC.1070307@ladisch.de>
 <1427726222.1872206.247049189.3E3BB0F7@webmail.messagingengine.com>
 <alpine.DEB.2.02.1503311008160.13892@lnxricardw1.se.axis.com>
 <1427792161.2150884.247436393.3D8D2571@webmail.messagingengine.com>
 <alpine.DEB.2.02.1503311111460.13892@lnxricardw1.se.axis.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net
 [217.70.183.197])
 by alsa0.perex.cz (Postfix) with ESMTP id C95782614F4
 for <alsa-devel@alsa-project.org>; Tue, 31 Mar 2015 12:26:12 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.02.1503311111460.13892@lnxricardw1.se.axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Nikita N." <nikitan@operamail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello,

I am the author of alsamixergui. I am not actively maintaining alsamixergui=
 anymore (and haven=92t been for years). It is pretty much coincidence that=
 I saw this mail thread; a slightly more informative subject would have hel=
ped.

There is not much that I can add to this thread (thanks everyone for your r=
eplies), but in short:

- alsamixergui is just a graphical frontend, and exposes the mixer capabili=
ties of the sound card in the same way alsamixer, amixer or any other alsa =
mixer does, so this is not alsamixergui specific. (strongly based on the al=
samixer code (verbatim) with fltk gui code added to it.).

- this is not a software problem, this is a hardware problem. The user adju=
sts the mixer to cause a feedback between speaker and internal microphone, =
and leaves this running for >30 seconds, and his hardware can=92t deal with=
 it. It is probably not even operating system specific.

Finally, I really don=92t like the tone you use, Nikita, particularly your =
talk of =93exposing the individuals guilty=94 and your accusations of secre=
cy. And "expose clearly to the public that tool as a virus/malware, and inf=
orm the antivirus authorities about it.=94, really? Good luck with that.

If you want to blacklist alsamixergui from your distro, please go ahead, bu=
t don=92t forget to blacklist alsamixer and amixer too, as well as any othe=
r alsa mixer front ends.

Maarten


On 31 Mar 2015, at 11:14, Ricard Wanderlof <ricard.wanderlof@axis.com> wrot=
e:

> =

> On Tue, 31 Mar 2015, Nikita N. wrote:
> =

>>> alsamixergui is not created by the ALSA =

>>> project, so this mailing list is the wrong place to look if none other =

>>> than for that particular reason.
>> Sure, we would be very grateful if you could point that out, so we can
>> contact the individual who programmed this tool
>> Unless it's not a secret or there is smtng to hide.
> =

> I have no idea who wrote it, Clemens posted a link but at to me it seems =

> dead, there should be something in the source code (perhaps that's where =

> he got it frome?). Could very well be that it was written by someone who =

> has since moved on to other things so that any links or email adresses ar=
e =

> outdated. It's not necessarily a secret, it could just be unknown at this =

> point, and if the person who wrote it is not actively maintaining it any =

> more there's probably little to be gained from contacting him.
> =

> /Ricard
> -- =

> Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
> Axis Communications AB, Lund, Sweden            www.axis.com
> Phone +46 46 272 2016                           Fax +46 46 13 61 30
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
