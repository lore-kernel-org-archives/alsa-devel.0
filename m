From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] ASoC: export
	dapm_kcontrol_set/get_value functions
Date: Fri, 6 Jun 2014 10:51:42 +0100
Message-ID: <20140606095142.GZ2520@sirena.org.uk>
References: <1401357817-17942-1-git-send-email-vinod.koul@intel.com>
 <20140601192649.GQ5099@sirena.org.uk>
 <20140606055407.GA21128@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1025519138742182873=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3A150265278
 for <alsa-devel@alsa-project.org>; Fri,  6 Jun 2014 12:35:55 +0200 (CEST)
In-Reply-To: <20140606055407.GA21128@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Kp Jeeja <jeeja.kp@intel.com>, alsa-devel@alsa-project.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============1025519138742182873==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Fq7EdiloNwzjWdQG"
Content-Disposition: inline


--Fq7EdiloNwzjWdQG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 06, 2014 at 11:24:08AM +0530, Vinod Koul wrote:

> Well the problem is that we can't use the current ASoC handlers for platf=
orm side
> mixers etc. The current code assumes that mixer is only present in codecs=
 so in
> snd_soc_put_volsw() it does snd_soc_update_bits_locked(codec,...) which w=
ont
> work for platform side.
>=20
> Hence we went ahead and did our own handler for platform side but need the
> dapm_kcontrol_set/get_value exported out. And yes I wouldn't have bothere=
d you
> if this was to be kept out of tree, the plan is to get this merged :)

> If we go ahead with Lar's series we may not need this, but am yet to test
> that bit.

Right, that's definitely where we want to end up - convert everything to
components.  Failing that we should make helpers that work with
platforms instead of CODECs so the code isn't in the core.

--Fq7EdiloNwzjWdQG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTkY8dAAoJELSic+t+oim9xyQP/iqMGqBK/EkL6zb9RCtpdOi6
EFRvXSoobo1sFJbkpvJZjctVEsq3tuToXOzytfxAjRXJPHpUl0aLP9/iDJQIAu3e
+mexXHX8eVx8qT4J1kBHubEcX4qyGtvlG7B4qPav4PNZ64iwrLs1GBLf5O4srImm
nPNFpmYtY8Bnh60atWbvQbDYCUOqv5WXdhaUESC+ajdFipTRpudr15QmgBVkqfTs
03vMQ47sDjkwiJFc5t3zDV80nSL7esMaJIF9cZLf3jtlUcNcsqAfnBinMFGkDx+5
CG4e2GZEYvnnmP4rMa3GDokfQUH0JKP26P7qj6uoDaJNoNcTGYqDHuG4DC2xqJLp
Plj9mHvHahlthDgYtV3h3iV46eAISwwEIk8z8H50FifG5imiSW8VHxKzDYpj0lLS
hhJsWUN0fkaY1qTPGLjvugV/OzEG/h4pTCKpq1s5zlOZAf8autG3GlEOoGIHrk5j
e4nljqZ+Ujq2yFW3RU6Z3ovXOBY8D56k1mBCE98x7v5NG9jx6jVqbtjGAOV+o6vT
G8thwVS9wRHgf2DrmjX7Mn1CuwJztxdw/B3H/O6ISqo6hivtTqXCE/u5GKneLUri
u6UEJy7HO3MgHQA6dt2qdP8EhNI30OcZtZ/8OtD7pvqYkCZbc/Q7+UhkBcNrq/FL
ScUXXPhs4a6KO/tirdgq
=NM6C
-----END PGP SIGNATURE-----

--Fq7EdiloNwzjWdQG--

--===============1025519138742182873==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1025519138742182873==--
