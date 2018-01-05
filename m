From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH] ASoC: codecs: dmic: Use channel map for configs with a
 single mic
Date: Fri, 5 Jan 2018 11:18:36 -0800
Message-ID: <20180105191836.GA111999@google.com>
References: <20180104194848.198941-1-mka@chromium.org>
 <20180104195438.GA200397@google.com>
 <295ce358-c00e-74ce-50c1-1df32c2c6cf7@st.com>
 <20180105120455.GA9076@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180105120455.GA9076@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Arnaud Pouliquen <arnaud.pouliquen@st.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Bhumika Goyal <bhumirks@gmail.com>, huang lin <hl@rock-chips.com>, Brian Norris <briannorris@chromium.org>, Dylan Reid <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org

El Fri, Jan 05, 2018 at 12:04:55PM +0000 Mark Brown ha dit:

> On Fri, Jan 05, 2018 at 11:45:43AM +0100, Arnaud Pouliquen wrote:
> 
> > >> +             num-channels = <1>;
> 
> > In your implementation seems not linked to hardware but software...
> 
> > DMIC driver description specifies the channels_max to 8 channels.
> > I suppose that it is used for DMIC codecs that integrate filters and are
> > connected to CPU DAI with I2S/PCM links. But it can be also used for
> > DMIC connected to CPU DAI with a SPI link (in this case decimation
> > filter in on Soc side).
> 
> The intention with the DMIC CODEC is that it's used when the CPU
> directly has PDM inputs and the DMICs are just directly wired to it
> (stereo is obviously the norm here but some SoCs may bunch things up
> further for use with mic arrays).
> 
> > If we continue to support both use cases, specify the number of channels
> > seems reasonable but this should be use to change the max channel
> > constraint, not to declare a control.
> 
> Yes, that would seem the most obvious thing - it's how we handle things
> like CPU DAIs that support very high channel counts when connected to
> stereo CODECs for example.  It's not obvious why we'd use a channel map
> here instead.

Thanks for the feedback!

I experimented initially with changing channels_max, but overwriting
dmic_dai.capture.channels_max didn't seem right since it would affect
other possible instances of the codec. I overlooked that this can be
avoided by passing a *copy* with adjusted channels_max to
snd_soc_register_codec().

Matthias
