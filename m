From: Mark Brown <broonie@kernel.org>
Subject: Re: ASoC: How to mix multi input ?
Date: Wed, 20 May 2015 19:13:06 +0100
Message-ID: <20150520181306.GP21577@sirena.org.uk>
References: <87pp5v3jz9.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4827120412323597070=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CE1E626547F
 for <alsa-devel@alsa-project.org>; Wed, 20 May 2015 20:13:11 +0200 (CEST)
In-Reply-To: <87pp5v3jz9.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4827120412323597070==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mejza3ZMMA5Za1mX"
Content-Disposition: inline


--mejza3ZMMA5Za1mX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2015 at 05:20:06AM +0000, Kuninori Morimoto wrote:

> I would like to ask you how to mix multi input in ASoC.
> Renesas sound device(s) can mix multi input to 1 output.

You mean in DPCM rather than a plain CODEC? =20

> Here, sound A/B/C will be used randomly.
> Does ALSA SoC already has this kind of system ?

I *think* at least the Intel systems do this already.

> My image about these are like this.

>  sound A: aplay -D hw:0 ...
>  sound B: aplay -D hw:1 ...
>  sound C: aplay -D hw:2 ...
>  ...

> codec will be started if one of A/B/C are started,
> and it will be stopped if all of A/B/C are stopped.

If you connect multiple front ends to one back end this should work
(with DAPM routes and so on).  If it doesn't work then that's something
that should work.

--mejza3ZMMA5Za1mX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVXM6xAAoJECTWi3JdVIfQZKoH/RiF8ok50v7P5BvZaCJbLETg
OQ5pqWQcO1+BbUswlg63/MbrjQbi0hZYoBdp+4ftACgDYnNug00oW7DGPneLmqAP
h8+eNI/Vg+yXqd+ObYDeeiHqKpKbkhbK7QEnwIva8/rSZ9Nl7He/LWtwjenkqtJb
l3M5qBQzqtpkZDT37Idt/x6Nt/heOE/2LIX/KwoAYyUj3cUM462hPod0I/FT3sZH
Qc+zliVVdvxaobffDvqSaB01irusvvelmvCRiiEjbise7QbGNHwIydmWd9V7wz4m
qARs9oCORIbvF1WFP6Sf2OFwjGzw6Momr6zzinZ9R1C4/BhzqWNjgU2eTm7HhP0=
=JmQO
-----END PGP SIGNATURE-----

--mejza3ZMMA5Za1mX--

--===============4827120412323597070==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4827120412323597070==--
