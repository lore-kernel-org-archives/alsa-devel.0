From: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Subject: Re: ASoC: Merging at91 and avr32 dirs - test report
Date: Mon, 13 Oct 2008 16:22:06 +0200
Message-ID: <48F3598E.3050404@atmel.com>
References: <B9D3C48C98930741A166756A50C44A610F17B561@helx1.corp.vaisala.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atmel-es2.atmel.fr (mail.atmel.fr [81.80.104.162])
	by alsa0.perex.cz (Postfix) with ESMTP id 8249D244E9
	for <alsa-devel@alsa-project.org>;
	Mon, 13 Oct 2008 16:23:02 +0200 (CEST)
In-Reply-To: <B9D3C48C98930741A166756A50C44A610F17B561@helx1.corp.vaisala.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext-jukka.hynninen@vaisala.com
Cc: alsa-devel@alsa-project.org, broonie@sirena.org.uk
List-Id: alsa-devel@alsa-project.org

Hi,

ext-jukka.hynninen@vaisala.com a =E9crit :
> I tested the patches and got everything working with minor changes.
> =

> However, there seems to be some problem with PM, occasionally ASoC is
> stuck with Standby mode (looking at dapm_widgets) when I start the
> playback. Restarting the player brings the sound back. I'll carry out
> some further investigation and get back to this.
Thank you for your help!

I've done more tests using the oss emulation in ALSA, and I have
encountered a problem.
In a previous mail Mark you mentioned this:
> +/*
> > + * Record SSC clock dividers for use in hw_params().
> > + */
> > +static int atmel_ssc_set_dai_clkdiv(struct snd_soc_dai *cpu_dai,
> > +	int div_id, int div)
> > +{
> > +	struct atmel_ssc_info *ssc_p =3D &ssc_info[cpu_dai->id];
> > +
> > +	switch (div_id) {
> > +	case AT91SSC_CMR_DIV:
> > +		/*
> > +		 * The same master clock divider is used for both
> > +		 * transmit and receive, so if a value has already
> > +		 * been set, it must match this value.
> > +		 */
> > +		if (ssc_p->cmr_div =3D=3D 0)
> > +			ssc_p->cmr_div =3D div;
> > +		else
> > +			if (div !=3D ssc_p->cmr_div)
> > +				return -EBUSY;
> > +		break;

What happens if the user wants to change the master clock divider at
runtime - for example, when changing sample rates?

I had actually a crash because of this, so I will send a patch to
correct it(I simply removed it since I don't thonk it is needed).


Regards,
Sedji
