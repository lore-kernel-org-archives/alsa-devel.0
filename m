From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5677: Fix the issue that the
 regmap_range "rt5677_ranges" cannot be accessed
Date: Mon, 24 Nov 2014 17:11:39 +0000
Message-ID: <20141124171139.GH7712@sirena.org.uk>
References: <1416809779-5308-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7985724168134812023=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DA8E326507D
 for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2014 18:13:31 +0100 (CET)
In-Reply-To: <1416809779-5308-1-git-send-email-oder_chiou@realtek.com>
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
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, john.lin@realtek.com, anatol@google.com, bardliao@realtek.com, benzh@google.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============7985724168134812023==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="it/zdz3K1bH9Y8/E"
Content-Disposition: inline


--it/zdz3K1bH9Y8/E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 24, 2014 at 02:16:19PM +0800, Oder Chiou wrote:
> After the commit "19ba484d7b15c8650b30377aad6e65b34d3cf3d5", it will cause that
> the regmap_range "rt5677_ranges" cannot be accessed. The patch fixes this issue.

Please provide a clearer changelog.  What is the issue caused by the
previous patch and how does this patch fix it?

When referring to other commits always provide a human readable
description of the commit (generally the patch title) as well as the
commit ID.

--it/zdz3K1bH9Y8/E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUc2bKAAoJECTWi3JdVIfQgzQH/1fRYvv7G5jPHU0JRYuJDceT
HYMKVttQL4Yvw3enYHY/ZNamh0PTsnLaobMEMMMPtil+rmAbDgp9xlTW0GLelwGG
bJVzRZc3f1KD91sVmMz1DpBu26vslW9vQnZOvbG/JEW92qI3Mr/IAxJj2RU3PXJ7
tYtXVQiy4U5/2GA5fx14rCb2v0xYbBA0Nxv6y2FC1Tk4ZBSIRfnwbPiDIywWa0oq
/euRnkf2ZzUWKcIvQZ5b8zQnibN+9kSJH/ID+RHEesPrtFqbVB4g7R7braZUmwUF
5Tik9R/OpE58fQRgyIij+lGY3TZXf3B5o54ApYNIMNsxQjYMMeajz4nAxqsZKF0=
=xHno
-----END PGP SIGNATURE-----

--it/zdz3K1bH9Y8/E--

--===============7985724168134812023==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7985724168134812023==--
