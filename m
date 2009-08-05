From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: MPC5200/WM9712 mute problem
Date: Wed, 5 Aug 2009 18:03:06 +0100
Message-ID: <20090805170305.GC16844@sirena.org.uk>
References: <20090731230311.17686.46431.stgit@riker>
	<9e4733910908010647k3a4a22c5jf9b9eda482f016b1@mail.gmail.com>
	<1249139096.4582.13.camel@riker>
	<20090802114950.GA1778@sirena.org.uk>
	<1249489853.4582.58.camel@riker>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 77273244F4
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Aug 2009 19:03:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1249489853.4582.58.camel@riker>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: John Bonesio <bones@secretlab.ca>
Cc: Grant Likely <grant.likely@secretlab.ca>, alsa-devel@alsa-project.org, Eric Millbrandt <emillbrandt@dekaresearch.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 05, 2009 at 09:30:53AM -0700, John Bonesio wrote:

> I've retitled the email to better reflect the real patch. I believe
> there has been some general confusion because I originally sent the
> wrong patch.

Retitling again; I don't think we've diagnosed what is causing issues
here.  Doing a quick test here I wasn't able to reproduce this behaviour
so I suspect either the AC97 controller by itself or some interaction
between it and the WM9712.  Like I say, the WM9712 is not a new part and
the drivers aren't new either so it'd be surprising to find an issue
like this now.

> > Like I said before, exactly which control are you adjusting here?

> My description of this got lost in all the confusion. Let me try again.
> We are adjusting the mixer bits for mute/unmute on two of the mixer
> settings. The first one is general headphone mute setting on register
> 0x4 (bit 15). The second one is the PCM mute setting on register 0x18
> (bit 15).

Hrm, so the same bit in both registers.  Suspicious...

> What we are seeing is that if we first unmute the general headphone (reg
> 0x4 bit15), then unmute the PCM (reg 0x18 bit 15) [HPL PCM in the
> alsamixer application], the general headphone gets muted again, even
> though software didn't write to that register.

Are any other bits in register 4 affected or is it only bit 15?

> > My money would be on the AC97 controller having problems; the quality of
> > SoC AC97 controllers is variable.  It certainly doesn't sound like a
> > WM9712 issue; as I say I'd be very surprised if such an issue hadn't
> > come up before given how widely deployed the part is.

> We don't have access to an AC97 analyzer. Do you have any suggestions on
> other ways we can pinpoint the error?

Any scope that can capture would be useful to see what's going on;
obviously decode would have to be by hand.  Coding out the register
cache may also be useful - it'd allow you to see the current hardware
register values.
