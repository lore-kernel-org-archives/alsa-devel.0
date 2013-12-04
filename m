From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl: imx-wm8962: Do FLL
 configuration in hw_params() and hw_free()
Date: Wed, 4 Dec 2013 19:02:11 +0000
Message-ID: <20131204190211.GD29268@sirena.org.uk>
References: <1386176048-6960-1-git-send-email-b42378@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5766683535127141920=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id DE75C2619E5
 for <alsa-devel@alsa-project.org>; Wed,  4 Dec 2013 20:02:14 +0100 (CET)
In-Reply-To: <1386176048-6960-1-git-send-email-b42378@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <b42378@freescale.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============5766683535127141920==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3WLtXmtPTeS+BWmV"
Content-Disposition: inline


--3WLtXmtPTeS+BWmV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 05, 2013 at 12:54:08AM +0800, Nicolin Chen wrote:

> Previously, we couldn't use hw_params() and hw_free() to open and close F=
LL
> becuase there might be race between two simmultaneous substreams and cause
> FLL configuration being changed and accordingly mulfunction. So we adopted
> DAPM to control it since there won't be any race in DAPM. However, if we
> want to playback a different sample rate file, we need to wait for DAPM to
> change its bias_level to reconfigure FLL.
>=20
> But after we introduced full symmetry protection in the soc-pcm, we don't
> need to worry about the race any more. And the instance by using hw_param=
s()
> and hw_free() to control FLL would allow us to support flexible use cases,
> 'aplay -Dhw:0 44k16bit.wav 48k24bit.wav 32k32bit.wav' for example.
>=20
> Thus this patch mainly moves FLL configuration from set_bias_level() to
> hw_params() and hw_free() so as to enchance the sound card's capability.

That's not the only reason for using set_bias_level(), it's also used so
that bypass paths from the CODEC inputs to outputs get the FLL started
- all the outputs need the device to be clocked.

--3WLtXmtPTeS+BWmV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSn3wwAAoJELSic+t+oim9FXIP/0qUabxMCw7y68H74olPys6T
wZ5/f8ukaDJ7SMYqXATrPjiiI6ZZZl9IpLMZmS2JytFEkZoCudOXIXNqoU+22YWA
vUqH9kv6L9+PvBlEF0gSCrehPnMZcs2PmGGJd6lQ0RtVAkmDkVai/5yJEXBRFQBi
cTCAoq9UWq8hx7Jbklw5AVKEhgkpEJUTtj/Y8YzXlhlFl2+6iZv7bdlmHIVkHQYF
ft0pEulgqESvU/Oi/LHPvtWei5e8G65vUCrUu+KrisGQH1ug3nSBcaFAsLnHyz0s
D3aXbked4URSKJrMNU+k4/d6z7P7fddPY/+lxLh2iT+dtjmrbUFqE0oh17vVyVbL
/2n00PtycSsz0Z10C8qD+BbpRMahgocY/GqLFdV8GiykBwls4qaFgqE7/5pE7lFh
+XAYwIHi427BAAILIrVWnREDl992AuukSrIOycywTdccA2TZip1F6uX1IQUxILFm
yYCH57xwPbqugP736irCPlod5FRfvvLlSGI3E0cgUaMV4keDYshl2uiPbD0R/gAW
b0jDqQ4QI8J1zW8kUBEqWPQO2rD/cqx9/Y3gr6yV8LxoG5omMPcuhYiJUKJvBq4k
/ipYVJJwTZ4xnuTrxvFOwoJtq2k4/tDlM4/PVOPOXOLepVdEgjOrcY5KJPRlW4bR
944lnwMxvRQFnn0CYNiK
=sxIB
-----END PGP SIGNATURE-----

--3WLtXmtPTeS+BWmV--

--===============5766683535127141920==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5766683535127141920==--
