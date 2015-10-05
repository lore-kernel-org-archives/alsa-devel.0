From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: rt286: Fix the runtime error in
	the booting
Date: Mon, 5 Oct 2015 10:58:55 +0100
Message-ID: <20151005095855.GM12635@sirena.org.uk>
References: <1444018228-18893-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0246571199552674184=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 68E282604ED
 for <alsa-devel@alsa-project.org>; Mon,  5 Oct 2015 11:59:21 +0200 (CEST)
In-Reply-To: <1444018228-18893-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, john.lin@realtek.com, bardliao@realtek.com, flubba86@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============0246571199552674184==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Bsy/rPjPw3Zgz4JZ"
Content-Disposition: inline


--Bsy/rPjPw3Zgz4JZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 05, 2015 at 12:10:28PM +0800, Oder Chiou wrote:
> The struct rt286_index_def was used by the cache function, so it cannot be
> declared as const.

Like I say I don't understand why this is safe.

--Bsy/rPjPw3Zgz4JZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWEkneAAoJECTWi3JdVIfQcSsH/1HlYo2RoBKAxTma7hLZ759N
VdDPXoD8eYwlm8FA2cIDnNWOpF89A7IebfcX2in6Jud693n3Q9L6NyaPfCWLZXzo
m4X8q77dxFpdSloCWvhQy1EosQqB6f2gZbmLd6y8FCsF0Y2/mh8j6soYgV+g+oyp
pmYKpu6ScXm+7YyKWKajXfoT62FLkOuIFKodRq+igWH9r0TosBmlQNwCV076YIhy
pZLiG6k2X/Re2MAr+7kfC1sj4hJ54nKav6cUE6ppUAf43WTLW6wOvWLfjhGUobWF
trUIKdXfafq5eWd8b56VHxqGbHazhj+JMREvgNXC/fQYcz72ciflXAkZUn6C+vs=
=9X7y
-----END PGP SIGNATURE-----

--Bsy/rPjPw3Zgz4JZ--

--===============0246571199552674184==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0246571199552674184==--
