From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 2/2] ASoC: Intel: Skylake: Add DSP
 firmware manifest parsing
Date: Fri, 22 Apr 2016 08:43:51 +0530
Message-ID: <20160422031350.GQ2274@localhost>
References: <1461219323-1036-1-git-send-email-vinod.koul@intel.com>
 <1461219323-1036-3-git-send-email-vinod.koul@intel.com>
 <20160421160713.GV3217@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1349962558457883278=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id A17F62616C9
 for <alsa-devel@alsa-project.org>; Fri, 22 Apr 2016 05:09:10 +0200 (CEST)
In-Reply-To: <20160421160713.GV3217@sirena.org.uk>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, Shreyas NC <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============1349962558457883278==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="75WsOQSofUOhcSOp"
Content-Disposition: inline


--75WsOQSofUOhcSOp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 21, 2016 at 05:07:13PM +0100, Mark Brown wrote:
> On Thu, Apr 21, 2016 at 11:45:23AM +0530, Vinod Koul wrote:
>=20
> > +	num_entry =3D adsp_hdr->num_module_entries;
> > +
> > +	tbl =3D devm_kzalloc(ctx->dev,
> > +		num_entry * sizeof(struct uuid_tbl), GFP_KERNEL);
> > +
> > +	if (!tbl)
> > +		return -ENOMEM;
>=20
> I'm still not seeing any bounds checking to make sure we don't read
> beyond the end of the firmware file.

Since we are using  adsp_hdr->num_module_entrie for parsing technically we
should not go beyond.

But yes if the file goes bad then we might have an issue, we will add check
for that

Thanks
--=20
~Vinod

--75WsOQSofUOhcSOp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXGZbuAAoJEHwUBw8lI4NHNhUP+wceQtISz58olDcj3LHJUJy4
fgFtA3EtJTVF+eeorKtMbcYbzp02XprxsMK/nY+DkSqNQYTBtstvK75eYeDpq43j
6+TX6waHVNKmFjMVdKNA0CnBIMLbt+QomQZ9fWauxnjwDV6BRyQ6JadBzvstzjQs
5TzL9w0udPLZKFSkltn454Dy8iwJ9d53rR6jGFwu3xWtYw91Tk+olCpdrPODcbYc
AlHrEFTDNDkPufAtemMaRv/FhKriAGdhCB9aAPkBRJdk7QlYZIS+5aWHe7drEccq
vp5Ov31m/gPrzL2bBorR3+D+Xt+56vWdCVKxdJja69RZzwTtJwkC4QQ8216eS+CZ
z5hoGGbpezusWFN2tWf63TCD+CxYZj241wR0EUfVMoRTlLC9mD2p6FbemgvX4xcb
Hzc3i44DpzB5lQt+o8RyWdGo8uq7da3StVChgw01IzKMU2eol/wca2qOAF28TTOD
rLAniiPXFGIcNjGfPIQOPXjBVU/yaqVuUQtNlba3m7zUq8CYiKOf3IliICKS3ISX
ufLO3CKZjk8Jfw0MIs3cfjm5PHWVctGP0q68MK+XysIYkW5UN74jjJ5bzT3noBn+
S+uhcu4jFiFi8UhkYNH7u8t/ops1AIy2dxR8L8rRSY7Ik9U0kLrgf2EuWrXzr0+M
OZvL0TtIwmUJylcQvtok
=xcn/
-----END PGP SIGNATURE-----

--75WsOQSofUOhcSOp--

--===============1349962558457883278==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1349962558457883278==--
