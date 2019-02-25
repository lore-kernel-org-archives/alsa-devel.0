From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [PATCH RFC 2/3] ASoC: hdmi-codec: add support for
	bclk_ratio
Date: Mon, 25 Feb 2019 14:03:34 +0000
Message-ID: <20190225140334.uy3qf55u2jjk3ith@shell.armlinux.org.uk>
References: <20190222212619.ghxly3eb6dx7p2ut@shell.armlinux.org.uk>
 <E1gxILm-0004MX-Kb@rmk-PC.armlinux.org.uk>
 <520b346f-a874-790d-61ec-fb4ac67ad046@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk
 [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 441BCF89634
 for <alsa-devel@alsa-project.org>; Mon, 25 Feb 2019 15:03:54 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <520b346f-a874-790d-61ec-fb4ac67ad046@ti.com>
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

On Mon, Feb 25, 2019 at 03:45:44PM +0200, Jyri Sarha wrote:
> On 22/02/2019 23:27, Russell King wrote:
> > Some HDMI codecs need to know the relationship between the I2S bit clock
> > and the I2S word clock in order to correctly generate the CTS value for
> > audio clock recovery on the sink.
> > 
> > Add support for this, but there are currently no callers of
> > snd_soc_dai_set_bclk_ratio(), we provide a default implementation that
> > uses the sample width to derive the ratio from the 8-bit aligned
> > sample size.  This reflects the derivation that is in TDA998x, which
> > we are going to convert to use this new support.
> > 
> > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> > ---
> >  include/sound/hdmi-codec.h    |  1 +
> >  sound/soc/codecs/hdmi-codec.c | 45 +++++++++++++++++++++++++++++++++++++++++--
> >  2 files changed, 44 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/sound/hdmi-codec.h b/include/sound/hdmi-codec.h
> > index 9483c55f871b..0fca69880dc3 100644
> > --- a/include/sound/hdmi-codec.h
> > +++ b/include/sound/hdmi-codec.h
> > @@ -42,6 +42,7 @@ struct hdmi_codec_daifmt {
> >  	unsigned int frame_clk_inv:1;
> >  	unsigned int bit_clk_master:1;
> >  	unsigned int frame_clk_master:1;
> > +	unsigned int bclk_ratio;
> >  };
> >  
> >  /*
> > diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
> > index e5b6769b9797..d71a7e5a2231 100644
> > --- a/sound/soc/codecs/hdmi-codec.c
> > +++ b/sound/soc/codecs/hdmi-codec.c
> > @@ -470,6 +470,7 @@ static int hdmi_codec_hw_params(struct snd_pcm_substream *substream,
> >  				struct snd_soc_dai *dai)
> >  {
> >  	struct hdmi_codec_priv *hcp = snd_soc_dai_get_drvdata(dai);
> > +	struct hdmi_codec_daifmt fmt;
> >  	struct hdmi_codec_params hp = {
> >  		.iec = {
> >  			.status = { 0 },
> > @@ -520,8 +521,43 @@ static int hdmi_codec_hw_params(struct snd_pcm_substream *substream,
> >  	hp.sample_rate = params_rate(params);
> >  	hp.channels = params_channels(params);
> >  
> > +	fmt = hcp->daifmt[dai->id];
> > +
> > +	/*
> > +	 * If the .set_bclk_ratio() has not been called, default it
> > +	 * using the sample width for compatibility for TDA998x.
> > +	 * Rather than changing this, drivers should arrange to make
> > +	 * an appropriate call to snd_soc_dai_set_bclk_ratio().
> > +	 */
> > +	if (fmt.bclk_ratio == 0) {
> > +		switch (hp.sample_width) {
> > +		case 16:
> > +			fmt.bclk_ratio = 32;
> > +			break;
> > +		case 18:
> > +		case 20:
> > +		case 24:
> > +			fmt.bclk_ratio = 48;
> > +			break;
> 
> AFAIK, this is not the usual choice for 18- or 20-bit samples. Usually,
> the bclk_ratio is set to the exact frame length required by the sample
> width without any padding. That is at least the case with
> tlv320aic3x-driver and 20-bit sample width.

As mentioned in the commit message, this is what TDA998x does today,
and I have to assume that the contributor tested this, who seems to
be one Jyri Sarha in commit 95db3b255fde ("drm/i2c: tda998x: Improve
tda998x_configure_audio() audio related pdata").

If we don't do it this way, then converting TDA998x to use this
defaulting would change the already established behaviour.  As there
are no users of this by hdmi-codec implementations, and as there are
no callers of snd_soc_dai_set_bclk_ratio(), the only way to maintain
the current behaviour in TDA998x is to either place a default in
hdmi-codec.c, or to have hdmi-codec.c pass zero into TDA998x and have
that encode the above.

I would much rather every user of hdmi-codec gained support for
snd_soc_dai_set_bclk_ratio() rather than relying on that default, but
that is beyond what I can do - I don't have the knowledge of which
sound setups would need it, and I don't have any platforms that are
configured to use I2S with TDA998x.

The Dove Cubox has spdif and i2s but is setup to use spdif (since
that is the most flexible, supporting compressed audio.)  I've a large
pile of unsubmittable patches there which makes kirkwood use DPCM, as
they would end up breaking all the existing users, and from what I can
see there's no way around that.  That makes submitting a patch to add
snd_soc_dai_set_bclk_ratio() very difficult.  That said, the above
defaults are not correct for kirkwood-i2s - that always uses bclk
running at 64fs, as per the TDA998x code prior to your patch I mention
above.

ARM Juno has two TDA998x, but the DT description lacks any audio
description, so it's not clear whether these are even wired.

The ARM MPS platform has a TDA998x connected to a HDLCD, but the HDLCD
does not have an interrupt - and the DRM driver requires an interrupt.
The conclusion that was come to there is basically "don't even bother".
Also unknown whether audio is wired up.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
