From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: RE: [PATCH] ASoC: da7219: Use clk_round_rate to handle enabled
 bclk/wclk case
Date: Mon, 29 Apr 2019 09:16:08 +0000
Message-ID: <AM5PR1001MB0994EA351AEF82224D9AA6BF80390@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
References: <20190426125925.04F3F3FB4A@swsrvapps-01.diasemi.com>
 <20190427171955.GH14916@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190427171955.GH14916@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, Akshu Agrawal <Akshu.Agrawal@amd.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Support Opensource <Support.Opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

On 27 April 2019 18:20, Mark Brown wrote:

> On Fri, Apr 26, 2019 at 01:59:24PM +0100, Adam Thomson wrote:
>=20
> > +		/*
> > +		 * Rounding the rate here avoids failure trying to set a new
> > +		 * rate on an already enabled wclk. In that instance this will
> > +		 * just set the same rate as is currently in use, and so should
> > +		 * continue without problem.
> > +		 */
> > +		sr =3D clk_round_rate(wclk, sr);
> >  		ret =3D clk_set_rate(wclk, sr);
> >  		if (ret) {
> >  			dev_err(component->dev,
>=20
> Don't we need to validate that the rounded rate is actually viable for
> the parameters we're trying to set here?  If there's missing constraints
> causing something to try to do something unsupportable then we should
> return an error rather than silently accept.

Thanks for directing my gaze to this again. Actually I don't think the SR s=
hould
be rounded at all. If it doesn't match exactly it should fail so I'll remov=
e the
rounding here. Not sure what my brain was doing there.

For the BCLK rate, I'll see what checking can be added there to make sure t=
he
word length is compatible with the 'rounded' BCLK rate.
