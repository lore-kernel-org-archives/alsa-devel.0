From: Priit Laes <plaes-q/aMd4JkU83YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH v2 04/14] ASoC: sun4i-codec: Increase DMA
 max burst to 8
Date: Thu, 03 Nov 2016 10:42:59 +0200
Message-ID: <1478162579.8841.1.camel@plaes.org>
References: <20161103075556.29018-1-wens@csie.org>
	 <20161103075556.29018-5-wens@csie.org>
Reply-To: plaes-q/aMd4JkU83YtjvyW6yDsg@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDJLTBEBXENBBFPR5PAAKGQEBH6SWCY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20161103075556.29018-5-wens-jdAy2FN1RRM@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: wens-jdAy2FN1RRM@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 2016-11-03 at 15:55 +0800, Chen-Yu Tsai wrote:
> According to the DMA engine API documentation, maxburst denotes the
> largest possible size of a single transfer, so as not to overflow
> destination FIFOs as explained in this excerpt from dmaengine.h
>=20
> =C2=A0* @src_maxburst: the maximum number of words (note: words, as in
> =C2=A0* units of the src_addr_width member, not bytes) that can be sent
> =C2=A0* in one burst to the device. Typically something like half the
> =C2=A0* FIFO depth on I/O peripherals so you don't overflow it. This
> =C2=A0* may or may not be applicable on memory sources.
> =C2=A0* @dst_maxburst: same as src_maxburst but for destination target

> =C2=A0* mutatis mutandis.

^^ :)

>=20
> The TX FIFO is 64 samples deep for stereo, and the RX FIFO is 16
> samples deep. So maxburst could be 32 and 8 for TX and RX
> respectively.
>=20
> Unfortunately the sunxi DMA controller driver takes maxburst as
> the requested burst size, rather than a limit, and returns an error
> for unsupported values. The original value was 4, but some later
> SoCs do not officially support this burst size.
>=20
> This patch increases maxburst on the TX side to 8, which is supported
> by all variants of the sunxi DMA controller.
>=20
> Cc: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
> ---
> =C2=A0sound/soc/sunxi/sun4i-codec.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-
> codec.c
> index 61ae502a5061..d867b96d367b 100644
> --- a/sound/soc/sunxi/sun4i-codec.c
> +++ b/sound/soc/sunxi/sun4i-codec.c
> @@ -886,12 +886,12 @@ static int sun4i_codec_probe(struct
> platform_device *pdev)
> =C2=A0
> =C2=A0	/* DMA configuration for TX FIFO */
> =C2=A0	scodec->playback_dma_data.addr =3D res->start + quirks-
> >reg_dac_txdata;
> -	scodec->playback_dma_data.maxburst =3D 4;
> +	scodec->playback_dma_data.maxburst =3D 8;
> =C2=A0	scodec->playback_dma_data.addr_width =3D
> DMA_SLAVE_BUSWIDTH_2_BYTES;
> =C2=A0
> =C2=A0	/* DMA configuration for RX FIFO */
> =C2=A0	scodec->capture_dma_data.addr =3D res->start + quirks-
> >reg_adc_rxdata;
> -	scodec->capture_dma_data.maxburst =3D 4;
> +	scodec->capture_dma_data.maxburst =3D 8;
> =C2=A0	scodec->capture_dma_data.addr_width =3D
> DMA_SLAVE_BUSWIDTH_2_BYTES;
> =C2=A0
> =C2=A0	ret =3D snd_soc_register_codec(&pdev->dev, quirks->codec,
> --=C2=A0
> 2.10.2
>=20

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
