From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] ASoC: wm9713: add gpio chip
Date: Fri, 6 Nov 2015 09:48:28 +0000
Message-ID: <20151106094828.GD3378@x1>
References: <1446657164-25012-1-git-send-email-robert.jarzmik@free.fr>
 <20151104183322.GD2549@ck-lbox>
 <87oaf9bls9.fsf@belgarion.home>
 <20151106092913.GC3378@x1>
 <20151106092733.GG2549@ck-lbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151106092733.GG2549@ck-lbox>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, 06 Nov 2015, Charles Keepax wrote:

> On Fri, Nov 06, 2015 at 09:29:13AM +0000, Lee Jones wrote:
> > On Wed, 04 Nov 2015, Robert Jarzmik wrote:
> >=20
> > > Charles Keepax <ckeepax@opensource.wolfsonmicro.com> writes:
> > >=20
> > > > On Wed, Nov 04, 2015 at 06:12:44PM +0100, Robert Jarzmik wrote:
> > > >> The Wolfson WM9713 provides 8 GPIOs. If the gpiolib is compile=
d in the
> > > >> kernel, declare a gpio chip.
> > > >>=20
> > > >> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> > > >> ---
> > > >
> > > > You should probably make a seperate driver within GPIO for this
> > > > and then tie the two together, using an MFD. I appreciate that =
is
> > > > more work but it is likely a nicer solution overall.
> > >=20
> > > I'd like to first have a confirmation from :
> > >  - Mark (Brown)
> > >  - and Lee (Jones)
> > >=20
> > > The confirmation I'm looking for states that :
> > >  - the wm9713 should have a part in the mfd tree
> > >  - the gpio part should be in drivers/gpio
> > >  - the sound soc codecs will remain as is
> > >  - if the future driver/mfd/wm9713.c is technically sound, it wil=
l be accepted
> > >=20
> > > I remember at least one example where the MFD approach was reject=
ed from mfd
> > > tree for pxa gpios, so I won't work unless I have a confirmation =
from both
> > > maintainers.
> >=20
> > I have no idea what you're talking about.  Context please?
>=20
> Apologies Lee, we are discussing a patch that adds a GPIO driver
> into an AC97 CODEC. I had suggested that perhaps we should put
> the GPIO driver as a seperate driver under GPIO and link the two
> with an MFD. But Mark has already replied in the thread to say
> that he doesn't think that will be necessary. Although he did
> raise some concerns that perhaps it could be done more generally
> as it should apply to other AC97 CODECs as well.
>=20
> So I think you can probably safely ignore this for now, sorry
> for the noise.

Roger that.  Thanks for the explanation.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
