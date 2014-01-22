From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 6/6] ASoC: Samsung: smdk_wm8994: Fix
	build error
Date: Wed, 22 Jan 2014 17:14:13 +0000
Message-ID: <20140122171413.GN17314@sirena.org.uk>
References: <1390392043-24387-1-git-send-email-sachin.kamat@linaro.org>
 <1390392043-24387-7-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4453395133776282311=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D730C265161
 for <alsa-devel@alsa-project.org>; Wed, 22 Jan 2014 18:14:18 +0100 (CET)
In-Reply-To: <1390392043-24387-7-git-send-email-sachin.kamat@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: sbkim73@samsung.com, tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com, patches@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============4453395133776282311==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YKXUGXQ0rMH/U794"
Content-Disposition: inline


--YKXUGXQ0rMH/U794
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2014 at 05:30:43PM +0530, Sachin Kamat wrote:
> Fixes the following build error and warning when OF is not defined:
> sound/soc/samsung/smdk_wm8994.c:191:23: error: =E2=80=98samsung_wm8994_of=
_match=E2=80=99 undeclared (first use in this function)
> sound/soc/samsung/smdk_wm8994.c:47:32: warning: =E2=80=98smdk_board_data=
=E2=80=99 defined but not used [-Wunused-variable]
>=20
> of_match_ptr() is used so that samsung_wm8994_of_match gets dropped (as u=
nused)

Applied, thanks.

--YKXUGXQ0rMH/U794
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS3/xiAAoJELSic+t+oim903wQAIRChI03EbMPGFlu61Zju6EA
AA2+I+K0Y6OPs+LOx1ZKQdFJVmMRESvL5FVDuwHwCm0GV+t2xglX7EvLWjJIf3D+
CB0IsCCVPWaR250esp7v4kLIJlgvmmATOMZXzV7gfouD2VNm7pSH/I2KkenEd5Ji
2ztg9vVXMzreWVmYbuQF/S+tx0fPlsMfuYFO7gUt+a/Ga4Lx5BmXL/0i1r6pYU64
u0gP7klh7+3dauUyPqg+nfDkiEPhUaZ7cQQJQ4yRZb/HFOjo72UHqqI6426oIz7T
FCLP1PY7e4il+heTLYUIpF3MUu0Yttk2AHrcfuKzPSCwD0g8E4Oqsmn5NcF44igM
ZFSPFvuZCgOAxN/UR1nJ0fvixEZdkYEaq1J2O/fP8zel5FkrpDpRbm9EPFf2b4E7
7bdwzCIsnwW8VWfrKVaKSRPC45ZJrZ/qeqdIiLQDHRUNwOxJ6pXHyJyu/L83tGQy
ykkjLhaUdoSpPOjn4Pi25NN5aUdPoVl6IJmmhsiiswC35dgCklN4w2MXhcJNY9N8
2RIo83vpQZwyB8ztEmZOQ7fJ/ryw2mTxSCKXPxHIAC5no35wGrWP0aCpHmTe432y
2JDpQsGqAAdT8OEjeZbNhFtPxs49Ft+9Bh77IP8oHra4AGuaS6leyzgUfwWVkOgO
dJsBC8HLVKUm7nl2jJnY
=EA8d
-----END PGP SIGNATURE-----

--YKXUGXQ0rMH/U794--

--===============4453395133776282311==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4453395133776282311==--
