From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH -next] ASoC: mid-x86: add missing iounmap()
 to probe error and remove
Date: Mon, 13 May 2013 17:45:22 +0400
Message-ID: <20130513134522.GH6836@sirena.org.uk>
References: <CAPgLHd_RTomuGFrwReDt6w9q+nH376W=6hHD4qZ4PGQXRGnJqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3587198487040690541=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 74DB62617B6
 for <alsa-devel@alsa-project.org>; Mon, 13 May 2013 15:45:45 +0200 (CEST)
In-Reply-To: <CAPgLHd_RTomuGFrwReDt6w9q+nH376W=6hHD4qZ4PGQXRGnJqA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: vinod.koul@linux.intel.com, alsa-devel@alsa-project.org, tiwai@suse.de, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, ramesh.babu@intel.com, yongjun_wei@trendmicro.com.cn, wfp5p@virginia.edu, namartax.kohli@intel.com
List-Id: alsa-devel@alsa-project.org


--===============3587198487040690541==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Hlh2aiwFLCZwGcpw"
Content-Disposition: inline


--Hlh2aiwFLCZwGcpw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2013 at 05:00:44PM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>=20
> Add the missing iounmap() before return from snd_mfld_mc_probe()
> in the error handling case and to snd_mfld_mc_remove().

A better approach to this sort of issue is to convert to devm_,
eliminating the possibility of such errors in the future.

--Hlh2aiwFLCZwGcpw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRkO5vAAoJELSic+t+oim97N4P/0aOhaJ031WOfkGPtrtaN33L
DUMkis68oULRNfUo6JY0Hw7f43XQP7ciBeoeuijdZ0ALuu72eu0WOPQm6eh6fhaY
aPj2opIZrmoUjTun4YLX8AAqhAb1uj7ZWkgWH1pZa947NkbJP4XOsXFmaQuL5d06
Vx8ySvSn8qp3BycVsDi8Zm2y4oIUY5RaNqeePYKSQQoLAfaPaxfGZSY8BwZMD6Ed
TbOEHWeuFPn0NHu4ce0H173ZPIhIaPM2ytJ3RcsAoES5UhyqO5a9E37jWAVonJ2U
v34DWmTa6Q5eD6Cz7q+asJpUNP+RTKULVSVUHohTK/cFeENItAmyjtpACID3x7pY
bX03G+Z39MYM2qNWfIqa2UXAtSlwZ2Z36rGr6MMnIzgIQWJDQM+QNsx6hvqmMY/b
A78VmTk66oEpjhnbdHrpxhL+UVavSwjbYZx9pAtIQydGWixpAxR6kE698bzZ4LLt
z0fjqqC+y5qLqJAGprNXrTNWAM14sOGY7+mem58W5CWgzg6NB8bqpbonespdmaZG
MGvFpLOsFeuBQMCxyuiHnQuNhL0DUrnRu4eCSmlRbVfp0DgXkyxOy6AILMID7u/D
WVOuUIy8wYLfxD7mD5FEs+A8h+plL6FxUbrvxn/y9ur5KyfSP9HoDu17JNhRVNND
UC1gqLwVO6HxA5gGC65Y
=aCVU
-----END PGP SIGNATURE-----

--Hlh2aiwFLCZwGcpw--

--===============3587198487040690541==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3587198487040690541==--
