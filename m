From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 11/31] ASoC: wm8904: Use WARN_ON() instead
	of BUG_ON()
Date: Wed, 6 Nov 2013 10:32:41 +0000
Message-ID: <20131106103241.GT11602@sirena.org.uk>
References: <1383673218-18405-1-git-send-email-tiwai@suse.de>
 <1383673218-18405-12-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1366614321579698568=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 81D6B261AAE
 for <alsa-devel@alsa-project.org>; Wed,  6 Nov 2013 11:32:43 +0100 (CET)
In-Reply-To: <1383673218-18405-12-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1366614321579698568==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0WGqsT62A4RTsSXf"
Content-Disposition: inline


--0WGqsT62A4RTsSXf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 05, 2013 at 06:39:58PM +0100, Takashi Iwai wrote:
> BUG_ON() is rather useless for debugging as it leads to panic().
> Use WARN_ON() and handle the error cases accordingly.

Applied, thanks.

--0WGqsT62A4RTsSXf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSehrGAAoJELSic+t+oim9yzsP/1kcOVH5ylAs5ob/v2MN+YpL
/mI8lN4otTkWKdAjOtH8wnUK+byYXJNGTZFHTr4JhkAstwYpXIZBlHcNzEfyQ3hu
wUGpj998WBJU51bGbxT6L1jmcHhpIo49kP9Bj595GGfCKaeaYhSfvZIHrHXKHu7X
WlPMmL+AlHFHQapTFBJEFt/08AAg85gMmCQWC/RlMvpTG2n26wzR0qHduCD3Rfd1
ykAJ68E5tbx9P+WLGJbY77zGHJqQp7yoc1S+euL1jxtiKl+M892HrbTnO0snpZ0J
F+66VBNr3YB4+QFUpgNhdhYsL4sHjB053PRjjTAKME+nTe1REaFgcQA+qFYaafuo
x23Zld2onzcbN5HtHl7uy4z1Gc5Dcs+gvEYe3B2AJAxAaFFB0p27s5dAxMdkZhTh
vytkFWfN5Ny+PBuw7NV/GAsgMLQ0jouLtNYFg6NuDkzOcs8m4Q6vdPybCZnnZm9l
Z3474Qj2znhCRWHdnIypFfWoXsopZu8N6YoKMJTIRKbw89jfDM5urTqUbP/zRZEB
Q3sd0LbC+WNQG805W28jOjXmoCFpTtFnH9aajtoqfoiCkLLOj5CfDk8ilBNzYFQ8
ojxf1QKxXFPRlPJ7/B7+w6jVQqIMEFWg3cLmUybFvSmEqOUL60NKU5tFi9U/N3ea
mIAVYp6uNb5BqflzO07M
=y+bf
-----END PGP SIGNATURE-----

--0WGqsT62A4RTsSXf--

--===============1366614321579698568==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1366614321579698568==--
