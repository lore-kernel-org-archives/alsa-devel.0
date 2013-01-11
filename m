From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RESEND PATCH] ASoC: OMAP: HDMI: Initialize
 IEC-60958 channel status word
Date: Fri, 11 Jan 2013 23:59:41 +0000
Message-ID: <20130111235940.GC7873@opensource.wolfsonmicro.com>
References: <1357864333-18742-1-git-send-email-rneri@dextratech.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7423840619660833584=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 53A29264FF5
 for <alsa-devel@alsa-project.org>; Sat, 12 Jan 2013 00:59:42 +0100 (CET)
In-Reply-To: <1357864333-18742-1-git-send-email-rneri@dextratech.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ricardo Neri <rneri@dextratech.com>
Cc: alsa-devel@alsa-project.org, lrg@ti.com, dzuniga@dextratech.com
List-Id: alsa-devel@alsa-project.org


--===============7423840619660833584==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pAwQNkOnpTn9IO2O"
Content-Disposition: inline


--pAwQNkOnpTn9IO2O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 10, 2013 at 06:32:13PM -0600, Ricardo Neri wrote:
> As the IEC-60958 channel status word is set by ANDing and ORing with
> the appropriate definitions, the word bytes need to be initialized
> to zero to avoid misconfiguration due to previous hw_params calls.
>=20
> Signed-off-by: Ricardo Neri <rneri@dextratech.com>

You've dropped my ack from this, you should keep acks on patches you
resubmit to save people time on review.

Anyway, I guess there's no need to merge via the video tree now so
applied.

--pAwQNkOnpTn9IO2O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ8KdkAAoJELSic+t+oim9vUkQAJEcPUNNmJu4O+oTIWHmRp4d
YtcLtFQphgbNWljbOgDd4zSoODqr57DKp1FHIKGlqx4Kb9J+uTbD8/iO9n0eRQTV
u2wgatcONsEriDPx1aPzBEyhAOjv1oprsP/JSZHXeq3SENPQizSfWbA0P5NX9Qfu
un233nVT+LCO+KosWl8pt5IXqBLvCLgV6hg9cnMnrZlh6Fif/BpF7rqwTnsvfSaF
Z3JatmrtWOKGW3xokQJbsm7A62hdPTZTKAJ1l65gMo981ErhOFn/nQhx0/D+b1Ob
tQ6RLVW912mxUaKGk5IlVCndprEB/LWPi0LH5m3Sf+9vx474Gzh36VRUiH61T+no
YEn64vOalZGWafoxydtJ3aV4K0nR7qjMhpfEZ0W8z7J0vdb4LVP9nziXKMuIQcWn
LCK20Qb3/AR5cb6iLXYhqNRch/JljAESzpEBHWjStq78dPqo4Vtnus+aiP36ImlB
8q7USmgj0P64MuWhqB9HgE+JEp8FWxuFxWZPlgAqZWjmj2IZ7+ug8aA9oc0uLgjr
KeiG3wsPq++LAzlJR6nudYI8KRfjJKddeZJslAIMABYvcBw4W0wbXtvr5kqLL8il
fIcCVMgK3tw/JOalalkDY/JZxmXApOcVogCxBmpyGnncjO1zym1ezbKB7VlSnkrB
tnTxSrOJKUFUDjsDr6En
=Mbvi
-----END PGP SIGNATURE-----

--pAwQNkOnpTn9IO2O--

--===============7423840619660833584==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7423840619660833584==--
