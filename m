From: "Mani, Arun" <avm-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH] To avoid the divide by zero error during the first
	execution, initialize the data type.
Date: Wed, 9 Sep 2009 16:07:44 -0500
Message-ID: <7A436F7769CA33409C6B44B358BFFF0C0129E88EA5@dlee02.ent.ti.com>
References: <4AA8144A.10105@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <4AA8144A.10105-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Troy Kisky <troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
Cc: "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Arun Mani <a0270733-v6bHNwHyLPpLr9zQScikeQC/G2K4zDHf@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

It indeed gets initialized in the hw_params. But the runtime dma parameters=
 are not populated with the substream private data information that is gets=
 in hw_params for the first time. I am not sure why. Any ideas?



Thanks,
Arun.

> -----Original Message-----
> From: Troy Kisky [mailto:troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org]
> Sent: Wednesday, September 09, 2009 4:47 PM
> To: Mani, Arun
> Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org; alsa-devel@alsa-
> project.org; Arun Mani
> Subject: Re: [PATCH] To avoid the divide by zero error during the first
> execution, initialize the data type.
>=20
> avm-l0cyMroinI0@public.gmane.org wrote:
> > From: Arun Mani <a0270733-xHf0xn1KbjXtkKqbFX7TNUJdNcTp/5TL0E9HWUfgJXw@public.gmane.org>
> >
> > Signed-off-by: Arun Mani <a0270733-xHf0xn1KbjXtkKqbFX7TNUJdNcTp/5TL0E9HWUfgJXw@public.gmane.org>
> > ---
> >  sound/soc/davinci/davinci-i2s.c |    2 ++
> >  1 files changed, 2 insertions(+), 0 deletions(-)
> >
> > diff --git a/sound/soc/davinci/davinci-i2s.c
> b/sound/soc/davinci/davinci-i2s.c
> > index b1ea52f..61b1763 100644
> > --- a/sound/soc/davinci/davinci-i2s.c
> > +++ b/sound/soc/davinci/davinci-i2s.c
> > @@ -104,10 +104,12 @@ enum {
> >
> >  static struct davinci_pcm_dma_params davinci_i2s_pcm_out =3D {
> >  	.name =3D "I2S PCM Stereo out",
> > +	.data_type =3D 2, //Initialize the data type for playback to avoid
> divide by zero
>=20
> You should have ".acnt =3D 2" also for consistency.
> >  };
> >
> >  static struct davinci_pcm_dma_params davinci_i2s_pcm_in =3D {
> >  	.name =3D "I2S PCM Stereo in",
> > +	.data_type =3D 2, //Initialize the data type for playback to avoid
> divide by zero
> >  };
> >
> >  struct davinci_mcbsp_dev {
>=20
> And if the 1st stream is an 8-bit audio stream, will it initialize it
> incorrectly ???
> Of course, we have formats =3D SNDRV_PCM_FMTBIT_S16_LE, currently so it's
> not an issue yet...
>=20
> I don't see how data_type is not being set in davinci_i2s_hw_params
> before being used in davinci_pcm_prepare.
>=20
> Can prepare be called before hw_params ?
>=20
> There is a "return -EINVAL" in davinci_i2s_hw_params with a
> "printk(KERN_WARNING "davinci-i2s: unsupported PCM format\n")" before it.
>=20
> Do you see this message in your log ?
>=20
>=20
> Thanks
> Troy
>=20
