From: mirq-linux@rere.qmqm.pl
Subject: Re: [PATCH 5/5] ASoC: atmel_ssc_dai: Enable shared FSYNC source in
 frame-slave mode
Date: Thu, 25 Jul 2019 20:24:27 +0200
Message-ID: <20190725182427.GA16245@qmqm.qmqm.pl>
References: <cover.1563819483.git.mirq-linux@rere.qmqm.pl>
 <107e0cfd11a31ce1558e941612e183100022930d.1563819483.git.mirq-linux@rere.qmqm.pl>
 <eabb96e7-1567-3ee1-a00e-f241c5f23c1c@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <eabb96e7-1567-3ee1-a00e-f241c5f23c1c@microchip.com>
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
Cc: alsa-devel@alsa-project.org, alexandre.belloni@bootlin.com, tiwai@suse.com, lgirdwood@gmail.com, Ludovic.Desroches@microchip.com, broonie@kernel.org, perex@perex.cz, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 25, 2019 at 03:02:34PM +0000, Codrin.Ciubotariu@microchip.com w=
rote:
> On 22.07.2019 21:27, Micha=B3 Miros=B3aw wrote:
> > SSC driver allows only synchronous TX and RX. In slave mode for BCLK
> > it uses only one of TK or RK pin, but for LRCLK it configured separate
> > inputs from TF and RF pins. Allow configuration with common FS signal.
[...]
> > @@ -613,10 +607,30 @@ static int atmel_ssc_hw_params(struct snd_pcm_sub=
stream *substream,
> >   		return -EINVAL;
> >   	}
> >   =

> > -	if (!atmel_ssc_cfs(ssc_p)) {
> > +	if (atmel_ssc_cfs(ssc_p)) {
> > +		/*
> > +		 * SSC provides LRCLK
> > +		 *
> > +		 * Both TF and RF are generated, so use them directly.
> > +		 */
> > +		rcmr |=3D	  SSC_BF(RCMR_START, fs_edge);
> > +		tcmr |=3D	  SSC_BF(TCMR_START, fs_edge);
> > +	} else {
> >   		fslen =3D fslen_ext =3D 0;
> >   		rcmr_period =3D tcmr_period =3D 0;
> >   		fs_osync =3D SSC_FSOS_NONE;
> > +		if (!ssc->shared_fs_pin) {
> > +			rcmr |=3D	  SSC_BF(RCMR_START, fs_edge);
> > +			tcmr |=3D	  SSC_BF(TCMR_START, fs_edge);
> > +		} else if (ssc->clk_from_rk_pin) {
> > +			/* assume RF is to be used when RK is used as BCLK input */
> > +			/* Note: won't work correctly on SAMA5D2 due to errata */
> > +			rcmr |=3D	  SSC_BF(RCMR_START, fs_edge);
> > +			tcmr |=3D	  SSC_BF(TCMR_START, SSC_START_RECEIVE);
> =

> Did you find a platform in which this mode works?

To be exact: according to the errata, TX is delayed improperly. So if you
use only RX (SSC side receives) direction, you're fine.

Best Regards,
Micha=B3=A0Miros=B3aw
