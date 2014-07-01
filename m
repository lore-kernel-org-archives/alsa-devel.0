From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 00/13] Remove mach-kirkwood and mach-dove
Date: Tue, 1 Jul 2014 17:56:49 +0100
Message-ID: <20140701165649.GZ32514@n2100.arm.linux.org.uk>
References: <1404075603-31838-1-git-send-email-andrew@lunn.ch>
 <20140629213510.GR32514@n2100.arm.linux.org.uk> <53B154FE.80804@gmail.com>
 <20140630124320.GZ32514@n2100.arm.linux.org.uk>
 <20140630181347.6a4ad4a8@armhf>
 <20140630162050.GC32514@n2100.arm.linux.org.uk>
 <20140701184413.6d9aa16f@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pandora.arm.linux.org.uk (gw-1.arm.linux.org.uk [78.32.30.217])
 by alsa0.perex.cz (Postfix) with ESMTP id 4FF182650EE
 for <alsa-devel@alsa-project.org>; Tue,  1 Jul 2014 18:56:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20140701184413.6d9aa16f@armhf>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org, Jason Cooper <jason@lakedaemon.net>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Mark Brown <broonie@kernel.org>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 01, 2014 at 06:44:13PM +0200, Jean-Francois Moine wrote:
> On Mon, 30 Jun 2014 17:20:51 +0100
> Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> 
> > Add DPCM support to kirkwood-i2s to support the I2S and SPDIF streams.
> > This consists of:
> > - a single front end DAI called "kirkwood-fe" with "dma-tx" and "dma-rx"
> >   streams.
> > - one backend DAI called "kirkwood-i2s" for I2S with streams named
> >   "i2s-tx" and "i2s-rx"
> > - one backend DAI called "kirkwood-spdif" for SPDIF with a single stream
> >   named "spdif-tx".
> 
> In the Cubox, you may have kirkwood S/PDIF with both HDMI and S/PDIF
> outputs and this avoids to activate both kirkwood I2S and S/PDIF in
> most cases.

I run my Cubox with just SPDIF output to both.

> > -		.rates = SNDRV_PCM_RATE_CONTINUOUS,
> > -		.rate_min = 5512,
> > -		.rate_max = 192000,
> > -		.formats = KIRKWOOD_I2S_FORMATS,
> > +		.rates = SNDRV_PCM_RATE_8000_192000 |
> > +			 SNDRV_PCM_RATE_CONTINUOUS |
> > +			 SNDRV_PCM_RATE_KNOT,
> > +		.formats = KIRKWOOD_FE_FORMATS,
> 
> This does not work: SNDRV_PCM_RATE_CONTINUOUS asks for rate_min and
> rate_max. SNDRV_PCM_RATE_KNOT is of no interest here.

Yes, there was a recent discussion about that, but I've yet to update
this driver for it.

> > diff --git a/sound/soc/kirkwood/kirkwood-openrd.c b/sound/soc/kirkwood/kirkwood-openrd.c
> > index 65f2a5b9ec3b..78fb05ff44a8 100644
> > --- a/sound/soc/kirkwood/kirkwood-openrd.c
> > +++ b/sound/soc/kirkwood/kirkwood-openrd.c
> > @@ -49,24 +49,34 @@ static struct snd_soc_ops openrd_client_ops = {
> >  
> >  
> >  static struct snd_soc_dai_link openrd_client_dai[] = {
> > +	KIRKWOOD_FE_DAI_LINK(".0", 1, 1),
> >  {
> >  	.name = "CS42L51",
> >  	.stream_name = "CS42L51 HiFi",
> > -	.cpu_dai_name = "i2s",
> > -	.platform_name = "mvebu-audio",
> > +	.cpu_name = "mvebu-audio.0",
> > +	.cpu_dai_name = "kirkwood-i2s",
> > +	.platform_name = "snd-soc-dummy",
> >  	.codec_dai_name = "cs42l51-hifi",
> >  	.codec_name = "cs42l51-codec.0-004a",
> >  	.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBS_CFS,
> >  	.ops = &openrd_client_ops,
> > +	.dpcm_playback = 1,
> > +	.dpcm_capture = 1,
> >  },
> >  };
> 
> There is no need to change the openrd and t5325 drivers: they may use
> the kirkwood DAI's in a non-DPCM way.

With a proper DPCM solution, at least one backend must be linked so that
the CPU side knows which interface(s) are in use.  This solution allows
both to be used simultaneously, which, if you wish to use I2S on the
Cubox to drive the TDA998x (against my advice, but I'm not going to
stop you) and also have the SPDIF output on the side of the device
working, this is required.

> > diff --git a/sound/soc/kirkwood/kirkwood-spdif.c b/sound/soc/kirkwood/kirkwood-spdif.c
> > index 9d49bc53f07d..6098dde85fc9 100644
> > --- a/sound/soc/kirkwood/kirkwood-spdif.c
> > +++ b/sound/soc/kirkwood/kirkwood-spdif.c
> 
> What is that file?

This is the file for supporting SPDIF on the Cubox.

> Eventually, your code is close to the one I tested end 2013. But, once
> again, this does not work because DPCM does not handle the format and
> rate constraints of the backends. This is critical for the device which
> is connected to HDMI.

DPCM may have these shortcomings, but this is how Mark Brown was telling
me he wanted the hardware on Dove supported, and would not accept any
other solution from me.

However, what you say does not hold for all cases - if you use the SPDIF
output on the side of the Cubox (as I do) you are not limited to the
constraints of the attached HDMI device - in fact, limiting this case to
the constraints of the attached HDMI device is wrong.  The only time
this makes sense is if you only want to use the HDMI device and not the
optical out on the side.

With a decoder box connected to the optical output, I can decode a wide
range of sample rates beyond those which my TV can cope with, and I can
also directly decode AC-3 and MPEG2 audio streams in hardware - even to
decoding AC-3 to 5.1 audio without any load on the Dove CPU beyond
sending the compressed audio stream.

This is where getting this stuff correct is most important - the TV must
not see valid audio being sent to it (with SPDIF, compressed audio is
always sent with the valid bit not set.)  With I2S, the I2S output must
be muted or disabled - exactly as the Dove manuals clearly state.

Also bear in mind that HDMI is based on SPDIF (it's SPDIF with a few
bits omitted) and HDMI also supports compressed audio, dependent on the
attached device's capabilities, and the attached device will decode
compressed audio when presented correctly - which is only possible via
a SPDIF connection between the Dove and TDA998x.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
