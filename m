From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: Add driver for CLPS711X DAI
	interface
Date: Fri, 28 Feb 2014 12:57:44 +0900
Message-ID: <20140228035744.GM9383@sirena.org.uk>
References: <1393430741-16272-1-git-send-email-shc_work@mail.ru>
 <1393430741-16272-2-git-send-email-shc_work@mail.ru>
 <20140227034430.GB9383@sirena.org.uk>
 <1393485447.431844445@f286.i.mail.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2207468952414369627=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A006264F53
 for <alsa-devel@alsa-project.org>; Fri, 28 Feb 2014 04:57:49 +0100 (CET)
In-Reply-To: <1393485447.431844445@f286.i.mail.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Olof Johansson <olof@lixom.net>
List-Id: alsa-devel@alsa-project.org


--===============2207468952414369627==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xrRZJmfMt0dTT4Ad"
Content-Disposition: inline


--xrRZJmfMt0dTT4Ad
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2014 at 11:17:27AM +0400, Alexander Shiyan wrote:
> =D0=A7=D0=B5=D1=82=D0=B2=D0=B5=D1=80=D0=B3, 27 =D1=84=D0=B5=D0=B2=D1=80=
=D0=B0=D0=BB=D1=8F 2014, 12:44 +09:00 =D0=BE=D1=82 Mark Brown <broonie@kern=
el.org>:

> > I'm wondering if the FIQ code can be shared with the i.MX FIQ code?  Not
> > something that should block merging but it seems like it might be
> > helpful for other platforms that need to use FIQ support.

> This FIQ implementation and i.MX FIQ is totally different.
> I am fully confident that we can not use any common features/calls.

The timer stuff looked a bit familiar...

> > > +#if defined(CONFIG_SND_CLPS711X_SOC_MODULE)
> > > +irqreturn_t no_action(int irq, void *dev_id)
> > > +{
> > > +	return IRQ_NONE;
> > > +}
> > > +#endif

> > Eh?  Waht's this about?

> In case using this driver as non-module, "no_action" handler is used
> from kernel/irq/handle.c, but since it is not exported it cannot be used
> in module case.
> I'll remade this to use own empty handler always.

Please don't do this, fix the problem properly (for example by exporting
it if that's the sensible thing to do).

--xrRZJmfMt0dTT4Ad
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTEAk0AAoJELSic+t+oim9cbEP/RIJbZP6u/YCc+rb8aD5ytbJ
EszJR/NEBfQApT08SHlNiIKUa6Bj50DLk8UZYwymtLW0OqVeu66+Hf5VkoQxFe3I
tNlpmOlLGTvGaGmIQU27eh5vZMtcZWyaW1kV7qFfyowMlRsndthHi3hlWcoDfPs2
yIyuYeqTJtIr01L4rrcVncPz5WlZG2NzVQsJIV6uG2sKRfFRg1CUMNXgFIJneZaI
8TW5J6eZmG8Cr/S8RoCWZl3t06G/mPbtAnnFTarmJBc4jJPTM0R+xdYJfgV9qMyi
TrOd07yp6WI/zYkI0pGZu3PIFkFyPrhN9HcjL2f1ZsDtEL/ylYAf+OOIx/PM9dV9
WV6jCOx7ElpeIb0Tcht8kNHAE0cT++MvCzlCW6CVEFD3xV74moY304b8svPbG2Jl
0v99hfdxWmMH9zl41Q0AK/5zO2U9XvPK7B5EVe1HcYU7W6rmCMwqfuulwT/6AV5V
Fk27El/Ew9dG4Jt1UfL25zXKcaAwBbdu4PXetuRAaaJI0UBnZAsUvjEFLu6Xutrx
txtCRN1S8PHc/Y9R6Hao6ochbMe9DvvcJrW6Bot/+LgeRgCGiN3sAZtI0qq6/gbk
GsbB9uhmQhiclnUtblUCSNnoKqsW1bsNU+q0rA9SDGOZxpCGVXxvEP9s6irQcyno
mV0TmcxBkn+JuZu6MYm9
=a0n1
-----END PGP SIGNATURE-----

--xrRZJmfMt0dTT4Ad--

--===============2207468952414369627==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2207468952414369627==--
