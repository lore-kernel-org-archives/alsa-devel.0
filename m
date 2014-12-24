From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5677: fixed rt5677_dsp_vad_put
 rt5677_dsp_vad_get panic
Date: Wed, 24 Dec 2014 11:57:06 +0000
Message-ID: <20141224115706.GQ17800@sirena.org.uk>
References: <1419392945-29971-1-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6411570779548119982=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7B8942608D3
 for <alsa-devel@alsa-project.org>; Wed, 24 Dec 2014 12:57:24 +0100 (CET)
In-Reply-To: <1419392945-29971-1-git-send-email-yang.a.fang@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: yang.a.fang@intel.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, praveen.k.jain@intel.com, lgirdwood@gmail.com, kevin.strasser@intel.com, denny.iriawan@intel.com, bardliao@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============6411570779548119982==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cMIc5PxTaUbxPQlJ"
Content-Disposition: inline


--cMIc5PxTaUbxPQlJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 23, 2014 at 11:49:05PM -0400, yang.a.fang@intel.com wrote:
> From: "Fang, Yang A" <yang.a.fang@intel.com>
>=20
> snd_kcontrol_chip should return snd_soc_component instead of
> snd_soc_codec

Applied, thanks.

--cMIc5PxTaUbxPQlJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUmqoNAAoJECTWi3JdVIfQwlcH/3khDzUGZVj3HZ2rJScOsQ3P
+MPNQ6g+/qrdGOo3JhZyAishh56Jwxr71ZtZN0LvxNmH2gq2q+0mkLOkjkmftLN1
6mvB4fE5QHmTHhksczvpWczl2wDjmbyZn6CmrDoSFTjCog+gjkQPUEFf7Pe0I8R9
6t3h7Zc8zKVBxbRP7dVydDn6SN8b4/2KT5XxTJ9hlA7zOCSCYfgoYSEh40OdeeAD
7xPVk/qPLxv/A6ab5GzNiRjOcJ+XyDRkyMXZLMf0yFcA0wxlg0Y5GeKP72HSXAHL
QQFk3ICBzykb1Odb73OttFn1MdlLgFv2O5C/g1k6FDQiQQUOvuv22mkxQXbfAZE=
=P3hb
-----END PGP SIGNATURE-----

--cMIc5PxTaUbxPQlJ--

--===============6411570779548119982==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6411570779548119982==--
