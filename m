From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: core: fix possible ZERO_SIZE_PTR
 pointer dereferencing error.
Date: Sun, 28 Sep 2014 11:50:12 +0100
Message-ID: <20140928105012.GS27755@sirena.org.uk>
References: <1411896577-30965-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2202568074513823453=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3117A260570
 for <alsa-devel@alsa-project.org>; Sun, 28 Sep 2014 12:50:26 +0200 (CEST)
In-Reply-To: <1411896577-30965-1-git-send-email-Li.Xiubo@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============2202568074513823453==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="B8Vg9Vt30SMsjSDh"
Content-Disposition: inline


--B8Vg9Vt30SMsjSDh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Sep 28, 2014 at 05:29:37PM +0800, Xiubo Li wrote:
> Since we cannot make sure the 'params->num_regs' will always be none
> zero here, and then if it equals to zero, the kmemdup() will return
> ZERO_SIZE_PTR, which equals to ((void *)16).

Applied, thanks.

--B8Vg9Vt30SMsjSDh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUJ+fjAAoJECTWi3JdVIfQK3EH/1m7VRNRvjAXXss3XFx65527
YI0BHEx+ymxcnaWimkd8nIsxzi/9bXTPy4sKq/4b88PEYMJ5e1Zu2UkGKIih1n33
h6S3qZk8GOI3WLXUcdRUAZJdVAPq/b879d4NrOU28DFS7ZtroFkaS0ahQvrxJ59Y
brpZ4BalxmdjSpkqDL+f+EY2qGPNw5GX9Ssw2REn8Z+3gAp4DpgvH8M9dmlFqi32
sGYXP3sFyLXBXlXUKqsRkyXFv377vc9VxKUV14sys6C6a2e+OOE5Ro2yP7D02TL8
6NIEZsyv5j/CfZ6zZbOVlvM1rz0tbl1YHeEHbz6sA61P7enI18gP04TuMwgm7/c=
=xTMf
-----END PGP SIGNATURE-----

--B8Vg9Vt30SMsjSDh--

--===============2202568074513823453==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2202568074513823453==--
