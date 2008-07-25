From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: alsa-lib has anyone ever looked at taking it cross
	platform?
Date: Fri, 25 Jul 2008 13:49:20 +0100
Message-ID: <g6ci4g$3jb$1@ger.gmane.org>
References: <e7d8f83e0807250351j42894f2dm7f19483f8d66afaa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id CF0D6245C5
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Jul 2008 14:49:33 +0200 (CEST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KMMjh-0007vS-GT
	for alsa-devel@alsa-project.org; Fri, 25 Jul 2008 12:49:29 +0000
Received: from 78-86-109-144.zone2.bethere.co.uk ([78.86.109.144])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 25 Jul 2008 12:49:29 +0000
Received: from gmane by 78-86-109-144.zone2.bethere.co.uk with local (Gmexim
	0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 25 Jul 2008 12:49:29 +0000
In-Reply-To: <e7d8f83e0807250351j42894f2dm7f19483f8d66afaa@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Peter Dolding wrote:
> Pulseaudio and all other Sound Servers since its a extra service adds
> a extra point of complete sound failure to the Linux sound stack or
> what ever stack they happen to be operating on top of.   It more of a
> hack around the limitations of the alsa framework.  ALSA was really
> designed to avoid the need of such extras.  The existence of
> Pulseaudio is really sign of failure.  Reason Sound Servers existed at
> first due to the failures of OSS to provide a multi application sound
> support.  ALSA was really designed to do away for the need of sound
> servers completely.  Now alsa is failing to provide per application
> sound control and a sound server is back for another pass.

I really don't see why the existence of sound servers is a failure of 
ALSA. ALSA does it's job very well by providing the necessary hardware 
drivers and an interface to them. The kind of things needed by a modern 
desktop sound system, however, goes way beyond the 1:1 hardware interface.

At the most basic level, sound servers can be reduced to just software 
mixers. The name "sound server" has a very bad reputation that (these 
days) is not deserved. To say that pulseaudio's existence is a failure 
of ALSA is doing ALSA a massive disservice. Sure, the software mixing 
can be done by Alsa's DMIX but DMIX is just a "sound server" anyway, so 
what specifically makes DMIX better or worse than PA in this regard? 
Because DMIX is started automatically? Because it's in kernel space? 
None of these arguments hold up when you get involved at the level of a 
distribution who packages things together correctly.


Pulseaudio is just a name and the kind of things it does are very much 
different to the core goals of ALSA (with the exception of the obvious 
overlap between DMIX and PA). The two fit very well together IMO.

If it makes you feel any better, just call pulseaudio "ALSA Desktop 
Services". Like I say it's only a name!


> Now if you want to keep on thinking along that line has ALSA got to
> the point it should be dumped like OSS has been dumped because of its
> limitations?

Of course ALSA should not be dumped! ALSA does it's job very well, and 
PA does it's very well too. I really don't see how you got to that 
statement from what I said. PA doesn't try and reimplement ALSA, it just 
implements the higher level audio stack.

> alsa-lib to freebsd or somewhere with oss most likely could be done
> really quickly since we already have a oss output option.
> 
> Its also like saying the Linux Standard Base is only used by Linux.
> Its not its also used by a few non Linux's.   Driver section of ALSA
> most likely will always be Linux only.   But the wrapper layer that
> hides the hardware from the software really does not have to stay
> Linux only.  Alsa is going up to be part of the Linux Standard Base
> its about time we all start looking at how it can be made most useful.
>  Provide all the features it should and work for stability.

I've not programmed much with alsa lib but I do know it's not all that 
simple. That's there are several other layers on top that exist. There 
API is complex and powerful but it also open to a lot of abuse. There 
are many ALSA client apps out there that are poorly written. That's 
simply because the API is complex and it is easy to make mistakes that 
do not surface with one setup but do on another. Making apps work nicely 
with DMIX was a pain and as soon as you remove the hardware aspect of 
the underlying system (e.g. to replace it with a plugin like bluez or 
PA) lots of interesting issues come to the fore.


IMO Pulseaudio is the future of the high level audio stack on linux and 
alsa is and will remain to be the future of the driver/low level part of 
that stack. The callback architecture is more suited to modern practices 
which is also adopted in CoreAudio and even on Windows these days. Over 
(a very long period of) time I think we'll see less and less direct 
impelmentations on top of alsa-lib and more on top of PA. That's my 
prediction anyway (and I'm talking about general purpose desktop stuff 
here; specialist sound stuff like Jack will probably still interface 
directly with ALSA).

While porting alsa-lib to other platforms is fine, I don't think it's 
the ideal future scenario.

And to be even clearer than I have been (if possible) I'm not 
badmouthing or insulting ALSA in any way here. I need it and use it and 
rely on it and I don't see that changing!

Just my thoughts.

Col.
