From: Daniel Mack <daniel@caiaq.de>
Subject: Re: snd-soc-pxa-ssp I2C/FIFO issues
Date: Wed, 11 Mar 2009 19:21:49 +0100
Message-ID: <20090311182149.GD29871@buzzloop.caiaq.de>
References: <74d0deb30903090747p3fbb8dd5l27cd7313d4be7de2@mail.gmail.com>
	<20090309153629.GB24787@buzzloop.caiaq.de>
	<20090309174443.GG13593@sirena.org.uk>
	<20090310154741.GC10574@buzzloop.caiaq.de>
	<74d0deb30903111110h4e441959yec421225a4b90cc9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 2E41E10387E
	for <alsa-devel@alsa-project.org>; Wed, 11 Mar 2009 19:21:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <74d0deb30903111110h4e441959yec421225a4b90cc9@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pHilipp Zabel <philipp.zabel@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 11, 2009 at 07:10:28PM +0100, pHilipp Zabel wrote:
> > Philipp, could you test that again on your board, please?
> > Applies on top of the other one ("pxa-ssp: don't touch ssp registers
> > ...") I just posted.
> =

> Tested-by me. Of course this still doesn't help me to enable 16-bit
> DMA transfers for stereo, but it doesn't hurt either.

Ok, but good to know this does not break your config.

> > =A0struct ssp_priv {
> > =A0 =A0 =A0 =A0struct ssp_dev dev;
> > =A0 =A0 =A0 =A0unsigned int sysclk;
> > + =A0 =A0 =A0 unsigned int scr_div;
> =

> Really needed? Or could we just check SSCR0 below?

Well, SSCR0_SerClkDiv() is defined as follows:

#define SSCR0_SCR       (0x000fff00)    /* Serial Clock Rate (mask) */
#define SSCR0_SerClkDiv(x) (((x) - 1) << 8) /* Divisor [1..4096] */

I thought about adding a reverse macro just for that case, but that
seemed a lot more intrusive.

> > =A0 =A0 =A0 =A0switch (priv->dai_fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> > =A0 =A0 =A0 =A0case SND_SOC_DAIFMT_I2S:
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Cleared when the DAI format is set */
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 sspsp =3D ssp_read_reg(ssp, SSPSP) | SSPS=
P_SFRMWDTH(width);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sspsp =3D ssp_read_reg(ssp, SSPSP);
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((priv->scr_div =3D=3D 4) && (width =
=3D=3D 16)) {
> =

> sscr0 & SSCR0_SCR =3D=3D SSCR0_SerClkDiv(4) instead?

Yes, could do that, but I doubt it is more readable? But we would save
one entry in the priv struct, so I'll do it.

> > - =A0 =A0 =A0 /* We always use a network mode so we always require TDM =
slots
> > - =A0 =A0 =A0 =A0* - complain loudly and fail if they've not been set u=
p yet.
> > - =A0 =A0 =A0 =A0*/
> > - =A0 =A0 =A0 if (!(ssp_read_reg(ssp, SSTSA) & 0xf)) {
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&ssp->pdev->dev, "No TDM timeslot=
 configured\n");
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> > - =A0 =A0 =A0 }
> > -
> =

> I wonder if this check was useful in some case? If so, we could
> replace it with something like this:

Yep, we didn't kill the network mode entirely, you're right. Will fix
this in a follow-up.

Thanks,
Daniel
