From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3] ASoC: AMD: Fix race condition between
	register access
Date: Mon, 5 Nov 2018 11:15:57 +0000
Message-ID: <20181105111557.GB5365@sirena.org.uk>
References: <1541020930-17337-1-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0329119271678049554=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 67C9D267692
 for <alsa-devel@alsa-project.org>; Mon,  5 Nov 2018 12:16:01 +0100 (CET)
In-Reply-To: <1541020930-17337-1-git-send-email-akshu.agrawal@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, "djkurtz@chromium.org" <djkurtz@chromium.org>, Liam Girdwood <lgirdwood@gmail.com>, "Mukunda,
 Vijendar" <Vijendar.Mukunda@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, Guenter Roeck <linux@roeck-us.net>
List-Id: alsa-devel@alsa-project.org


--===============0329119271678049554==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="neYutvxvOLaeuPCA"
Content-Disposition: inline


--neYutvxvOLaeuPCA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 31, 2018 at 09:24:10PM +0000, Agrawal, Akshu wrote:

> +/* Lock to protect access to registers */
> +static DEFINE_SPINLOCK(lock);
> +

Why is this a global variable and not a part of the driver structure?
Is there some interaction between multiple instances?

--neYutvxvOLaeuPCA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvgJmwACgkQJNaLcl1U
h9D/Mgf9GH4q+k9kKEx0SRVcKkgeynptlR5BeylHyoDKqeDDsZhyuUxEMdBoetL6
hL4JxHQ5AVSjRESEKSy111NdknxrsNcc89qVykUmreP6URrAY9iLfRQnbjPOxMMK
cxr7ZAnXrHAU3JssjrrwoldaRg/xMQoaStz1t+6Bm41ma1gJxJMREj3peDhjGb4A
rrCqXJK5SsJf0m2GYTxRHjmc32xOsFMGmdBYtiBXXKhx/cvfKQU9JEeHKemlRyMV
JIJZp75QGGWnoTG7D0UI32/SngudwYHabww1pHGPXM6ElrfhMS9J21xIExrBwBC2
0Oqxxvddcb9PhkdYIqxrVsTq4zEkQQ==
=aEa+
-----END PGP SIGNATURE-----

--neYutvxvOLaeuPCA--

--===============0329119271678049554==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0329119271678049554==--
