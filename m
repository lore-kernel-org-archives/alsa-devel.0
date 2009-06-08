From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] ASoC: pxa-ssp: enhance I2S and
	add	Left_J support
Date: Mon, 8 Jun 2009 19:06:56 +0100
Message-ID: <20090608180656.GH7858@sirena.org.uk>
References: <f17812d70906030533m49eb023bid19a80231921f59b@mail.gmail.com>
	<20090606201225.GA1029@sirena.org.uk>
	<74d0deb30906080512q29b9915fvec9b068bf4b2e126@mail.gmail.com>
	<20090608124045.GE7858@sirena.org.uk>
	<1244477000.30582.72.camel@brutus>
	<20090608165328.GB14026@rakim.wolfsonmicro.main>
	<1244481992.17327.22.camel@brutus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 4DC6824538
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Jun 2009 20:06:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1244481992.17327.22.camel@brutus>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Ribeiro <drwyrm@gmail.com>
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, pHilipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 08, 2009 at 02:26:32PM -0300, Daniel Ribeiro wrote:
> Em Seg, 2009-06-08 ??s 17:53 +0100, Mark Brown escreveu:

> > See my reply to Philip - even with frame size his case is going to be
> > very hard to cover in a standard fashion since it's not clear what to do

> I don't see why. If we provide an API to setup the frame size this is
> all magician needs.

That depends on what you do with the excess data in a frame - what
magician needs to do is to set the frame clock up to run at double rate
compared to standard one.  Doing this by specifying the frame size means
ignoring the rate of the incoming data rather than paying attention to
the rate the data is supposed to have and therefore skipping the second
channel but either of those two options would be a reasonable response.

> If we assume that the standard is frame_size = sample_size * channels,
> then there is no need for a frame size API at all. But then magician
> case will not be supported correctly.

Think about TDM mode for a minute here - there a separate configuration
for the sample size on the wire opens the way to using a lower sample
size in a given timeslot than the timeslot supports, reducing the need
for the CPU to rewrite data.  Or to put it another way, I can't see TDM
mode working unless the sample size is constrained to always be exactly
that desired so it seems sensible to have a standard way of doing that.

> > Network mode is just a detail of the implementation of the PXA here - it
> > should not be visible outside the pxa-ssp driver.  Or to put it another
> > way setting a tdm_slot of 1, 1 ought to result in the same behaviour as
> > disabling TDM as far as the user is concerned.

> But for pxa-ssp this is not the current behaviour.

I think we can all agree that the current behaviour is fairly broken,
it's kind of orphaned at the minute since nothing is using it.

> > I'd like to see all these details handled within the driver - knowing if
> > and when network mode are to be set up is the sort of thing that users
> > ought to be able to rely on the driver for.

> I can cook a patch.. All I need to know is:

> Does it needs to support magician non-standard format? Or this will be
> handled by userspace?

I'd rather come up with a cleaner way of configuring the magician case
that's explicit about what it's trying to achieve.  It doesn't need to
be in user space, though.
