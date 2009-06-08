From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] ASoC: pxa-ssp: enhance I2S and
	add	Left_J support
Date: Mon, 8 Jun 2009 16:06:46 +0100
Message-ID: <20090608150646.GB6413@rakim.wolfsonmicro.main>
References: <f17812d70906030533m49eb023bid19a80231921f59b@mail.gmail.com>
	<20090606201225.GA1029@sirena.org.uk>
	<74d0deb30906080512q29b9915fvec9b068bf4b2e126@mail.gmail.com>
	<f17812d70906080713i76073b32vd9cc2e9a7f2334@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E184A24482
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Jun 2009 17:06:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <f17812d70906080713i76073b32vd9cc2e9a7f2334@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: alsa-devel@alsa-project.org, Daniel Ribeiro <drwyrm@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, pHilipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 08, 2009 at 10:13:25PM +0800, Eric Miao wrote:
> On Mon, Jun 8, 2009 at 8:12 PM, pHilipp Zabel<philipp.zabel@gmail.com> wr=
ote:

> > Agreed. Also, if I had to use this to configure magician with DSP_A
> > (right now it says I2S and LEFT_J only, but why limit it to that?),
> > I'd need an additional PXA_SSP_FRM_16FS.

> That shouldn't be a problem - it can just be added.

That won't scale in a bitmask - as you get more and more slots in use on
a TDM system more and more slots are going to need to extend the range
of values you can set in a bitmask.  Consider what happens when people
start hanging 5.1 CODECs off TDM buses with single data lines, for
example.

> >> sample width parameter to set_tdm_slot() - given the very small number
> >> of in tree users it'd cause little disruption. =A0A set_sample_width()
> >> operation could also be added.

> Well, the real problem is that it's quite difficult to abstract all
> the different formats into a single structure. I'd prefer to have
> something specific at the begining.

I don't see much difference between any of the proposals here (or any
problem with format-specificness) - my main thing here is to pull the
frame width configuration out of the DAI format.

> > set_sample_width or set_frame_width?
> > I'd prefer a separate operation over a parameter to set_tdm_slot because
> > in my setup I just need to force the (SSP) frame width to 16 bits.
> > Enabling network mode and calling set_tdm_slot(..,1,1) wouldn't be
> > necessary at all, then.

> As said, if we can invent something like a single structure
> making all formats happy, it will be good. However, before
> that's possible, I'd really prefer less API for the formats being
> further introduced, so we go no further from that goal.

Well, if we want to avoid introducing a new API at all then the PXA SSP
driver is going to need to figure out the bit clock rate automatically
from the TDM and sample size configuration - if it needs to be
explicitly specified then it's a new API and once we introduce one way
of doing this it'll probably stick.

TDM really needs some sort of frame/sample width configuration to work
well so I think we're better off adding a standard API now.
