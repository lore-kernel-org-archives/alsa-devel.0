From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/6] ASoC: omap-mcbsp: Remove redundant
 platform_set_drvdata()
Date: Fri, 3 May 2013 10:36:43 +0100
Message-ID: <20130503093643.GJ4945@sirena.org.uk>
References: <1367572164-19523-1-git-send-email-sachin.kamat@linaro.org>
 <1367572164-19523-2-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2859648151476438591=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 957BA2616A0
 for <alsa-devel@alsa-project.org>; Fri,  3 May 2013 11:37:04 +0200 (CEST)
In-Reply-To: <1367572164-19523-2-git-send-email-sachin.kamat@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Jarkko Nikula <jarkko.nikula@bitmer.com>, patches@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============2859648151476438591==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M9pltayyoy9lWEMH"
Content-Disposition: inline


--M9pltayyoy9lWEMH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 03, 2013 at 02:39:20PM +0530, Sachin Kamat wrote:
> Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
> driver is bound) removes the need to set driver data field to
> NULL.

Applied, thanks.

Note that there has never been any need to clear drvdata, it's always
been a bug for anything to assume anything about the value except a
bound driver that set the value itself.

--M9pltayyoy9lWEMH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRg4UoAAoJELSic+t+oim9WkcQAJBLZ9ZhSEgLm3gO8mdcTeLR
+nM0sXTk5KuZwKOlgsgGM+s160rDxHKHkD0SEvHTwkQFalKyyPpABwS7ttMy5jGR
gPefI2j63bmb7eGTFTCt0uOySFKYsyQ8WvP+Dtw9hPu7J8Nc/u2BPDxTuxVxLnXC
13aUJVF8ff1We6yeBD5upjeVaDwP6wn6X5TfTyLs/lVDiWBHFyRCr42fGgtMA8nA
CKbhZMw1gMtaacEc+FGXJHjGrlJ74tuAq4L7SwBlrFV0Jzqta5rygtRsyOLRd1d3
yDchXvNScT54jzf0OrxE28u0QVK7FjcMzV4LehhtgXEvF3ZkxRRXoyeNDllpJUOB
ia6WrbjXiyTP1sRHxye2yEUOMP2+QdrOowrebb9Y2ommEoAmQB3mxShfSd+S8LhB
kzFMh0Rf8Lqr5XKsZqPXd3TZF8ZIQmN7o4256h2+E8R8kpg+OQ0q4wHqPoGD9EcK
/GPP5pBQABozvlZgksxfz8Zge+mo8ZrZTvqiGP4qokcSFXauxxUYuIpm0E/MYTTb
ud9ZPYCr9H5VzkT+EJPg7uAaeAf/019LEgKYJA+CFDSn8G+7QO8qm2mZIa385vAw
zwSvQUWXeGWn5EnX9yVxdcL/2PbGyi9RfG0obCSeSTzuHt5fXOcn5Q34LQw+TJvs
XMUtcTxMQHt8IG18qDBo
=5WkA
-----END PGP SIGNATURE-----

--M9pltayyoy9lWEMH--

--===============2859648151476438591==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2859648151476438591==--
