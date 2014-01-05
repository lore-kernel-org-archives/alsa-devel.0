From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: Question on compress offload framework memory
 corruption
Date: Sun, 5 Jan 2014 19:34:38 +0530
Message-ID: <20140105140438.GX16227@intel.com>
References: <63ac7c9c1f4ac8d8ef0ed9587fd1cf5f.squirrel@www.codeaurora.org>
 <20131219105508.GV31886@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1814629305303530528=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id DAFFA2608B8
 for <alsa-devel@alsa-project.org>; Sun,  5 Jan 2014 16:05:32 +0100 (CET)
In-Reply-To: <20131219105508.GV31886@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, gsantosh@codeaurora.org
List-Id: alsa-devel@alsa-project.org


--===============1814629305303530528==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2013 at 10:55:08AM +0000, Mark Brown wrote:
> On Wed, Dec 18, 2013 at 01:17:51PM -0000, gsantosh@codeaurora.org wrote:
> > Hi,
> >=20
> > I have following questions in the compressed offload framework API.
> >=20
> > static int soc_compr_set_params_fe(struct snd_compr_stream *cstream,
> > 					struct snd_compr_params *params)
> > {
> > ...
> > 	hw_params =3D kzalloc(sizeof(*hw_params), GFP_KERNEL);
> > 	if (hw_params =3D=3D NULL)
> > 		return -ENOMEM;
> > /*1st question is, what is the use of above allocated memory I do not s=
ee
> > this being used in this function*/
>=20
> The code you're quoting there isn't in mainline.  I've also added Vinod
> to the CCs, you probably want to include him in any discussion of the
> compressed API.
That's right, this is from DPCM compressed updated done by Liam, so he is t=
he
best person to comment on this bit, and somehow his address in CC has gone =
bad,
i have added him in to list

But yes looking at the source, i agree that two are interlinked.
I guess we need to poupulate the hw_params and then use that to copy, that =
would
be the right thing to do here and yes this is not correct and not sure how =
this
is working...

--=20
~Vinod

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJSyWZ2AAoJEHwUBw8lI4NHFfkP/1ljXZtVTnVvMlEnEg5mJcqw
bPwMTiXNK/57yNvzxgWnyu58q/GaMUZcnMgORzCL4pTYHN7cC9QsZQOu8SMXEYgy
V2H5lM6g6IDpAymgiKWiD4T4VF6wFBhtj8WWHaEXXGPG5PQX3Wfj+x4MJfEzA4kT
wk9johHbc2GaLK/yOph14HMKLdimux6p7twxSUJclHcvqQ4lLPplLlK7+YtDsdBt
im+iXWCp2LnAeRQ6bBL5NBzeYsJimi7bxYmRBGeocXGxqT4sjngTR4g7HIQebNR2
Rjt8DsntzWI1bzDtkROcT6+p/oqnjRON4Iz1/gbx47bOK2WRm7ZSsqg2i01EaSyI
gQ0KHFE/tgOt2yrk2ayymAFei+3luStpKyZNwrUXFYf5Fg1DDNv6OdOsOBWc9FiH
gJ0+d0MlNVWINUo7b8sEnMGyhycACkH0J6JZk0a+BePA2bDY+bF6P8D8KJUDLgMj
2IxTihdDdy1t/hdQoQnevW7DQQlTGJ3E326S6+Jil0zey+Yh/D9+jYrzxKx2ornv
trwJvsxPUB7sKOSpmQXaXEv2LKkmjhWd+K/tvawWeiv9+DK+VJArwL72LUS3KlnX
/0M5N123t21WDffyJOwenhcK+VrQNSdgqa12tUaZIj/G1mJ2qaGEU8dM6svcB+2C
96YQ4nhsCQGA0s/F5h7b
=YZSm
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--

--===============1814629305303530528==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1814629305303530528==--
