From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/2] ASoC: kirkwood: fix loss of
 external clock at probe time
Date: Sat, 21 Sep 2013 14:36:46 +0100
Message-ID: <20130921133646.GV21013@sirena.org.uk>
References: <20130921120036.5730dbfd@armhf>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7680082802425081426=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id DEC3E261703
 for <alsa-devel@alsa-project.org>; Sat, 21 Sep 2013 15:37:02 +0200 (CEST)
In-Reply-To: <20130921120036.5730dbfd@armhf>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Mike Turquette <mturquette@linaro.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@linaro.org>, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============7680082802425081426==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uTOHp36N6S0WjZTp"
Content-Disposition: inline


--uTOHp36N6S0WjZTp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 21, 2013 at 12:00:36PM +0200, Jean-Francois Moine wrote:
> At probe time, when the clock driver is not yet initialized, the
> external clock of the kirkwood sound device will not be usable.
>=20
> This patch fixes this problem defering the device probe.

Applied, thanks.  It won't do anything without a version of patch 1 but
there's no build time dependency and it seems like we should get a fix
into the core for the unspecified vs unregistered problem.

--uTOHp36N6S0WjZTp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSPaDrAAoJELSic+t+oim9tGcP/AsPpe1cppna27H3RIMv1IWR
cw0Z5hunWgENC9JfKPFsi1Oc16Ln57ZQ8gPYad+AcxnF59MV6I9RavTkm+ZwRnsY
JvCuSV/GqKfke4YMUjpJT0R2ptSCHNMTqDdvKbM0aMdpFnzZQrRqSw0qvf02WWKd
iUB0m5kD1IlVAW28ppse2z7jlR743mDxcMXM6zDGFjl+Xg+gEaphgICzO8DokwH9
+CJBIrMcltG3J4SqC3fbEU9PiT8seIndSqB/8G4/R9zxDSQGvbsqWAUCCnH+9s9c
gl79zzavI80IAuG5h0ngFlaZmPmbmw6Lsxzv3oTiS0IXj/35plHGV/DPwvKHAInQ
lDT4/keYds0jQTt9rg1YOyaivamLMruWW1pwd9c4KDRPenEwoR6W4nMMe4cRpb/f
2wFKLIPwlTNwRJLhYxZWeTmLngltEFKxCVtofg+TSOlEVEpUmDEUfkVYMpBLS115
ygCnLUwos0hp8wyREZIldrlX69t3222TnuydSlmghOQdxDRL/p/Glq+Hx9LolFLk
pv43QrbP9a0RzURx7j2V6C9db61NZm7fcFHHRnmbQC3dt/yZmSo40235czf9QgXB
b6xdsOYAMh8pNM2BemhE6GB8+ivvG4NdC5uxAIA+kAdhMaEbj9YgRjQdvWLM0Uy1
xBpZFnNc709U0Q0z1O8y
=fIua
-----END PGP SIGNATURE-----

--uTOHp36N6S0WjZTp--

--===============7680082802425081426==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7680082802425081426==--
