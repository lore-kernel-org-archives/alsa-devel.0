From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [alsa-devel] [PATCH 1/3] ASoC: ux500_pcm: Stop pretending that
 we support varying address widths
Date: Tue, 3 Dec 2013 08:31:16 +0000
Message-ID: <20131203083116.GA11828@lee--X1>
References: <1386007222-10081-1-git-send-email-lee.jones@linaro.org>
 <529CD2B5.9060905@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <529CD2B5.9060905@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linus.walleij@linaro.org, broonie@kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 02 Dec 2013, Lars-Peter Clausen wrote:

> On 12/02/2013 07:00 PM, Lee Jones wrote:
> > The Slave Config's addr_width attribute is populated by data_width =
of
> > dma_cfg, which in turn is derived from dma_params' data_size attrib=
ute
> > and that comes from the slot_width which is always 16 bits (2 Bytes=
).
> > We're cutting out the middle man here and just setting the DMA Slav=
e
> > Config directly.
> >=20
> > Cc: alsa-devel@alsa-project.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
>=20
> Patch looks good. But as a follow up patch I think you can now switch=
 to the
> generic snd_dmaengine_pcm_prepare_slave_config.

No, I don't think we can. Your version only populates the DMA settings
for the correct stream (Playback OR Capture), but our DMA Controller
requires both source and destination to be setup.

> > ---
> >  sound/soc/ux500/ux500_pcm.c | 13 ++++++-------
> >  1 file changed, 6 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/sound/soc/ux500/ux500_pcm.c b/sound/soc/ux500/ux500_pc=
m.c
> > index 6162f70..2f1bdb7 100644
> > --- a/sound/soc/ux500/ux500_pcm.c
> > +++ b/sound/soc/ux500/ux500_pcm.c
> > @@ -104,26 +104,25 @@ static int ux500_pcm_prepare_slave_config(str=
uct snd_pcm_substream *substream,
> >  		struct dma_slave_config *slave_config)
> >  {
> >  	struct snd_soc_pcm_runtime *rtd =3D substream->private_data;
> > -	struct ux500_msp_dma_params *dma_params;
> > -	struct stedma40_chan_cfg *dma_cfg;
> > +	struct snd_dmaengine_dai_dma_data *dma_params;
> >  	int ret;
> > =20
> >  	dma_params =3D snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
> > -	dma_cfg =3D dma_params->dma_cfg;
> > =20
> >  	ret =3D snd_hwparams_to_dma_slave_config(substream, params, slave=
_config);
> >  	if (ret)
> >  		return ret;
> > =20
> >  	slave_config->dst_maxburst =3D 4;
> > -	slave_config->dst_addr_width =3D dma_cfg->dst_info.data_width;
> >  	slave_config->src_maxburst =3D 4;
> > -	slave_config->src_addr_width =3D dma_cfg->src_info.data_width;
> > +
> > +	slave_config->src_addr_width =3D DMA_SLAVE_BUSWIDTH_2_BYTES;
> > +	slave_config->dst_addr_width =3D DMA_SLAVE_BUSWIDTH_2_BYTES;
> > =20
> >  	if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK)
> > -		slave_config->dst_addr =3D dma_params->tx_rx_addr;
> > +		slave_config->dst_addr =3D dma_params->addr;
> >  	else
> > -		slave_config->src_addr =3D dma_params->tx_rx_addr;
> > +		slave_config->src_addr =3D dma_params->addr;
> > =20
> >  	return 0;
> >  }
> >=20
>=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
