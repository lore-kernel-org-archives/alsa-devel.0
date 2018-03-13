From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH][next] ASoC: samsung: remove redundant
	pointer cpu_dai
Date: Tue, 13 Mar 2018 09:21:38 -0700
Message-ID: <20180313162138.GQ2186@sirena.org.uk>
References: <20180313133626.31286-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0235502952056331797=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A168E266E60
 for <alsa-devel@alsa-project.org>; Tue, 13 Mar 2018 17:21:44 +0100 (CET)
In-Reply-To: <20180313133626.31286-1-colin.king@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Colin King <colin.king@canonical.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Sangbeom Kim <sbkim73@samsung.com>, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Krzysztof Kozlowski <krzk@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>
List-Id: alsa-devel@alsa-project.org


--===============0235502952056331797==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3wfpuDtTLg8/Vq6g"
Content-Disposition: inline


--3wfpuDtTLg8/Vq6g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 13, 2018 at 01:36:26PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> The pointer cpu_dai is assigned a value but the pointer is never
> read, hence it is redundant and can be removed.

There's some subsequent patches to that driver which I think provide an
alternative fix for this.

--3wfpuDtTLg8/Vq6g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqn+pEACgkQJNaLcl1U
h9AKUgf5AcxCWJ0oHWoN6eTUV0BBsBklpteqtkqoe3+mF23ic+8fKLqHoXXy54Tf
oUBToMtJm86A5vtdpMiWn5bKoIhz00hlOoB6ifEzo8OVCqGVjfboFIm4jDe86U5M
2dOx+oTvjU1GkX4YmnXQT6ydSmDV2WRDJXooj2+oMw1c4oMpuRU8WasV42bd9EDw
G0lllykMwVDwq8K4OdoArGgsCyenkucFzG0FTig/qHn3fWhFsDDZwh58TxbG64Tn
VteJqoMrwc7biNYV1uTHk0lOz1c/u5lHD/LAr5U9keXNar7Qr72p9ILckZuJNmnM
/OJGur4cMcrVhVyHndO9/GOWPLhNNg==
=0SDV
-----END PGP SIGNATURE-----

--3wfpuDtTLg8/Vq6g--

--===============0235502952056331797==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0235502952056331797==--
