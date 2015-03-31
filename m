From: Maarten de Boer <maarten@resorama.com>
Subject: Re: bug
Date: Tue, 31 Mar 2015 13:05:53 +0200
Message-ID: <677D3730-B814-4E64-8746-12FE30C13C23@resorama.com>
References: <1427551386.3092172.246393281.691C33A7@webmail.messagingengine.com>
 <5518F8F3.10304@ladisch.de>
 <1427711234.231499.246955417.6E2E7C65@webmail.messagingengine.com>
 <55192FBC.1070307@ladisch.de>
 <1427726222.1872206.247049189.3E3BB0F7@webmail.messagingengine.com>
 <alpine.DEB.2.02.1503311008160.13892@lnxricardw1.se.axis.com>
 <1427792161.2150884.247436393.3D8D2571@webmail.messagingengine.com>
 <alpine.DEB.2.02.1503311111460.13892@lnxricardw1.se.axis.com>
 <D1185AE0-6829-4E51-AD60-EED3D63B677F@resorama.com>
 <1427798995.588863.247475933.12C0B9B0@webmail.messagingengine.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net
 [217.70.183.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 58B532617A4
 for <alsa-devel@alsa-project.org>; Tue, 31 Mar 2015 13:06:02 +0200 (CEST)
In-Reply-To: <1427798995.588863.247475933.12C0B9B0@webmail.messagingengine.com>
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

Hi,

As I tried to explain, this is not specific for alsamixergui, and it is not=
 a bug, as it is a hardware problem. There is no way for the software to kn=
ow what would be these =93hazardous=94 levels, as this is hardware specific=
. And again, alsamixergui is just a graphical frontend. The command line al=
samixer does the same thing.

Maarten

On 31 Mar 2015, at 12:49, Nikita N. <nikitan@operamail.com> wrote:

> Dear Maarten de Boer,
> as you read from many voices here, your software is verified can damage
> the speakers, if not used somehow correctly.
> The definition of correctly is still to us unknown, nor you are giving
> us any hope in that.
> We were hoping in some form of amend from yourself, about the dangerous
> software you produced and distributed to public.
> We were hoping in some form of bug fix or any professional approach to
> solving that issue.
> We were hoping at least in a simple warning popping up from your tool,
> when user sets any "hazardous" levels.
> We were hoping at least-least in a warning popping up from your tool at
> runtime, something like "Warning: improper settings for this level, this
> level and this might result in damages to your audio devices".
> But, we only see a nice turnaround "There is not much that I can add".
> Your program does not respect the minimum requirement for a software to
> be published, such as being "reasonably" bug free.
> As for "bug" is intended a software which is limited in creating
> software problems.
> While instead, your tool expands to a whole new, and more dangerous
> level - hardware damage.
> Hence your software, as is, doesn't respect our Debian/Ubuntu
> philosophy.
> So, at this point "There is not much that" we can add.
> We also wish you "Good luck with that."
> =

> On Tue, Mar 31, 2015, at 03:26 AM, Maarten de Boer wrote:
>> Hello,
>> =

>> I am the author of alsamixergui. I am not actively maintaining
>> alsamixergui anymore (and haven=92t been for years). It is pretty much
>> coincidence that I saw this mail thread; a slightly more informative
>> subject would have helped.
>> =

>> There is not much that I can add to this thread (thanks everyone for your
>> replies), but in short:
>> =

>> - alsamixergui is just a graphical frontend, and exposes the mixer
>> capabilities of the sound card in the same way alsamixer, amixer or any
>> other alsa mixer does, so this is not alsamixergui specific. (strongly
>> based on the alsamixer code (verbatim) with fltk gui code added to it.).
>> =

>> - this is not a software problem, this is a hardware problem. The user
>> adjusts the mixer to cause a feedback between speaker and internal
>> microphone, and leaves this running for >30 seconds, and his hardware
>> can=92t deal with it. It is probably not even operating system specific.
>> =

>> Finally, I really don=92t like the tone you use, Nikita, particularly yo=
ur
>> talk of =93exposing the individuals guilty=94 and your accusations of
>> secrecy. And "expose clearly to the public that tool as a virus/malware,
>> and inform the antivirus authorities about it.=94, really? Good luck with
>> that.
>> =

>> If you want to blacklist alsamixergui from your distro, please go ahead,
>> but don=92t forget to blacklist alsamixer and amixer too, as well as any
>> other alsa mixer front ends.
>> =

>> Maarten
>> =

>> =

>> On 31 Mar 2015, at 11:14, Ricard Wanderlof <ricard.wanderlof@axis.com>
>> wrote:
>> =

>>> =

>>> On Tue, 31 Mar 2015, Nikita N. wrote:
>>> =

>>>>> alsamixergui is not created by the ALSA =

>>>>> project, so this mailing list is the wrong place to look if none othe=
r =

>>>>> than for that particular reason.
>>>> Sure, we would be very grateful if you could point that out, so we can
>>>> contact the individual who programmed this tool
>>>> Unless it's not a secret or there is smtng to hide.
>>> =

>>> I have no idea who wrote it, Clemens posted a link but at to me it seem=
s =

>>> dead, there should be something in the source code (perhaps that's wher=
e =

>>> he got it frome?). Could very well be that it was written by someone wh=
o =

>>> has since moved on to other things so that any links or email adresses =
are =

>>> outdated. It's not necessarily a secret, it could just be unknown at th=
is =

>>> point, and if the person who wrote it is not actively maintaining it an=
y =

>>> more there's probably little to be gained from contacting him.
>>> =

>>> /Ricard
>>> -- =

>>> Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
>>> Axis Communications AB, Lund, Sweden            www.axis.com
>>> Phone +46 46 272 2016                           Fax +46 46 13 61 30
>>> _______________________________________________
>>> Alsa-devel mailing list
>>> Alsa-devel@alsa-project.org
>>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>> =

> =

> -- =

> http://www.fastmail.com - Access all of your messages and folders
>                          wherever you are
> =
