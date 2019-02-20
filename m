From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: RE: [alsa-devel] [PATCH] ASoC: AMD: Configure master codec on all
 playback/capture cases
Date: Wed, 20 Feb 2019 09:30:00 +0000
Message-ID: <AM5PR1001MB09948F06C726837F15DFB01C807D0@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
References: <20190215070539.22150-1-akshu.agrawal@amd.com>
 <20190218181807.GF10794@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190218181807.GF10794@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, "djkurtz@chromium.org" <djkurtz@chromium.org>, Liam Girdwood <lgirdwood@gmail.com>, Wei Yongjun <weiyongjun1@huawei.com>, "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

On 8 February 2019 18:18, Mark Brown wrote:

> On Fri, Feb 15, 2019 at 07:06:15AM +0000, Agrawal, Akshu wrote:
>=20
> > +static static int cz_da7219_hw_params(struct snd_pcm_substream
> *substream,
> > +				    struct snd_pcm_hw_params *params) {
> > +	/* da7219 Codec is clock master so setup as per the needs */
> > +	if (codec_dai->driver->ops->hw_params)
> > +		return codec_dai->driver->ops->hw_params(substream, params,
> > +							 codec_dai);
> > +	return 0;
> > +}
>=20
> No, this is a bad idea - you shouldn't be callings ops in drivers outside=
 of the
> framework, something is going to break on you there.
> Either the drivers or the frameworks are going to get surprised by things=
 getting
> called out of sequence, for example I'd not rely on the fact that the COD=
EC would
> be outputing a clock without active audio.
> This probably means that you're going to have to extend the framework in =
some
> way, or refactor things so that the BCLK is exported as a clock by the CO=
DEC and
> reflect the relationships via the clock API.  I need to think a bit more =
but I think
> the clock API is going to be the the best solution.
>=20
> I also suspect that some work is needed to propagate constraints between =
the
> various DAIs in the system.

So this was a suggestion from my side to avoid the scenario where the syste=
m
starts, the DA7219 codec hasn't yet been used (hw_params() not been called)=
, and
one of the other audio devices is needed for playback/capture. The codec wi=
ll be
at a default DAI configuration rather than the configuration that's require=
d. If
the DA7219 codec had been used first then of course there's no problem and =
the
system runs as expected from then on.

This AMD platform limits all DAIs to 48KHz, 2 channel so the configuration =
is
fixed, as I understand it. DA7219 will output DAI clocks without data so th=
ere's
no problem there. I initially suggested using 'soc_dai_hw_params()' but the
function isn't a global symbol, probably intentionally, so for this more un=
usual
config I felt the above approach might be an option. Absolutely understand =
your
concerns though.

I considered the CCF approach but I'm not 100% confident that the clocking
mechanism of the codec will fit ideally into that framework. There's alread=
y
a clock gate for the DAI clocks, in the driver, but nothing more. The probl=
em
here is that the BCLK rate is intrinsically linked to the WCLK rate, as wel=
l as
the word length, so changing the desired BCLK rate would affect the WCLK ra=
te,
and vice versa. I will take a look again, but if you have any suggestions t=
hen
they'd be greatly received.
