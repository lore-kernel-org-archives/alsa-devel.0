From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [PATCH RFC 2/3] ASoC: hdmi-codec: add support for
	bclk_ratio
Date: Fri, 1 Mar 2019 14:59:57 +0000
Message-ID: <20190301145957.gam3m327242vvy7g@shell.armlinux.org.uk>
References: <20190222212619.ghxly3eb6dx7p2ut@shell.armlinux.org.uk>
 <E1gxILm-0004MX-Kb@rmk-PC.armlinux.org.uk>
 <520b346f-a874-790d-61ec-fb4ac67ad046@ti.com>
 <20190301123629.GC7429@sirena.org.uk>
 <6962d496-cd18-2fae-01a0-7b387ad672c9@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk
 [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 73DD3F896C0
 for <alsa-devel@alsa-project.org>; Fri,  1 Mar 2019 16:00:19 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <6962d496-cd18-2fae-01a0-7b387ad672c9@ti.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Jyri Sarha <jsarha@ti.com>
Cc: Sven Van Asbroeck <thesven73@gmail.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 01, 2019 at 04:05:25PM +0200, Jyri Sarha wrote:
> On 01/03/2019 14:36, Mark Brown wrote:
> > On Mon, Feb 25, 2019 at 03:45:44PM +0200, Jyri Sarha wrote:
> >> On 22/02/2019 23:27, Russell King wrote:
> > 
> >>> +	/*
> >>> +	 * If the .set_bclk_ratio() has not been called, default it
> >>> +	 * using the sample width for compatibility for TDA998x.
> >>> +	 * Rather than changing this, drivers should arrange to make
> >>> +	 * an appropriate call to snd_soc_dai_set_bclk_ratio().
> >>> +	 */
> >>> +	if (fmt.bclk_ratio == 0) {
> >>> +		switch (hp.sample_width) {
> >>> +		case 16:
> >>> +			fmt.bclk_ratio = 32;
> >>> +			break;
> >>> +		case 18:
> >>> +		case 20:
> >>> +		case 24:
> >>> +			fmt.bclk_ratio = 48;
> >>> +			break;
> > 
> >> AFAIK, this is not the usual choice for 18- or 20-bit samples. Usually,
> >> the bclk_ratio is set to the exact frame length required by the sample
> >> width without any padding. That is at least the case with
> >> tlv320aic3x-driver and 20-bit sample width.
> > 
> > So, this is true.  On the other hand like Russell says further down the
> > thread it's preserving the existing behaviour so it would be surprising
> > if it actually broke anything and it will help systems that explicitly
> > set the ratio so I don't think we should let perfect be the enemy of
> > good here.
> > 
> 
> Sure. Still, the requirement for having bclk_ratio of either 32, 48, or
> 64 is coming from tda998x, so that requirement should be satisfied in
> tda998x driver, not in hdmi-codec that is supposed to be generic and
> imposes that behaviour to all other user too.
> 
> Of course we should not make things overly complicated just because of
> such principle. But in this case we are trying to preserve existing
> behaviour that has hardly ever worked, and the new behaviour will
> potentially cause more trouble.

Err, what?

With respect to TDA998x, my patches do not change the behaviour in
any way of the TDA998x setup.  As I have already established:

1. I'm introducing a new bclk_ratio member into the hdmi daifmt
   structure.  There can be no other users of this except the ones
   that are introduced from this point forth.

2. No one calls the function that sets the bclk_ratio in the
   entire codebase that is sound/soc, so no one will set bclk_ratio
   to anything non-zero, except any new callers that get introduced.

So, at the point that patch 2 is merged, no one is using the values
that the new code derives.  No one is supplying bclk_ratio values to
the code either.

As I have already stated, the way I see this code is it is a stop-gap
to allow TDA998x to continue working as well as it does _today_ on
BBB when we convert TDA998x to start using the supplied bclk_ratio.
However, what we should strive to do is to eliminate that code as
soon as possible - in other words, making BBB and all the other
users set the bclk_ratio explicitly for I2S links.

However, you bring up another issue in what you have said above -
you appear to be claiming that the "existing behaviour has hardly
ever worked".  If it hardly ever works, this seems to imply that
audio support on BBB is currently broken.

If BBB audio is broken, then we don't need this at all, and we can
just change TDA998x to error out on a zero bclk_ratio value.

> And if we really want to preserve the
> existing behaviour there is another way that affects only tda998x driver:
> 
> - hdmi-codec leaves the struct hdmi_codec_params bclk_ratio to 0 if
>   snd_soc_dai_set_bclk_ratio() is not called
> 
> - tda998x_audio_hw_params() checks if bclk_ratio == 0 and makes the
>   implicit bclk_ratio setting the same way as the code above does it

I'm afraid I completely disagree.  Pushing that into the tda998x
driver means that:

1. there is no motivation to set a correct bclk_ratio value (no one
   sets it today.)
2. because no one sets the bclk_ratio, users of hdmi-codec will see
   bclk_ratio as zero, so if they care they will implement their
   drivers with their own defaults, which may be to always default
   to 64fs, or may be to default to 2x sample_width.
3. since the defaults match what the HDMI bridges are used with,
   no one will bother implementing a call to the ASoC function to
   set bclk_ratio.

So, we'll continue on as we have done, with no one calling the ASoC
function, HDMI bridges making their own randomly different bclk_ratio
assumptions, and the whole thing generally decending into an
unmaintainable mess.

With the defaulting in the hdmi-codec code, it gives a bit more
motivation for things to get fixed up: if the default in hdmi-codec
is not suitable, it forces the I2S source to explicitly set the
bclk_ratio accurately.

It becomes even better when we remove the defaulting, because we
then require everyone to call it for I2S to be functional with
hdmi-codec with a HDMI bridge that requires this information.

Even better than that would be to make hdmi-codec require that
the bclk_ratio is set, which means we have a hope that we're not
going to end up in the endless situation where we have to retrofit
the bclk_ratio call this into future I2S source.

... where "I2S source" above I mean the non-codec parts of the
subsystem.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
