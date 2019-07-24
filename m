From: mirq-linux@rere.qmqm.pl
Subject: Re: [PATCH 2/5] ASoC: atmel_ssc_dai: rework DAI format configuration
Date: Wed, 24 Jul 2019 13:15:33 +0200
Message-ID: <20190724111533.GA23736@qmqm.qmqm.pl>
References: <cover.1563819483.git.mirq-linux@rere.qmqm.pl>
 <ff244c1b626fc9c63b4a1fa4e09eeaa579e683d9.1563819483.git.mirq-linux@rere.qmqm.pl>
 <df304453-575f-5925-8d09-f6094c55f8be@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <df304453-575f-5925-8d09-f6094c55f8be@microchip.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Codrin.Ciubotariu@microchip.com
Cc: alsa-devel@alsa-project.org, alexandre.belloni@bootlin.com, lgirdwood@gmail.com, tiwai@suse.com, Ludovic.Desroches@microchip.com, broonie@kernel.org, perex@perex.cz, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 24, 2019 at 10:35:29AM +0000, Codrin.Ciubotariu@microchip.com w=
rote:
> On 22.07.2019 21:27, Micha=B3 Miros=B3aw wrote:
> > Rework DAI format calculation in preparation for adding more formats
> > later.
> > =

> > Note: this changes FSEDGE to POSITIVE for I2S CBM_CFS mode as the TXSYN
> > interrupt is not used anyway.
> > =

> > Signed-off-by: Micha=B3 Miros=B3aw <mirq-linux@rere.qmqm.pl>
> > ---
> >   sound/soc/atmel/atmel_ssc_dai.c | 283 +++++++++-----------------------
> >   1 file changed, 79 insertions(+), 204 deletions(-)
> > =

> > diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ss=
c_dai.c
> > index 6f89483ac88c..b2992496e52f 100644
> > --- a/sound/soc/atmel/atmel_ssc_dai.c
> > +++ b/sound/soc/atmel/atmel_ssc_dai.c
[...]
> > +	if (atmel_ssc_cbs(ssc_p)) {
> > +		/*
> > +		 * SSC provides BCLK
> > +		 *
> > +		 * The SSC transmit and receive clocks are generated from the
> > +		 * MCK divider, and the BCLK signal is output
> > +		 * on the SSC TK line.
> > +		 */
> > +		rcmr |=3D	  SSC_BF(RCMR_CKS, SSC_CKS_DIV)
> > +			| SSC_BF(RCMR_CKO, SSC_CKO_NONE);
> > +
> > +		tcmr |=3D	  SSC_BF(TCMR_CKS, SSC_CKS_DIV)
> > +			| SSC_BF(TCMR_CKO, SSC_CKO_CONTINUOUS);
> > +	} else {
> > +		rcmr |=3D	  SSC_BF(RCMR_CKS, ssc->clk_from_rk_pin ?
> > +					SSC_CKS_PIN : SSC_CKS_CLOCK)
> > +			| SSC_BF(RCMR_CKO, SSC_CKO_NONE);
> > +
> > +		tcmr |=3D	  SSC_BF(TCMR_CKS, ssc->clk_from_rk_pin ?
> > +					SSC_CKS_CLOCK : SSC_CKS_PIN)
> > +			| SSC_BF(TCMR_CKO, SSC_CKO_NONE);
> > +	}
> > +
> > +	rcmr |=3D	  SSC_BF(RCMR_PERIOD, rcmr_period)
> > +		| SSC_BF(RCMR_CKI, SSC_CKI_RISING);
> =

> You can also add here SSC_BF(RCMR_CKO, SSC_CKO_NONE) and remove it from =

> the if-else above;

I left it to keep symmetry between TX and RX code. I can pull it here if
you prefer that way.

> > +
> > +	tcmr |=3D   SSC_BF(TCMR_PERIOD, tcmr_period)
> > +		| SSC_BF(TCMR_CKI, SSC_CKI_FALLING);
> > +
> > +	rfmr =3D    SSC_BF(RFMR_FSLEN_EXT, fslen_ext)
> > +		| SSC_BF(RFMR_FSEDGE, SSC_FSEDGE_POSITIVE)
> > +		| SSC_BF(RFMR_FSOS, fs_osync)
> > +		| SSC_BF(RFMR_FSLEN, fslen)
> > +		| SSC_BF(RFMR_DATNB, (channels - 1))
> > +		| SSC_BIT(RFMR_MSBF)
> > +		| SSC_BF(RFMR_LOOP, 0)
> > +		| SSC_BF(RFMR_DATLEN, (bits - 1));
> > +
> > +	tfmr =3D    SSC_BF(TFMR_FSLEN_EXT, fslen_ext)
> > +		| SSC_BF(TFMR_FSEDGE, SSC_FSEDGE_POSITIVE)
> > +		| SSC_BF(TFMR_FSDEN, 0)
> > +		| SSC_BF(TFMR_FSOS, fs_osync)
> > +		| SSC_BF(TFMR_FSLEN, fslen)
> > +		| SSC_BF(TFMR_DATNB, (channels - 1))
> > +		| SSC_BIT(TFMR_MSBF)
> > +		| SSC_BF(TFMR_DATDEF, 0)
> > +		| SSC_BF(TFMR_DATLEN, (bits - 1));
> > +
> > +	if (fslen_ext && !ssc->pdata->has_fslen_ext) {
> > +		dev_err(dai->dev, "sample size %d is too large for SSC device\n",
> > +			bits);
> > +		return -EINVAL;
> > +	}
> > +
> >   	pr_debug("atmel_ssc_hw_params: "
> >   			"RCMR=3D%08x RFMR=3D%08x TCMR=3D%08x TFMR=3D%08x\n",
> >   			rcmr, rfmr, tcmr, tfmr);
> > =

> =

> You are adding support for SND_SOC_DAIFMT_DSP_A | =

> SND_SOC_DAIFMT_CBM_CFS. If this is intended, please make a separate =

> patch. If not, then:
> =

> printk(KERN_WARNING "atmel_ssc_dai: unsupported DAI format 0x%x\n",
> 			ssc_p->daifmt);
> return -EINVAL;

Hmm. I guess this is actually a good side effect. I can't see a way to
contain this change that doesn't involve adding code that's immediately
removed in next patch. So would you agree to just mentioning this in
commit message?

Best Regards,
Micha=B3 Miros=B3aw
