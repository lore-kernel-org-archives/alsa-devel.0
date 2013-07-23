From: Mark Brown <broonie@kernel.org>
Subject: Re: Ambiguous DAPM widget names and DPCM
Date: Tue, 23 Jul 2013 13:30:17 +0100
Message-ID: <20130723123017.GV9858@sirena.org.uk>
References: <51EE3F18.3030207@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1273881123248125988=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id EAD36262626
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2013 14:30:25 +0200 (CEST)
In-Reply-To: <51EE3F18.3030207@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: ALSA development <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1273881123248125988==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iO5NTrAl+y2STuOh"
Content-Disposition: inline


--iO5NTrAl+y2STuOh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 23, 2013 at 10:30:16AM +0200, Daniel Mack wrote:

> DPCM uses DAPM widgets and routes in order to determine the FE <-> BE
> connections at runtime. The problem with this is that widget names are
> very ambiguous, as the automatically created widgets for DAIs are named
> after their stream_name properties, which contain "Playback" or
> "Capture" for all components in my case. Hence, the code which walks the

Could you go into more detail about the ambiguity you see here?

> I hacked the names of all components so they are unique, but even then,

This is obviously required, yes - just as with everything else you
shouldn't use the same name twice.

> the problem is that snd_soc_dapm_new_dai_widgets() is called twice for
> the CPU DAI, once from soc_probe_platform(), and later from
> soc_probe_link_dais(), and both calls would create DAPM widgets with
> identical names, resulting in the same problem as described above.

The theory here is that the CPUs should be converted into components and
then have the DAIs instantiated at component probe time - the creation
at link time is there as a crutch for older drivers.

> I don't know how to handle this, but I believe that nobody was really
> hit by this issue yet, as DPCM doesn't seem to be used widely, at least
> not by any machine code in mainline.

Yes, there's zero use in mainline.  I don't think this code has ever
been tested.

--iO5NTrAl+y2STuOh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR7ndWAAoJELSic+t+oim9R94P/1g9SS8CnPurpN1C2UYpGveU
Io/U/iGNOW4B2TyDKjdakpxnVmtqFjXI9zG+pSuC20W04cJeSKDaR1g90bPlPV8B
urX2Gd0Qu4VF5sYxmO/wIpOvmMOqVZAfr32e+23Yoh5V0AHUhCNMT7S4P7hh0WV3
Gsjck6/E7CgMl917h696qb/Mcbe+kTX2mgNHjoDVV9Q95nNiJoBvVnfMN2Yrjwat
xo9St2lLLjABYaENuOPDnrTdwd9yUv7gDlsPP5JHJnfpJDNGo7UdaL0Pd6Hq8kKE
mGI+fGy52dbm9qjWc6sdalW5lSVr6iWEkjRlOdcy9zYNjcWQ/vlvCNIni6WT7kWo
kpNxTdu+MVXprIqp7uskOuVh1+7wgyOFcYXTEpPD7kUzmCdJRqukCqFOtY+cSg+Y
6o2PLT6WKFmkEhjdBIFm7xftANvqLQ6H+VEsUU40poCy4Ja7CZDvhGr0zQeco32c
hIJADk3eVDAUf85vmYGmcWDg5aVI5PmfoivBpcTLjsz6qTglUIjrT+HtFiI8JIZH
Bv46jV+cdBv9g95k4VpDrp/vlo6QlP3tB4qV+B0lUTClGHf133Qj0VFfJAmz92LH
pn9XnNuW8k9DjMyZ0s2pkPVL0HlOabsl8mxHS6l/jI8btaysTmoDRMyla4USl+rv
NJitMxkEFq/mUJaEsBHV
=ivvt
-----END PGP SIGNATURE-----

--iO5NTrAl+y2STuOh--

--===============1273881123248125988==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1273881123248125988==--
