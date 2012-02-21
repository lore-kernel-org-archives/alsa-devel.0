From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ASoC: twl4030: Debug code cleanup
Date: Tue, 21 Feb 2012 09:59:27 +0000
Message-ID: <20120221095926.GD3079@opensource.wolfsonmicro.com>
References: <1329809660-22077-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2375081911058071334=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 532512417B
	for <alsa-devel@alsa-project.org>; Tue, 21 Feb 2012 10:59:31 +0100 (CET)
In-Reply-To: <1329809660-22077-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============2375081911058071334==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9UV9rz0O2dU/yYYn"
Content-Disposition: inline


--9UV9rz0O2dU/yYYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 21, 2012 at 09:34:20AM +0200, Peter Ujfalusi wrote:
> Replace the printk(KERN_ERR* instances with dev_err in the driver.
> While we are here clean up some of the debug messages as well.

Applied, thanks.

--9UV9rz0O2dU/yYYn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPQ2r3AAoJEBus8iNuMP3dBXMP/RtwR4j+hySXLAlcbfD4aFmm
vIIbLYP5p2cfrUJYd0zO+wSr7xvie29AQLbPGZxsqtE+Nko+LaxliYTCQz2NEAcT
tfxEtSQMjUjNOq2qQ1QBEg62qyZyHEKudsiiS7NBDJe3Ie2qg5ebptqEN/mLuKwy
iBAbJFW/3LohSnHgKMEE66zK0HDtSK+0k56XiY362pDfbnYBcflBRR+enXD8vLPj
Fui3CzCzRyY+ON4AShNSrt6RCXJez3+VLP6kv/AWH6bj0nicDZr5Qw5GwUtEeoxw
Hac5LV3P8a0aqxIbdCvP2I7d6hH7NwovD67Lh4z6FBQnCSwY3ZZ56PFW/6msQjyQ
Kj409uzKJBc8NQb4I/5lTDwn8KM4cKkxgZKV6muP0rC67WZr3PjqQ0mRn+3Aprly
g6qJeX0jNTKrvHS5jPHQKSgjaQCPJ1ECqOfjGFKJ/pNtSD9Vw0hgP+yLC7YyyWzJ
Iz4ijIEnhlA2aOcQysNDcxS3j9r8q641Lj+vne8Yce9mS08L8xW+sJMHK0Xu/xNy
NI7NY1c1lnXwk3bH2ao0jrK9hVVrMxbZRC/9JqUnPhuYAdYQqhfi/zd5k6o5W4y/
HsLWwbJuYphNg25lFSmFZ3vWcWc0f5hYIb20FyGncWGG8Zz41Usl42IVI9DcXKt5
pyIMNqsa2QnwiyQnQwKf
=YHIp
-----END PGP SIGNATURE-----

--9UV9rz0O2dU/yYYn--

--===============2375081911058071334==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2375081911058071334==--
