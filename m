From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: simple-card: cpu_dai_name creates
 confusion when DT case
Date: Fri, 28 Feb 2014 12:53:57 +0900
Message-ID: <20140228035357.GL9383@sirena.org.uk>
References: <87eh2r9169.wl%kuninori.morimoto.gx@gmail.com>
 <20140227050726.GR9383@sirena.org.uk>
 <87ios0etzw.wl%kuninori.morimoto.gx@gmail.com>
 <87ppm87z3i.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6926004132303644987=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BDEC926592E
 for <alsa-devel@alsa-project.org>; Fri, 28 Feb 2014 04:54:00 +0100 (CET)
In-Reply-To: <87ppm87z3i.wl%kuninori.morimoto.gx@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============6926004132303644987==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="waoCbV9fObw3XsrB"
Content-Disposition: inline


--waoCbV9fObw3XsrB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 27, 2014 at 06:25:24PM -0800, Kuninori Morimoto wrote:

> +	 * see
> +	 *	fmt_single_name()
> +	 *	fmt_multiple_name()
> +	 */
> +	dai_link->cpu_dai_name = NULL;
> +

Why do this by overwriting rather than at the point where the variable
gets assigned?

--waoCbV9fObw3XsrB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTEAhSAAoJELSic+t+oim9AuIP+gMQh0LnUNTtKPp01SZWd7t4
yKgIv3TcaHKVk86y3x3RxUa3inKuJXFplCMMInBs8LaeaVHo2Wb/7hZn8aWcXf1F
EOeWtdS3THLFNgKAhNN7OBIDu5Qb34fNDbTG62KiV9ngh1fHrUqnfQtIJn4hBlEb
7Xtnvtt18rzaTUCQDb3qjQWBduNeLemayRUnU+37dHSBF3SuMN6BX5CBrsOHHWwH
ylfsGMeR4DQiKCFMogY+j8Er79hwRPZrKhmOdU+TVFelO6HNyqLGXKqCfpuACxkw
s9hAY8mxsq12/UwQfleE4mslu0cf9Z29OfU2mus+HcHwVbXrIA3te0nyg6O35p3V
N8QRwVunjcsWrnd2EK5FtVd0W1WV0Uo4BsYtH6GI2RxFICcUA74UI5M+HyY3b9my
7QF3LkEVYMh4vZhM/PiKNvwd5XWjBhdqugm7miAsC4eFJXAo+mOhfwTluxdui2O5
kBuUOkxg9uz7lZ259xv3KNeiglQ5w4uFzh0cm2pBBn0Ji7zSyPSGfnY5OGokliER
I33FBVv6T08ZNUtdHKAF7ipByYCIFRyfP0D6vn+V84nlk3XIfQQL6veWCWg84QBo
ACmOt4PkcVZ3VlyT8A+Ob3RNmcR+1bFtCPAhyTKBcRp81er1mpKoIErvtCj8JM86
auZsSfb+mHMQDg9/DYG7
=pLB9
-----END PGP SIGNATURE-----

--waoCbV9fObw3XsrB--

--===============6926004132303644987==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6926004132303644987==--
