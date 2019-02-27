From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [PATCH RFC 2/3] ASoC: hdmi-codec: add support for
	bclk_ratio
Date: Wed, 27 Feb 2019 19:56:00 +0000
Message-ID: <20190227195600.jwhrjekyqz72xfmc@shell.armlinux.org.uk>
References: <20190222212619.ghxly3eb6dx7p2ut@shell.armlinux.org.uk>
 <E1gxILm-0004MX-Kb@rmk-PC.armlinux.org.uk>
 <520b346f-a874-790d-61ec-fb4ac67ad046@ti.com>
 <20190225140334.uy3qf55u2jjk3ith@shell.armlinux.org.uk>
 <CAGngYiWESOoKSp09=7W_EEdKJ5r47LQwVAanadAKOO=goy61qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk
 [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ADDB2F896A1
 for <alsa-devel@alsa-project.org>; Wed, 27 Feb 2019 20:56:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CAGngYiWESOoKSp09=7W_EEdKJ5r47LQwVAanadAKOO=goy61qg@mail.gmail.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Sven Van Asbroeck <thesven73@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Takashi Iwai <tiwai@suse.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 27, 2019 at 01:01:05PM -0500, Sven Van Asbroeck wrote:
> On Wed, Feb 27, 2019 at 6:47 AM Russell King - ARM Linux admin
> <linux@armlinux.org.uk> wrote:
> >
> > Given that, we do need some way to validate the bclk_ratio when it is
> > set, and not during hw_params which would (a) lead to ALSA devices
> > failing when userspace is negotiating the parameters and (b) gives no
> > way in the kernel for set_bclk_ratio() to discover whether a particular
> > ratio is supported by the codec.
> >
> > So, I think there's three possible ways around this:
> > 1. adding a set_bclk_ratio() method to hdmi_codec_ops
> > 2. calling hw_params() when our set_bclk_ratio() method is called
> >    (what if the rest of the format isn't set or incompatible, which
> >    may cause the hw_params() method to fail?)
> > 3. adding a list of acceptable bclk_ratio values to hdmi_codec_pdata
> >
> 
> Again excuse my obvious ignorance, but would these solutions work well in the
> more general case?
> 
> Imagine a cpu dai that supports 16x2/16x2, 20x2/20x2, 24x2/24x2
> (sample bits/frame bits -- wire format), sending audio to our tda998x
> hdmi xmitter.
> Depending on the type of samples that userspace chooses to play, one of the
> above formats gets selected by the ASoC core, resulting in a bclk_ratio of
> 16x2, 20x2 or 32x2. It's up to the card driver to call set_bclk_ratio(), right?
> So now this card driver needs intimate knowledge of bclk_ratios vs formats for
> the cpu dai. Also it needs knowledge of which bclk_ratios are supported by the
> hdmi xmitter, and a mechanism to filter our the 20x2 blk_ratio format.

That's why I said in a previous email that it would be good if there
was some way that the capabilities of the codec and cpu DAIs were
known to the ASoC core.

> Which may not be trivial, and also prevents it from being generic,
> i.e. we can no longer use simple-card ?

It seems trivial today that we have a complex system called ALSA PCM,
where lots of different parameters are negotiated between the kernel
driver and userspace, which include:

- sample rate
- number of channels
- buffer size
- period size
- frame bits (unfortunately, not on-wire!)
etc.

If you want to see the full list, see the SNDRV_PCM_HW_PARAM_*
definitions in include/uapi/sound/asound.h.

The kernel driver can arbitarily apply rules to these, even inter-
dependent rules - it's possible to specify in kernel space a rule such
as "we can support 48kHz with up to six channels, or 96kHz with two
channels" and ALSA will handle it.  Other rules are possible.

More than that, if we have a PCM device that supports (eg) only 48kHz,
44.1kHz and 32kHz sample rates with two channels, and we attempt to
play a 11.025kHz mono sample, userspace will negotiate one of the
hardware supported formats, and then automatically assemble within
libasound a set of plugins that convert the number of channels to
what the hardware supports, and performs sample rate conversion.

Yet, we seem to be saying that we can't solve the problem of the
sample-rate to bitclock ratio.

I suspect we could do using this infrastructure...

> But it gets worse. Imagine a hypothetical cpu dai that supports 20x2/20x2 and
> 20x2/24x2. When the dai is sending to a codec that doesn't care about
> bclk_ratio,
> it should pick 20x2/20x2, because that's most efficient, right? Except
> on a tda998x
> it should select 20x2/24x2. So how would a card driver now even begin to
> deal with this, given that there appears to be no mechanism to even describe
> these differences? Because the params_physical_width() describes the memory
> format, and not the wire format, correct?

If we were able to describe the on-wire frame size to ALSA's constraint
resolution core, I bet it can resolve this for us.

To take the above, for I2S, TDA998x would add a rules to ALSA saying:

1. "I support 2*N channels" where 1 < N < number of I2S inputs.
2. "I support sample widths from 16 to 24 bits"
3. "I support on-wire frame bits 32, 48, 64, 128"
4. "Depending on the sample width, I support <limited-from-above>
   on-wire frame bits".

We now have TDA998x's parameters described to the ALSA core.

The CPU on the other hand would say to the ALSA core (e.g.):

1. "I support 1-8 channels"
2. "I support sample widths from 8 to 32 bits"
3. "I support on-wire frame bits only of 64"

During ALSAs hardware parameter refining, this would result in ALSA
settling on a frame bits of 64 for everything.

If, on the other hand, we had a CPU DAI specifying these rules:

1. "I support 1-8 channels"
2. "I support sample widths from 8 to 32 bits"
3. "Depending on the sample width, I support on-wire frame bits only
   of sample width * 2"

Then ALSA if you ask for 16 bit samples, it would end up settling on
a frame bits of 32, for 24 bit, 48.  For the others, it would notice
that it can't do a sample width of 18 or 20 bits, and would probably
decide upon 24 bit.

And... userspace would automatically pick up a plugin to convert to
24 bit sample width (provided its using one of libasound's plughw
devices rather than the raw "no conversion" devices.)

Now, the problem is... there doesn't seem to be an existing hardware
parameter for the on-wire frame bits - it isn't
SNDRV_PCM_HW_PARAM_FRAME_BITS - sound/core/pcm_native.c already has
rules for this parameter that lock it to sample_bits * channels, and
it's used to determine the period bytes from the period size etc.
However, if you look down the list of rules in
snd_pcm_hw_constraints_init(), you'll see that these kinds of
relationships can be described to ALSA's contraint resolution core.

It does look like struct snd_pcm_hw_params has some space to be able
to extend the intervals, but I'm guessing that isn't going to be easy
given that userspace won't know about the new interval, although I'm
not sure whether that really matters for this case.  However, I can
see that there will be objections to exposing such a parameter to
userspace.

Another problem is hdmi-codec trying to abstract ALSA and ASoC, and
hide it from the actual HDMI bridge.  It means bridges have no access
to many of the ALSA facilities, and basically have to "do what they're
told or fail" causing a hard-failure in ALSA.

Rather than the nice "lets refine the hardware parameters and then
insitute whatever plugins are necessary" we get instead something
like this (for example, using a slightly hacked driver to show what
happens if we error out in hdmi_codec_hw_params()):

$ aplay -Dplughw:0,0 /usr/lib/libreoffice/share/gallery/sounds/theetone.wav
Playing WAVE '/usr/lib/libreoffice/share/gallery/sounds/theetone.wav' :
Signed 16 bit Little Endian, Rate 11025 Hz, Mono
aplay: set_params:1297: Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 16
CHANNELS: 1
RATE: 11025
PERIOD_TIME: (127709 127710)
PERIOD_SIZE: 1408
PERIOD_BYTES: 2816
PERIODS: (3 4)
BUFFER_TIME: (499229 499230)
BUFFER_SIZE: 5504
BUFFER_BYTES: 11008
TICK_TIME: 0

which is showing what userspace does when hdmi_codec_hw_params()
returns -EINVAL - ALSA just gives up.  It doesn't even bother trying
any of its format and sample rate conversion which _is_ available
via the "plughw" device.  If it knew ahead of time (iow, during the
constraint refining) then it would've used plugins to convert from
(e.g.) 11.025kHz mono to 48kHz stereo.  By way of illustration, here's
the difference on x86, HDA-Intel:

Playing WAVE '/usr/lib/libreoffice/share/gallery/sounds/theetone.wav' : Signed 16 bit Little Endian, Rate 11025 Hz, Mono
Plug PCM: Rate conversion PCM (44100, sformat=S16_LE)
Converter: linear-interpolation
Protocol version: 10002
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 1
  rate         : 11025
  exact rate   : 11025 (11025/1)
  msbits       : 16
  buffer_size  : 4096
  period_size  : 1024
  period_time  : 92879
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 1024
  period_event : 0
  start_threshold  : 4096
  stop_threshold   : 4096
  silence_threshold: 0
  silence_size : 0
  boundary     : 268435456
Slave: Route conversion PCM (sformat=S16_LE)
  Transformation table:
    0 <- 0
    1 <- 0
Its setup is:
  stream       : PLAYBACK
  access       : MMAP_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 1
  rate         : 44100
  exact rate   : 44100 (44100/1)
  msbits       : 16
  buffer_size  : 16384
  period_size  : 4096
  period_time  : 92879
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 4096
  period_event : 0
  start_threshold  : 16384
  stop_threshold   : 16384
  silence_threshold: 0
  silence_size : 0
  boundary     : 1073741824
Slave: Hardware PCM card 0 'HDA Intel' device 0 subdevice 0
Its setup is:
  stream       : PLAYBACK
  access       : MMAP_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 44100
  exact rate   : 44100 (44100/1)
  msbits       : 16
  buffer_size  : 16384
  period_size  : 4096
  period_time  : 92879
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 4096
  period_event : 0
  start_threshold  : 16384
  stop_threshold   : 16384
  silence_threshold: 0
  silence_size : 0
  boundary     : 1073741824
  appl_ptr     : 0
  hw_ptr       : 0

And there you have the hardware running at 44.1kHz stereo, playing
the very same 11.025kHz mono wav file with userspace plugins
clearly automatically picked up.

> So all this kind of suggests to me that the bclk_ratio could be part of the
> format description, or something?
> 
> static struct snd_soc_dai_driver acme_cpu_dai = {
>         .playback = {
>                 .formats = SNDRV_PCM_FMTBIT_S20_3LE_20 |
>                                 SNDRV_PCM_FMTBIT_S20_3LE_24,
>                                 SNDRV_PCM_FMTBIT_S16_LE | //
> bclk_ratio 16 implied
>                                 SNDRV_PCM_FMTBIT_S24_LE | //
> bclk_ratio 24 implied
>                                 SNDRV_PCM_FMTBIT_S24_LE_32

I don't think this is going to work.  Firstly, it'll break userspace,
becuase userspace would need to be taught about all these new format
identifiers.  Secondly, it massively increases the number of formats
to number_of_existing_formats * number_of_possible_bclk_ratios.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
