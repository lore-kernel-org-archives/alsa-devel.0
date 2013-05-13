From: Mark Brown <broonie@kernel.org>
Subject: Re: ASOC bug? maybe no need to set bias_level to
	PREPARE.
Date: Mon, 13 May 2013 09:55:08 +0400
Message-ID: <20130513055508.GE6836@sirena.org.uk>
References: <027FCDD209E4CC4181A7B9D5DBB88057249C05D9@SHSMSX102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3602485389132837966=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 4D644261AE7
 for <alsa-devel@alsa-project.org>; Mon, 13 May 2013 07:55:14 +0200 (CEST)
In-Reply-To: <027FCDD209E4CC4181A7B9D5DBB88057249C05D9@SHSMSX102.ccr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Zhang, Ning A" <ning.a.zhang@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============3602485389132837966==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CGDBiGfvSTbxKZlW"
Content-Disposition: inline


--CGDBiGfvSTbxKZlW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2013 at 01:27:47AM +0000, Zhang, Ning A wrote:
> When I try to fix wm1811 standby issue for our customer, I find a strange=
 behavior in ASOC core.
>=20
> here is my test code:
>=20
> snd_soc_dapm_disable_pin(&dapm,"MICBIAS2");
> snd_soc_dapm_disable_pin(&dapm,"CLK_SYS");
> snd_soc_dapm_sync(&dapm);


What you are saying seems sensible.  Please send your patch as covered
in Documentation/SubmittingPatches in the kernel - the general idea is
to send something that can be applied using git am.

--CGDBiGfvSTbxKZlW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRkIA5AAoJELSic+t+oim9AIQP/29SMEn/jdGznL60Lv+KS2ds
FZd5lfoHRcthTTFfWhVmGaac8Alrp7bRx8sIVPOP6HiT2XH4pNkqEIN9+XdaiFZq
EmlgHtmGAy+GqeojDrTPSgHjU0OBo0F3OEjtL7sW8njUkffpwprpTD2NtX/b9dgm
1qBEflGmc7m7X9NW1TrXOQnkO5Y6GWTZ7MrtlscyM1C/ujdzJG+ELWnZCPEC09ZC
4wBbhG31Bw3oLZhW1PHtUKOCJ39Juy2SX3+m6LwHUjgVTEj7u1rF814YJgONkcSX
kDnMV6jjEPr2QcTiKQuAOcRzyDUFeMP3XjaDGsZ5h9DSeTBAsbpr5qi0a807u/wb
kCxVNXNGhQPwaujLFOj2wSndliXFndoodeCPULWGW7Ky4hMn6lxtw8r5M7RdOQNY
uNB+XPmB2P4XcqoEWjcWCb/UHInHoVNCNVIPoYGmj505hG3HnO7vFGh76OA2f8bG
5pAlPYofK2KbNL70ZBM/mZRRIs5ZtjXiNMv/EatlYbwqZlOSmOmzF45XKqIhyvfD
5qOlNK2sRMn1goxygA7OPo+eifGvKw5Q+hFSbCk3tYGhRDQKTA8T2olsUeUfmR9U
PAGpVWYfow6pcpOkkRGUaB893Rvc4xvUvBtvojMNev8rldr1dT46gpXunBlaDY8m
OdspxW0Mhzp16fZ/ekcL
=J/el
-----END PGP SIGNATURE-----

--CGDBiGfvSTbxKZlW--

--===============3602485389132837966==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3602485389132837966==--
