From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6] ASoC: add RT286 CODEC driver
Date: Fri, 18 Apr 2014 11:37:15 +0100
Message-ID: <20140418103715.GJ12304@sirena.org.uk>
References: <1397455170-2701-1-git-send-email-bardliao@realtek.com>
 <20140415120428.GU12304@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D73AC302@RTITMBSV03.realtek.com.tw>
 <20140416211145.GC12304@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D73AC511@RTITMBSV03.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7967889285939159058=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AC84A261689
 for <alsa-devel@alsa-project.org>; Fri, 18 Apr 2014 12:37:37 +0200 (CEST)
In-Reply-To: <ABFD875FF5FB574BA706497D987D48D73AC511@RTITMBSV03.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Gustaw Lewandowski <gustaw.lewandowski@intel.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============7967889285939159058==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HHGSYth2upt+0nQt"
Content-Disposition: inline


--HHGSYth2upt+0nQt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2014 at 05:39:08AM +0000, Bard Liao wrote:

> > You can implement non-register DAPM widgets - look at the virtual contr=
ols in the
> > core, or things using SND_SOC_NOPM.

> It means dapm widget will not control the codec directly, right?=20
> I.e. Everything will be done by _event?

The framework won't do anything directly, yes.

> For simplest the driver, can I not define .dapm_widgets and .dapm_routes?
> All controls will be done in .controls.

It is mandatory to have at least some DAPM support, not having DAPM was
such a constant source of bugs that we stopped supporting it.

--HHGSYth2upt+0nQt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTUQBYAAoJELSic+t+oim9jqwP/3qnrvxPiTxqpQdnjs6Yh+Ff
nyqbzetZK0vmI/C11LOnKmd38uHntWLqQdqGnK9ITYv/DVatMVpZjpgx+mv7EUFD
a4SKUgPHRESVFShHR+qrsGrvt/tiMMGXtCV7KDBVkLo2pf5SI93A+Dn+4CUxKp6F
mQ+2cuvAM0t64GxKjKEfSkVwX/RXjs/Mp8pK2xokIPi93XTF5/0oHi3bPDkrnGBJ
PcJ18wP38ju8/ilnNL/S286hxNG7PIhTBWtxTLL+j1g4FAD7piXI9yAhRoMz7nWu
uEPXKBv88nimXvD+OBYd8L9GkxBhSLFwNDX5vjI5dWIoHB+jTldlFvjYgEbOaEYx
FxNWaTDpvb4fFI+I/sxN299/CWjkYqZQrzyFlaNDc2AJk1hCcVwid9wsp/DXr/R4
nRoccZ46btry3CgeDX2rob/4+qs1fEfRzR4myc0uSkYXtW3G0P/tRA2CZG3GJuX9
/UQxWeDt5JQOCHsUHJEFvxyQbaCepKnonH4kJLlKC+OB+9pMmj2RitVZqJjEt0+B
lUkx02zmPuhQUH8JUwNbNm7AHhS5fTWiHrgQMEqddZliMPjZWsgeCXvIxFj05CkQ
ZCunq58CB7YeurLHx5/AUtwsh4bY2ExUVjH+qxD0+qamSNDH/sljm4w89DpJmJ+g
aEuz4DIxMj2Tpt3KZXGz
=Jeqe
-----END PGP SIGNATURE-----

--HHGSYth2upt+0nQt--

--===============7967889285939159058==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7967889285939159058==--
