From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: pcm: free path list before exiting
 from error conditions
Date: Wed, 5 Mar 2014 11:47:06 +0800
Message-ID: <20140305034706.GZ13126@sirena.org.uk>
References: <1393789977-29091-1-git-send-email-plai@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4341290470180712061=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 107DE264F02
 for <alsa-devel@alsa-project.org>; Wed,  5 Mar 2014 04:47:30 +0100 (CET)
In-Reply-To: <1393789977-29091-1-git-send-email-plai@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Patrick Lai <plai@codeaurora.org>
Cc: liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============4341290470180712061==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PjJwPjbdn5RfZuWK"
Content-Disposition: inline


--PjJwPjbdn5RfZuWK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 02, 2014 at 11:52:57AM -0800, Patrick Lai wrote:
> dpcm_path_get() allocates dynamic memory to hold path list.
> Corresponding dpcm_path_put() must be called to free the memory.
> dpcm_path_put() is not called under several error conditions.
> This leads to memory leak.

Applied, thanks.

--PjJwPjbdn5RfZuWK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTFp43AAoJELSic+t+oim9wnoP/izYNSQVh6Br1vCdAY4k0N7L
fr/BVCHo3KryccfL5k2jwPuUVdZfViGvisUd7wAdVEgJj82Fz2wcwxgFrLdubjK/
rnNpl2i7dr6s6oYHpACIE98ZjU5rxf37cQh282tYDcfsmpKPTEi/gz4hKScvJB3j
7ndopNKjjXt6JK4yL+AQ8ql1a9Ft2Grh32nUnjnwOi6hVwtCSSud6cgrJuk0XdWP
fFzgzJvaUm+n3l3Okwr5ZFfsWwgPpp9fjMMhRpj4eSrDqA/19ggA6ruElg2wDKep
g+0LaZ4JUNjqbSc/hPV1rI3ex0KljNBmSKZm2fXWSsXMWm7WB3inS93TwDT/39O/
pq6dS4JdsQvXSmloeTPHlhYx3NCLZEbok5CPjTR55NaUtogPpclY2RLrB9KaaDsp
x99zbM5jFXlnrhqfLwL+3I+JUPn56qKBI+4EBpVvpKITxgm0QZEaRG0Zyv8DL9Sk
20klmVt4SZdedA0L6Im/G7PAQSgELhRIzWFU5B/xJ2HW4N4aDbkbbrlyf+WTT93b
svRSiJXo3HZsxmVVxe+hLLw1Je4TOx6izV4DrMt8nGfxymd36AK5O2DOdEXVMhMD
Qzgbt+V6cyemePXeZTinrKFVozqUywId7QssVmi9oCvoXXv3SGESYkoedl+XzGtc
+O8Hz7+4YeOzLQoSJCwC
=Ympx
-----END PGP SIGNATURE-----

--PjJwPjbdn5RfZuWK--

--===============4341290470180712061==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4341290470180712061==--
