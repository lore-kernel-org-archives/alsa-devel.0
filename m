From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH v2] ASoC: fsl: sai: Fix underrrun for playback stream start
Date: Mon, 11 Mar 2019 09:23:59 +0200
Message-ID: <CAEnQRZBpqgKAXBXrRQ9e-1Vj7hTZiqFbj1oghj9+pf0RKXN1EA@mail.gmail.com>
References: <20190308173904.27298-1-daniel.baluta@nxp.com> <20190308205805.GA8912@Asurada-Nvidia.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190308205805.GA8912@Asurada-Nvidia.nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>, "broonie@kernel.org" <broonie@kernel.org>, "festevam@gmail.com" <festevam@gmail.com>, "timur@kernel.org" <timur@kernel.org>, "tiwai@suse.com" <tiwai@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, "S.j. Wang" <shengjiu.wang@nxp.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 8, 2019 at 10:59 PM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> On Fri, Mar 08, 2019 at 05:39:30PM +0000, Daniel Baluta wrote:
>
> > @@ -542,6 +544,11 @@ static int fsl_sai_trigger(struct snd_pcm_substream *substream, int cmd,
> >       case SNDRV_PCM_TRIGGER_START:
> >       case SNDRV_PCM_TRIGGER_RESUME:
> >       case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> > +             for (i = 0; tx && i < channels; i++)
> > +                     regmap_write(sai->regmap, FSL_SAI_TDR, 0x0);
>
> Though it could reduce underrrun for sure, I don't feel it's a
> thorough fix, especially when dealing with a duplex case where
> RX is the first stream while the driver enables both TE and RE
> at the same time. So the transmitter might have started before
> TX DMA request gets enabled.

I see your point here. This is trickier than I expected.
>
> We actually have something similar in the ESAI driver as that
> one is well documented. But SAI is apparently more tricky at
> the trigger() function. And the paragraph you pasted from the
> RM doesn't explicitly sound like we should do this.
>
> Btw, Instead of writing dummy data, have you tried polling the
> WFP pointer of the TFR0 register to make sure data is copied
> by the DMA?

This is a good suggestion. Will give it a try.

>
> > +             if (tx)
> > +                     udelay(10);
>
> Any justification for the delay? Missing a line of comments? I
> guess it's to address the 3-bit clocks timing. However, putting
> it before enabling DMA request doesn't make much sense to me.

Indeed. Will come back with a better patch in v3.

thanks,
Daniel.
