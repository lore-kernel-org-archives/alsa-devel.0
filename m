From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: hdmi-codec: modifying params in hw_params() callback
Date: Thu, 28 Feb 2019 13:10:59 +0000
Message-ID: <20190228131059.i4nffuylja5p6tjv@shell.armlinux.org.uk>
References: <20190228121516.swd3vweisgcxlvld@shell.armlinux.org.uk>
 <421c1217-6ff6-6ca2-8169-db026284fb29@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <421c1217-6ff6-6ca2-8169-db026284fb29@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 28, 2019 at 02:54:29PM +0200, Jyri Sarha wrote:
> On 28/02/2019 14:15, Russell King - ARM Linux admin wrote:
> > Hi all,
> > 
> > While looking at hdmi-codec issues, I spotted this code:
> > 
> > static int hdmi_codec_hw_params(struct snd_pcm_substream *substream,
> >                                 struct snd_pcm_hw_params *params,
> >                                 struct snd_soc_dai *dai)
> > {
> > ...
> >         if (params_width(params) > 24)
> >                 params->msbits = 24;
> > 
> > params->msbits is a parameter that is negotiated and refined by
> > libasound, and is part of the ALSA constraint system.  The "Writing an
> > ALSA driver" documentation says about the hw_params callback:
> > 
> > "This is called when the hardware parameter (``hw_params``) is set up
> >  by the application, that is, once when the buffer size, the period
> >  size, the format, etc. are defined for the pcm substream."
> > 
> > which suggests we should only be reading the parameters, not writing
> > to them.
> > 
> > What's more is that the msbits is a parameter that is refined with
> > userspace, so surely the above should be a declared constraint?
> > 
> 
> Certainly not a constraint. While HDMI can only pass up to 24-bit per
> sample audio the most (or at least the two I have worked with) encoders
> can take 32-bit wide (and probably wider) samples trough i2s. So the
> system can play 32-bit samples, just the 4 LSB is ignored.

You have not explained why "not a constraint".  From the explanation
that Mark gave me on IRC, msbits is the number of bits that the codec
respects, whereas the sample bits is the number of bits in the sample.
If sample bits - msbits != 0, then that is the number of bits ignored.
Mark basically described it as "feel free to send me more than 24 bits
but I'm ignoring the LSBs".

If the msbits is limited to 24, then userspace gets to know about that
limitation when negotiating with ALSA if it is a constraint.  If it
isn't a constraint, userspace has no way to know.

> Actually there is very little difference between the case of playing
> 32-bit stereo audio with matching i2s bclk ratio, and playing 24-bit
> stereo audio with 64-bit bclk ratio. Especially when the 4 LSB is anyway
> ignored like in HDMI audio case.

You mean 8 LSB throughout the above two paragraphs.

> > Digging a bit deeper, ASoC passes a private copy of the params to each
> > codec - a copy is made, then fixups for TDM slots are applied, followed
> > by any topology fixups by the DAI link (be_hw_params_fixup) before the
> > codec driver's hw_params() callback is made.  Afterwards, ASoC reads
> > back the rate, channels and physical (memory) width and stores them
> > in the codec's DAI structure.  The msbits are not read.
> > 
> > hdmi-codec also seems to do nothing with the msbits parameter other
> > than the above code.
> > 
> > So, all in all, it seems that the above code limiting msbits is
> > redundant - nothing will read this modified value.  Can we kill it?
> > 
> 
> It certainly looks that way, so yes. In any case struct
> snd_soc_dai_driver .playback.sig_bits = 24 should be all that is needed.

This sets a constraint to limit msbits to 24 for any sample width
in core ASoC code, doing exactly what you said "certainly not" to
above.

It also means that the quoted code in hdmi-codec's hw_params() is
redundant for another reason.

See the description of:
snd_pcm_hw_constraint_msbits() in sound/core/pcm_lib.c,
soc_pcm_set_msb() and soc_pcm_apply_msb() in sound/soc/soc-pcm.c.

Can you please clarify, because there seems to be some confusion.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
