From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] ASoC: pxa-ssp: enhance I2S and
	add	Left_J support
Date: Tue, 9 Jun 2009 10:58:21 +0100
Message-ID: <20090609095821.GA28220@sirena.org.uk>
References: <f17812d70906030533m49eb023bid19a80231921f59b@mail.gmail.com>
	<20090606201225.GA1029@sirena.org.uk>
	<74d0deb30906080512q29b9915fvec9b068bf4b2e126@mail.gmail.com>
	<20090608124045.GE7858@sirena.org.uk>
	<1244477000.30582.72.camel@brutus>
	<20090608165328.GB14026@rakim.wolfsonmicro.main>
	<1244481992.17327.22.camel@brutus>
	<20090608180656.GH7858@sirena.org.uk>
	<1244494349.17327.174.camel@brutus>
	<f17812d70906090239p5dee129egda49918b3862c0ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id E4E4E1037FC
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Jun 2009 11:58:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <f17812d70906090239p5dee129egda49918b3862c0ca@mail.gmail.com>
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
Cc: alsa-devel@alsa-project.org, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, Daniel Ribeiro <drwyrm@gmail.com>, pHilipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 09, 2009 at 05:39:18PM +0800, Eric Miao wrote:

> OK, not having enough time to read all this thread, let's make sure
> first we are on the same floor:

> frame_width  = number of bit clocks per frame
> sample_width = number of bits per sample

Yes.

> And the assumption that

> frame_width = sample_width * channel ( = LRCLK for I2S )

> is no longer (and ever) correct.

Ish.  That's always been a minimum for most frame formats, though with
programmable ports like the PXA SSP ports I2S normally makes it an exact
requirement.  At the minute the magician is abusing a low frame width to
produce a double rate frame clock but this is an abuse.

> And the TDM mode is actually special for PXA-SSP to emulate the I2S
> protocol, it's no way generic TDM in a common sense. So talking about
> set_tdm_slots(), I'd really like to hide into the format setting code
> of I2S/Left_J to avoid further confusion.

In terms of the ASoC APIs TDM mode should only be required in order to
configure actual TDM.  Ideally the PXA driver should only ever require
set_tdm_slot() for actual TDM configurations and setting up a single
slot for TDM should be equivalent to never having called it at all.

It's use in the PXA code has always been a wart.

> And I still didn't quite capture the issue of magician. Phillip, do
> you have any HW reference to the audio codec and the connection on
> magician?

Essentially his hardware ends up requiring one frame clock per sample in
a stereo stream - ie, a double rate frame clock.  I strongly expect that
it is actually running in a DSP mode with one frame sync per sample
rather than per frame.
