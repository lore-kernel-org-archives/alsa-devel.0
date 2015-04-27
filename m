From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v9 5/7] ASoC: jack: create kctls according
 to jack pins info
Date: Mon, 27 Apr 2015 20:33:01 +0100
Message-ID: <20150427193301.GY22845@sirena.org.uk>
References: <1429756366-22520-1-git-send-email-yang.jie@intel.com>
 <1429756366-22520-6-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2571190103193281671=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E802326041C
 for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2015 21:33:09 +0200 (CEST)
In-Reply-To: <1429756366-22520-6-git-send-email-yang.jie@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jie Yang <yang.jie@intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, tanu.kaskinen@linux.intel.com, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============2571190103193281671==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5+qsj7yWT80VfEG5"
Content-Disposition: inline


--5+qsj7yWT80VfEG5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2015 at 10:32:44AM +0800, Jie Yang wrote:
> In the new jack kctls design, we can create kctls according to
> pins info:
>=20
> 1. during jack creating, snd_jack_new() with NULL jack_kctl;
> 2. for each pin, call snd_jack_add_kctl() to add one kctl
> (it will call snd_ctl_add() to add kctl to card);

Acked-by: Mark Brown <broonie@kernel.org>

--5+qsj7yWT80VfEG5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVPo7sAAoJECTWi3JdVIfQYcsH/0aVC8YUsSEa/+8adMLEHyIY
stcD60Djmedm63mItH91WkAy1QALQL7jfVnj4mpxAxYJOOYJtFZGWa1dPpLGQi8j
Gd0mWKiW+57osm8tDsUp+IokhxXHGCGxrYIVT78JgsyxIiR9wFtAC86DGq1H/unc
2COiK5JkWAddQrk6HqdOwVBiVg/8CN4qM4fjv6NCRcIiX+gvQh8DuJmRxNjCXthB
yL0R659cyii5tFRgYln6z4BWS+axIna/dmcKWsER9hebBCMxDMuIifYulFQw8sDR
iY0/aq414MVbBkjhKtkYJ2t6IiALC9FjA5fltj+XSUVxODnmO3o9IIY+X+qkW/A=
=fpvX
-----END PGP SIGNATURE-----

--5+qsj7yWT80VfEG5--

--===============2571190103193281671==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2571190103193281671==--
