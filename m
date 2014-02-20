From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 001/102] ASoC: Rename soc_enum.max field
	with items
Date: Thu, 20 Feb 2014 10:44:42 +0900
Message-ID: <20140220014442.GP2669@sirena.org.uk>
References: <1392722967-12472-1-git-send-email-tiwai@suse.de>
 <1392722967-12472-2-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7830379178530616680=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 668A4265725
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2014 03:50:33 +0100 (CET)
In-Reply-To: <1392722967-12472-2-git-send-email-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7830379178530616680==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1grfRyLPAt2uHiRu"
Content-Disposition: inline


--1grfRyLPAt2uHiRu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:29:25PM +0100, Takashi Iwai wrote:
> The name "max" in struct soc_enum is rather confusing since it
> actually takes the number of items.  With "max", one might try to
> assign (nitems - 1) value.

Applied, thanks.

--1grfRyLPAt2uHiRu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBV4GAAoJELSic+t+oim9biEQAIqqRajPwwkzKxmnyf6jnIct
XGf7Ae84JhQFZLQ2vIVDNkwuRpqwk2bPLSmeCLLKOLe1trt+YSO+By28F7mP7+5K
dQMe6SvnRF9bPbfygabVuBKyTS7lofGpGhvcnblJNmcu9MUl5lhHWKwNb7lMY98K
s/SIy90YRmwD3YpUPlia0DkpSxnptM9yp6JmJBJ+Xkeid/J+6AlihVSLJOPvDWRA
trs2u9PwdEVp6aEPT+k1KwXNeiWJ9skn500eJffTEa4UvITnepsI3hcAGVXpHVWg
RBw0y6TjdT0W+OJiGFEDivEHqPpKVcnlHaKPyG859aUhuxgGoe271goemDs4ffk3
KsFdvHRdTJ7diQEi+uQOenNFsG+Eb6Tnzc+HgYoiL4sHQTtQJXw8DshvCqLT0RM7
fTqDX4OVO7ZgGEzTM8MLIYkHHN8Sj2fg+AzcNWfZd7qB3zN58Jht3i/IuUDELZvt
yTme/IGOOJbDsx44PFCA8S1XAmaZPvf+MG7Yc/WZfpUEFkIEXzSgj7L5/7FtAMwx
62H31vrv9i2mRNV+WE8VvxLTjEmqHaUETMmagboE2/ZBAiq2YxmLpdpmUbtRRDJH
Gz/gnrDlUK0fGN2wF9otCtmt+W3EmE44iq9L9ZfUUsu0TDH6vptSPte9lpM8V8M5
2edeJ0Nol8Wswmv2hTl4
=O5Oh
-----END PGP SIGNATURE-----

--1grfRyLPAt2uHiRu--

--===============7830379178530616680==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7830379178530616680==--
