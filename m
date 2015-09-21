From: Jon Cormier <jcormier@criticallink.com>
Subject: Re: [PATCH RFC 6/7] ASoC: tlv320aic26: Add support for DSP_B data format
Date: Mon, 21 Sep 2015 09:05:57 -0400
Message-ID: <CADL8D3bE5sBCX=f7LPOKBTBLJCZe0sUbRrQV1XBD_PpdW+7cLg@mail.gmail.com>
References: <1442607076-26681-1-git-send-email-jcormier@criticallink.com>
 <1442607076-26681-7-git-send-email-jcormier@criticallink.com> <55FFA16B.8060105@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55FFA16B.8060105@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Bob Duke <bduke@criticallink.com>, Mike Williamson <michael.williamson@criticallink.com>, Mark Brown <broonie@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Jyri Sarha <jsarha@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Greg Gluszek <greg.gluszek@criticallink.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 21, 2015 at 2:19 AM, Peter Ujfalusi <peter.ujfalusi@ti.com>=
 wrote:
>
> On 09/18/2015 11:11 PM, Cormier, Jonathan wrote:
> > Signed-off-by: Cormier, Jonathan <jcormier@criticallink.com>
> > ---
> >  sound/soc/codecs/tlv320aic26.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/sound/soc/codecs/tlv320aic26.c b/sound/soc/codecs/tlv3=
20aic26.c
> > index c3b0a698ea66..5c5641cd28de 100644
> > --- a/sound/soc/codecs/tlv320aic26.c
> > +++ b/sound/soc/codecs/tlv320aic26.c
> > @@ -211,6 +211,7 @@ static int aic26_set_fmt(struct snd_soc_dai *co=
dec_dai, unsigned int fmt)
> >       switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> >       case SND_SOC_DAIFMT_I2S:     aic26->datfm =3D AIC26_DATFM_I2S=
; break;
> >       case SND_SOC_DAIFMT_DSP_A:   aic26->datfm =3D AIC26_DATFM_DSP=
; break;
> > +     case SND_SOC_DAIFMT_DSP_B:   aic26->datfm =3D AIC26_DATFM_DSP=
; break;
>
> Are you sure about this? According to the datasheet:
> www.ti.com/litv/slas412 page 18 there is no bit to change the data de=
lay and
> the format the codec supports is DSP_A.
I went with DSP_B because thats what the 335x EVM had set and when
comparing the tlv320aic26 datasheet to the tlv320aic32 for the DSP
mode it seemed to match. I had been getting garbled audio playback
when I tested with DSP_A but I just retested to be sure and now DSP_A
appears to work just the same as DSP_B.  So I suggest we drop this
patch.
>
> >       case SND_SOC_DAIFMT_RIGHT_J: aic26->datfm =3D AIC26_DATFM_RIG=
HTJ; break;
> >       case SND_SOC_DAIFMT_LEFT_J:  aic26->datfm =3D AIC26_DATFM_LEF=
TJ; break;
> >       default:
> >
>
>
> --
> P=C3=A9ter


--=20
Jonathan Cormier
CriticalLink
