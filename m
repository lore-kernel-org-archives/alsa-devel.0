From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 2/4] ASoC: core: Adds support for cpu
 loopback dai_link
Date: Tue, 1 Dec 2015 08:26:54 +0530
Message-ID: <20151201025654.GJ3901@localhost>
References: <1447091401-24298-1-git-send-email-vinod.koul@intel.com>
 <1447091401-24298-3-git-send-email-vinod.koul@intel.com>
 <20151118131757.GI31303@sirena.org.uk>
 <20151118134843.GU25173@localhost>
 <20151130162548.GZ1929@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1580063977389836776=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 041D32659CA
 for <alsa-devel@alsa-project.org>; Tue,  1 Dec 2015 03:55:04 +0100 (CET)
In-Reply-To: <20151130162548.GZ1929@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============1580063977389836776==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uh9ZiVrAOUUm9fzH"
Content-Disposition: inline


--uh9ZiVrAOUUm9fzH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 30, 2015 at 04:25:48PM +0000, Mark Brown wrote:
> On Wed, Nov 18, 2015 at 07:18:43PM +0530, Vinod Koul wrote:
> > On Wed, Nov 18, 2015 at 01:17:57PM +0000, Mark Brown wrote:
>=20
> > > So, what I was really thinking of with the renaming was a bigger rena=
me
> > > that updates the names in snd_soc_dai_driver and everything that comes
> > > from that.  That's a much bigger thing though, let me think about it a
> > > bit more.
>=20
> > ah, yes that kind of change does make sense, but as you observed that w=
ill
> > be a larger rework. And I think I am up for it in parallel to my SKL wo=
rk :)
>=20
> > But that will take a bit of time and I would like update these in bits
> > rather than one shot
>=20
> > Let me know what you think and how you would like to approach this
>=20
> Can we make the temporary hack be to check if there's a CODEC defined
> in the DAI?  It's nasty and fragile but it keeps the hack much better
> isolated.

The flag added here, cpu_loopback would do that and keep this isolated from
the rest. The problem with checking if codec is defined will be for dsp
based loops which terminate in codec. It will not work as we will find codec
in the dailink for the voice call (modem-dsp-codec) loop

Thanks
--=20
~Vinod

--uh9ZiVrAOUUm9fzH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWXQx2AAoJEHwUBw8lI4NHcYoQAKD/1dWzK2d8+OrdYZSrokAE
pXLpMouIIWPyDR14XXlnBRhNB45j8apWP3KqGVZT4Gcvs3wj+aiYPWrUsU9CBiJ1
U56+UVYwOHNjCxACO4KmKmq5cE4N+AG+h8xiJDGFaAmOsNHazZI4EyRssRO5z121
zalWrrQAHPjvMkiPG6OCUz0fjXtYecPCXU4vZrCK3R35FzrI+bV4xIx+3J9UmAaC
2S1ZazRZG0ejPFBb1OI4hdmwQF2JyWsVSSozKVcRXZbitNAVomjgq+KxA+0iSFZa
rSq2b2ChsRc6TSSP1A86m8Qw5Xw6dkY9OK6LbGa3nYDYolwo6Kqv45Xz4CcmxM7F
sER1zf/Dfx3HSOObhpCu4+Kp6ck25GaaO+JU/rf6gw7j5A4KWQnrllniDOZ7wLV4
mjWjnNAWqh3WpcB8u5vGTi60fwIbVOj48nvmfeP20DQFk9mR7vnreMSL/MXou/qU
Z8ErEJpJtbS+N8TBE9RRB73lCZq/NqDjVVCC62N1uJFnw0YXIxGnfB64evMiDQj1
g3ADt0ZbSL3jL1dma1brDRuPdAJ62I0M9Bv1M0Wsa69VOuwiy/PQTZ7myNvbsr2x
pGGMB7YKAbpk2R0ZjXaOXJSbfm0vQpfH+J/hrUJKofTvOK239FOxpwBaDR2Uhsvc
0v/1s0msTa0lAgjK2NE1
=5Mm3
-----END PGP SIGNATURE-----

--uh9ZiVrAOUUm9fzH--

--===============1580063977389836776==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1580063977389836776==--
