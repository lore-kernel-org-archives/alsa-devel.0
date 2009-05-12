From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 2/4] pxa2xx-i2s: Handle SACR1_DRPL
	and	SACR1_DREC separately
Date: Tue, 12 May 2009 15:34:13 +0100
Message-ID: <20090512143412.GI29889@sirena.org.uk>
References: <4A03748B.1010302@gmail.com> <20090508104229.GD5654@sirena.org.uk>
	<20090511190504.GF20283@sirena.org.uk> <4A087FCF.2080304@gmail.com>
	<20090511210729.GA4404@sirena.org.uk> <4A08A001.4050003@gmail.com>
	<20090512085838.GB29889@sirena.org.uk> <4A094867.2010600@gmail.com>
	<20090512103243.GH29889@sirena.org.uk> <4A096DBB.1080909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id E507C103849
	for <alsa-devel@alsa-project.org>;
	Tue, 12 May 2009 16:34:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4A096DBB.1080909@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Karl Beldan <karl.beldan@gmail.com>
Cc: alsa-devel@alsa-project.org, Russell King <linux@arm.linux.org.uk>, Matthieu Dumont <matthieu.dumont@mobile-devices.fr>, liam.girdwood@wolfsonmicro.com, Eric Miao <eric.miao@marvell.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, May 12, 2009 at 02:38:19PM +0200, Karl Beldan wrote:
> Mark Brown wrote:

> > Yet they are being stopped by something...

> You said that clocks are NOT stopped when applying patch 2/4 without 1/4.
> I detailed a fairly likely code path.

They're stopped after every other playback; I can't remember at exactly
what point things sorted themselves out but IIRC it was starting the
second playback that stopped them.  I didn't look too closely since the
behaviour was so obviously incorrect.

> > A repost is where you send exactly the same thing again.  When you say

> When I said I 'resent' it, my meaning was not to let you understand that I did not modify it obviously.

Unfortunately that was the effect; it's actually less uncommon than you
might think for people to do just that.

> > There's been enough stuff with the series that I've got a few alarm
> > bells ringing, if only with obscure relationships between the patches.

> I could say the same about the current status and handling but I will
> ask you to point precise points instead, please.

It really is a case of alarm bells ringing - it's not one specific thing
but rather a cluster of things that make me want to review in more
detail, including the fact that I actually have the hardware to hand and
use it fairly often.

> As of the current status of the driver there is not even full duplex,
> maintainance is likewise.

I've used the driver for full duplex in the past; now you've pointed out
these issues I suspect it only ever did so due to some race condition or
other but it has been functional.

> Could you point what is wrong in the code or comments ?
> Nitpicking about "A repost is where you send exactly the same thing again." and talking so much about

It's probably as well to just wait for me to review the current set of
patches - I suspect the changes are good, I just need to check them in
more detail to make sure that I understand what they do.

The main thing you could do in future is write changelogs that more
fully explain what your patches are doing - make sure all the bases are
covered and the motivation is explained.  For example, the description
of patch 3 talked only about stream startup so the changes to suspend
and resume were surprising.  Similarly, with patch 1 the fact that it
isn't just cleaning up after other software and restoring the hardware
to a known good state would've been useful to point out (remember that
the reset values aren't visible in the code).

> pb applying 2/4 without 1/4 really sucks.

At the time I tested with the second patch you hadn't provided a fixed
version of patch 1.  I generally try to apply as much as possible since
this cuts down on the amount of effort required when the needed fixes
are done.

> Since I have no feedback from Maintainers, I am pinging the original
> author hoping I won't disturb too much.

The maintainer here is in effect a combination of me and Eric Maio, me
as a result of it being part of ASoC so falling to me by default and
Eric due to it being PXA hardware.  I'd certainly not expect anyone else
to review them as a matter of course.

BTW, please fix your MUA to wrap at 80 characters or so - it makes
things easier to read.
