From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/3] ASoC: AMD: Use single dai for
 da7219 playback and capture
Date: Tue, 20 Mar 2018 09:13:22 +0800
Message-ID: <20180320011322.GO2186@sirena.org.uk>
References: <1521437863-12389-1-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4040235884652212539=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 14B8E2672B2
 for <alsa-devel@alsa-project.org>; Tue, 20 Mar 2018 02:13:28 +0100 (CET)
In-Reply-To: <1521437863-12389-1-git-send-email-akshu.agrawal@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Akshu Agrawal <akshu.agrawal@amd.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com, djkurtz@chromium.org
List-Id: alsa-devel@alsa-project.org


--===============4040235884652212539==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CCT1URigZHXF2ubj"
Content-Disposition: inline


--CCT1URigZHXF2ubj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 19, 2018 at 11:07:41AM +0530, Akshu Agrawal wrote:
> BT I2S is a bi-directional dai, we will use the same
> cpu dai for playback and capture.
>=20
> V2: reworded the commit message.

Place procedural noise like this after the --- as covered by
SubmittingPatches - it's not really relevant after the patch has been
applied.  The graphics tree is unusual in handling this differently.

--CCT1URigZHXF2ubj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqwYDIACgkQJNaLcl1U
h9CBzgf+KfvhWw1T7diH8JYbrypX5cOtSlK/LqRzoWDoVXDeaDXRzFbwCHAd1CLm
6u/Q5Hq1pvaY9fMdZ3kTRHvCP7W/VJ2aj2x+Tmu+n4IzTWZe0JYXeHbSEbOCOmli
ainaQhhl0bQTyNrWK0WGySQ+tuD0PpKeM4JrpXP5fESsRek01LAWOv8Tu0YWPge8
9jWGkoQQWmu1akOlEyuxVtBUKxZZnYHk+xM4QmKCLYuTQgMYvB22WT+WG/lPncHn
qZWT1WElUJrgs+twdd5MWRsUoMH1Xdw3LIRBsULOkLRpGmCHonvJouWJah7+QReK
RHlAkapGUytz0mfLFwJ9S1LWhC58Aw==
=v7ED
-----END PGP SIGNATURE-----

--CCT1URigZHXF2ubj--

--===============4040235884652212539==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4040235884652212539==--
