From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: fsl_ssi.c: Getting channel slips with fsl_ssi.c in
 TDM (network) mode.
Date: Tue, 27 Oct 2015 08:13:44 +0100
Message-ID: <20151027071344.GC25728@pengutronix.de>
References: <CAG5mAdxM_p2TWKhZne7AVGnhVfhVWA3gFe3pu6QQ8djb7TtjEA@mail.gmail.com>
 <5625EF02.30602@invoxia.com>
 <CAG5mAdw1Sj25hPWsFKqwQzgKft1_YWkN=7WNkW=kXGiF9P=kUA@mail.gmail.com>
 <56273F75.2040702@invoxia.com>
 <CAG5mAdxDmh3XDZSSHb8Oa7s-rosdVvTZPqu2zyDC42rMcqxxHA@mail.gmail.com>
 <CAG5mAdwC00qbu9zMHKjx5JZX_2CobBo81+jtpsWGPHPQ0jKX0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0576439623906227402=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.4.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id DEB3926040E
 for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2015 08:13:46 +0100 (CET)
In-Reply-To: <CAG5mAdwC00qbu9zMHKjx5JZX_2CobBo81+jtpsWGPHPQ0jKX0A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Caleb Crome <caleb@crome.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "arnaud.mouiche@invoxia.com" <arnaud.mouiche@invoxia.com>
List-Id: alsa-devel@alsa-project.org


--===============0576439623906227402==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bAmEntskrkuBymla"
Content-Disposition: inline


--bAmEntskrkuBymla
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 26, 2015 at 10:31:08AM -0700, Caleb Crome wrote:
> On Wed, Oct 21, 2015 at 12:37 PM, Caleb Crome <caleb@crome.org> wrote:
> > On Wed, Oct 21, 2015 at 12:32 AM, arnaud.mouiche@invoxia.com
> > <arnaud.mouiche@invoxia.com> wrote:
> >>
> >>
> >> Le 20/10/2015 19:43, Caleb Crome a =C3=A9crit :
> >>> Hi Arnaud,
> >>>    My root filesystem already had that firmware in it (the kernel
> >>> didn't have the kernel patch, but when I applied that patch, the
> >>> generated sdma script was identical.
> >>>
> >>> So, unfortunately, that's not the problem with the channel slipping.
> >>> Any other thoughts on why the channel would slip?  Or pointers on how
> >>> to diagnose?  I have an oscilloscope & know how to use it :-)  Also, I
> >>> can flip a GPIO to watch for timing of interrupts, etc (although I
> >>> haven't done that yet).
> >>>
> >>>
> >>> Thanks,
> >>>    -Caleb
> >>
> >>
> >> Hello Caleb,
> >>
> >> In your situation, I would:
> >> - check if TUE0/1 flag never rise (Transmitter Underrun) by activating=
 the
> >> TUE0/1IE bit to generate related interrupts. It looks like already ena=
bled
> >> in 4.0 by collecting statistics with fsl_ssi_dbg_isr(). Despite there =
is no
> >> printk message on underrun, stats can be read from
> >> /sys/kernel/debug/xxxx.ssi/stats.
> >
> > Heh, I checked that and I couldn't get the fsl_ssi_dbg_isr to trigger
> > ever, for any reason.  Somehow interrupts seem to be disabled in the
> > SSI driver, and I can't figure out how to enable them.  It appears
> > that the only interrupt required is the DMA interrupt, and SSI
> > interrupts are not checked.    The /sys/kernel/debug/xxxx.ssi/stats
> > file reads all zeros no matter what, even during playing, and even
> > after the user space detects underruns.
> >
> >>
> >> - I suspect the dma is not fast enough to fill the FIFO. may be you sh=
ould
> >> dig to check how SDMA priority are configured amongs the differents DMA
> >> channels.
> >> Not something I already look at before. A quick look suggest that
> >> DMA_PRIO_HIGH is _NOT_ configured by the fsl_ssi.c driver (wheras the
> >> imx-ssi.c did)
> >
> >
> > Ah ha!  Perhaps that's it.  I will check into that.  Maybe that's the
> > root cause.  Thanks so much.
>=20
> So, the dma priority doesn't seem to be the issue.  It's now set in
> the device tree, and strangely it's set to priority 0 (the highest)
> along with the UARTS.  priority 0 is just the highest in the device
> tree -- it gets remapped to priority 3 in the sdma driver.  the DT
> exposes only 3 levels of DMA priority, low, medium, and high.  I
> created a new level that maps to DMA priroity 7 (the highest in the
> hardware), but still got the problem.
>=20
> So, still something unknown causing dma to miss samples.  must be in
> the dma ISR I would assume.  I guess it's time to look into that.

Cc Nicolin, Fabio, Shawn

Perhaps you have an idea about this?

Regards,

Markus

>=20
> -Caleb
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--bAmEntskrkuBymla
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWLyQoAAoJEEpcgKtcEGQQG64QAK2Kpiw4sZRL80QoxNtJFTTc
zZXYLO+E+CRQJgGY12QLd6Z+TmePd/6CFWxx9thHYwdtlihjhHKoY4/P1hDcoyYt
t65zKTm+xhgzKOuA1oZ88L0RbVfG6i8hgajn48/5j9S0E4s8Sc0RVeO0WsI8ofZd
RVYXAZ/H6/aj6QBj7bq2dT9fK+9kHewnTAr3E4AOxyVJ1sC+e8Q+jYxbpZebmuf6
rdRppS5z4yZTsOYpNbrfl8WzShMu4dQFEODhEXiujiDDbWqHwDyTrnEG5gZfXXre
CS0cWX1c2eF2Q6NZcJFO9MV73KCNePkx664iTF3VkklkpmIxBXa582mi6uUV++IG
Ce343lwQVkbfDVsJKjRHrilc9lys1sLfBgti+ca4mY5lnYdglBHt8sLsDtknJzv+
yA3g94hmsnGTOpg9rgk37CV5uMwLcS0EMQwCSZL/ZMwDmm7CI+Z9qSCrkT5G/fbM
tJ/cCfhucfuNI9bcqIIH8NWoF2IRxwiLDND5C87pYzi9x5ZUFa3PObFfWGK5BKLb
q3cDyxNWiNZJr55vP3pzDaRaHtQhHAcUlc1TzxPB2jFGlVGmSR3e9osHVGgS62mU
wuNjB0ty+DkI5znpCNCfHcL/nhST+EPth3GozoKh6KbHIx+LVUn42b2a9xymdL9x
F4eyqK/ChKeS0oopiI+d
=9Bcg
-----END PGP SIGNATURE-----

--bAmEntskrkuBymla--

--===============0576439623906227402==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0576439623906227402==--
