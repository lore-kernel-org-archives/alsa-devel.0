From: Davyd McColl <davydm@gmail.com>
Subject: Re: Headphone jack and auto-mute of speak output
Date: Thu, 7 Oct 2010 16:01:42 +0200
Message-ID: <AANLkTi=8D8-bQa8963nzZ7cBGikhEsfd3ej3U4uO2pTH@mail.gmail.com>
References: <AANLkTi=ZhMVY1abcpxviy50yfSbdc1vABCtKa9jJXfig@mail.gmail.com>
	<AANLkTim-R=FGHo-CxT=gxysisTRT3T35pyrfu7HscKAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f172.google.com (mail-qy0-f172.google.com
	[209.85.216.172])
	by alsa0.perex.cz (Postfix) with ESMTP id 7D7B7103843
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Oct 2010 16:02:03 +0200 (CEST)
Received: by qyk1 with SMTP id 1so173786qyk.17
	for <alsa-devel@alsa-project.org>; Thu, 07 Oct 2010 07:02:02 -0700 (PDT)
In-Reply-To: <AANLkTim-R=FGHo-CxT=gxysisTRT3T35pyrfu7HscKAQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Ehm...

I don't understand. Are you saying that my laptop is "doing the wrong thing"
and should be playing out through the built-in speakers as well as
headphones when jacked in?

Also, the issue here isn't that I (or other, run-of-the-mill users) *want*
both outputs to play. I'm asking for the more common behaviour where the
speaker output was muted when headphones were plugged in.

If you're answering my question, I just don't understand you ): Please
explain again?

-d


On 7 October 2010 15:43, Raymond Yau <superquad.vortex2@gmail.com> wrote:

> 2010/10/7 Davyd McColl <davydm@gmail.com>
>
> > Good day
> >
> > I'm new to this list (though I've done some searching, I'm sure I could
> > have
> > missed something), so please bear with me.
> >
> > I filed a bug report recently against Ubuntu with respect to the problem
> > I'm
> > experiencing (as per the subject: jacking in my headphones doesn't mute
> the
> > speaker output) and was informed that the decision had been made upstream
> > as
> > a design intention. I was linked off to:
> >
> >
> http://mailman.alsa-project.org/pipermail/alsa-devel/2010-August/030071.html
> > with respect to the thread on this topic. I'd like to raise it again
> > though,
> > perhaps as a configurable feature, for the following reasons:
> >
>
> Enable auto-muting in model=auto only for devices with HP and speakers.
>
>
> http://git.alsa-project.org/?p=alsa-kernel.git;a=commitdiff;h=2a2ed0dfc9ec44a899c7d4672f73f2c045099118;hp=299f293b3428ae6d73406642cd7d41f08d524c83
>
>
> if the bios set your laptop 's speaker as line out , you need to implement
> a
> new model for your laptop ,
>
> model=auto assume the bios had already correctly setup all the pin complex
> of your computer
>
>
>
> >
> > 1) headphones muting the speakers used to work some time ago (before
> Ubuntu
> > 9.04, iirc), so we have an established user expectation even under Linux
> > distros.
> > 2) headphones mute the built-in speakers of my laptop (windows and
> ubuntu)
> > -- why the inconsistent behaviour for a desktop? Just because the
> speakers
> > in the laptop are bolted into the frame of the machine?
> > 3) Windows "gets it right": plugging in headphones mutes external
> speakers
> > -- it's convenient (Though I think you can disable that feature if you
> > want). I'm told by a person at work that his Mac does the same. Again,
> the
> > user expectation is unmet under a newish Linux distro.
> > 4) The user expectation theory is held up by the number of bug reports
> > against this design choice on Ubuntu Launchpad alone (I haven't looked at
> > other bug lists). The average user is not expecting the current
> behaviour,
> > obviously
> > 5) For people without hardware volume controls on their speakers, the
> > problem is exacerbated: instead of being able to plug in headphones to
> > disturb others around them less (ie: contain their music/noises), they
> have
> > to unplug their speakers too -- which may not be trivial since speakers
> are
> > normally plugged in at the back of the machine, not at the front where
> the
> > headphone jack would be found. On a machine in an enclosure, this is
> > especially troublesome.
> >
> > So I'd really like to know if it would be possible to allow the behaviour
> > most users are expecting. Sometimes it's useful to be able to output to
> > both
> > speakers and headphones, but I would say that the average user doesn't
> want
> > both at the same time.
> >
> > -d
> >
> >
> > --
> > -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
> > The competent programmer is fully aware of the limited size of his own
> > skull. He therefore approaches his task with full humility, and avoids
> > clever tricks like the plague.
> > - Djikstra.
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> >
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>



-- 
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
The competent programmer is fully aware of the limited size of his own
skull. He therefore approaches his task with full humility, and avoids
clever tricks like the plague.
- Djikstra.
