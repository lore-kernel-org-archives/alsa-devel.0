From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/5] sound: SoC: sof: no need to check
 return value of debugfs_create functions
Date: Fri, 14 Jun 2019 15:59:33 +0100
Message-ID: <20190614145933.GB5316@sirena.org.uk>
References: <20190614094756.2965-1-gregkh@linuxfoundation.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0103161275146942713=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 46817F8076F
 for <alsa-devel@alsa-project.org>; Fri, 14 Jun 2019 16:59:36 +0200 (CEST)
In-Reply-To: <20190614094756.2965-1-gregkh@linuxfoundation.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============0103161275146942713==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IFrzt5yFNjsAZ17G"
Content-Disposition: inline


--IFrzt5yFNjsAZ17G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 14, 2019 at 11:47:52AM +0200, Greg Kroah-Hartman wrote:
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

--IFrzt5yFNjsAZ17G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0DtlUACgkQJNaLcl1U
h9Dfzwf/b2V71DkyppdHr3vePJaj/boJ8W7t8v3VO/pkwgHYoOwMgQ5hrHmkS9X8
HYmkPBozwOOaZK1ZP4YUOrkcxOEvKjvMz6uutr17CBfEKknn5YkJcs3b4NT4T8U+
yBg2FC+G9JN/JAGVuf7HZl4yteTbB0YwtcN0BNpELp9hri9919rcYrocxuQcLlvu
icUKq2oHeCgiFGtyxKFCHHr9xtT4maRLCZTh38zMfZqhPyW9BZrxpLH26CXZVZEj
CSZCLLKKa8R8opvK3wX3ewUlpv5oICzJEIcmuKlXsyIOuFi4e5RXepQSvWls487b
FCrLRy/RNyJ/QE9eJJY0fijLexyyQA==
=Qu0z
-----END PGP SIGNATURE-----

--IFrzt5yFNjsAZ17G--

--===============0103161275146942713==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0103161275146942713==--
