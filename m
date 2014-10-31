From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 8/8] ASoC: rsnd: Add Volume Ramp support
Date: Fri, 31 Oct 2014 11:51:11 +0000
Message-ID: <20141031115111.GM18557@sirena.org.uk>
References: <8761fc7vpx.wl%kuninori.morimoto.gx@gmail.com>
 <87tx2w6h2r.wl%kuninori.morimoto.gx@gmail.com>
 <20141028223814.GM18557@sirena.org.uk>
 <87oasviuw0.wl%kuninori.morimoto.gx@gmail.com>
 <20141029225659.GS18557@sirena.org.uk>
 <87y4ryxuxs.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2765545775131223615=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 79209260597
 for <alsa-devel@alsa-project.org>; Fri, 31 Oct 2014 12:51:45 +0100 (CET)
In-Reply-To: <87y4ryxuxs.wl%kuninori.morimoto.gx@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============2765545775131223615==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WQ/nOZqcqYGY8uZi"
Content-Disposition: inline


--WQ/nOZqcqYGY8uZi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 29, 2014 at 05:28:19PM -0700, Kuninori Morimoto wrote:

> > >    000:  1 time
> > >    ...
> > >    031:  0.5 time
> > >    ...
> > >    3FE:  4.1 x 10^-7 time
> > >    3FF:  Mute

> > > Maybe I can used inverted value for it ?

> > That sounds like it'd address part of it, though I'm still not 100% sure
> > what the effect of this control is - is it the final value or something
> > (0.5*programmed volume for example)?

> In easy explain,
> we can set "Volume Ramp Period" (= it will be "time" instead),
> and "Volume scale". see below...

> /*
>  * target volume for "start" is Mute.
>  * volume X x 0 time = volume 0
>  */
> amixer set "DVC Out Ramp" 0%		// Mute as default

I'm sorry, this explanation still isn't at all clear to me.  Can you
explain it in words please?

--WQ/nOZqcqYGY8uZi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUU3euAAoJECTWi3JdVIfQrxwH/ixOxCZ8CarQ5LhVjJ6fKOwf
nU0DLY+TVxdxGa4r2r6XzaEU2ypFjlpgSFOBvvlAEeFw80MYGqeDhiuUd3v6Shtz
mHQ2QE09+Uct8EE/wse7CWv4HbB7lTjJ1p/OvFlEpmSzSWVrJysZ4FmhScGQUUqu
JZqQfpST1FyqbZmB7VsUIrRbprcbNGRWThfaoSWDjtHTS7W24oSUz07NCKUXJmHE
Ux+zgfJkliP+BOSGpybOh+AUg8d47Z06x98pMDtr/YONmmHHwF2oQk7zn5RrVCOp
qCSULLq2jwYDS4EUpTaCIzgfdoJj0IvyhuMp95nK9FjxRwLi594z/hN2ACpyTFA=
=yeMh
-----END PGP SIGNATURE-----

--WQ/nOZqcqYGY8uZi--

--===============2765545775131223615==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2765545775131223615==--
