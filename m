From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: kirkwood: fix compilation warning in
 kirkwood_dma_open
Date: Tue, 1 Oct 2013 11:49:51 +0100
Message-ID: <20131001104951.GM19304@sirena.org.uk>
References: <1380463213-2720-1-git-send-email-murzin.v@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0787655398292825154=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id C40CC261A8D
 for <alsa-devel@alsa-project.org>; Tue,  1 Oct 2013 12:49:53 +0200 (CEST)
In-Reply-To: <1380463213-2720-1-git-send-email-murzin.v@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vladimir Murzin <murzin.v@gmail.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============0787655398292825154==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M70YYmmjmThh04Jd"
Content-Disposition: inline


--M70YYmmjmThh04Jd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Sep 29, 2013 at 04:00:13PM +0200, Vladimir Murzin wrote:
> writel() supposes the first argument of type unsigned int. This fix the
> warning:

Applied, thanks.

--M70YYmmjmThh04Jd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSSqjLAAoJELSic+t+oim90BgQAIQT+MRpS8Xn1728qVWFfTaH
bLgpMTGsOnVfJAU/jjy1W6rJ90Ibp5+1pK5QHnnZA19VvBiPvG3iNACkMFa5WK0R
MnIuHtOSqOvqJxR5Yo7QxNaFGJUbkX+UoSWH3MT9JfEqO2bOcgPBwIsxDs/wWZNE
v9q0Gr7Yvhvzkc409Sg1l6XKtY2/Vx5gb+yJzUCUIBidKm567kzZ4RLV7AFDFuJx
pKAoEeH726cVHl6a5pT9SjwsvHNlgkSrRw7wwlnWJBGsO3NYMtFQGmuxEsRxUnqM
25vfAqCr+HuedR1iMcERLsQTIfXuhnsiq46K9j+ps0ioY2IgX1cMEjikc0Jho6pP
amK+kM+yRthnh7JXJS53sWpxj5y82/68JeN/902JLYa/1Hl+00i7+tqqueWqRnVc
hcuRhHrOzwRUXerXaiXKDfExPxjR6L1/cb1vdBf8RbYt68nKGgl+UddcqceyAj93
gVdTXyWWrHI+W8U0S4EPyIo3VmP/IcOzas/5bZo72M3zQaqOSFO5AKHc83JMJl7d
ta0vidqYxfT9og7EhJ0ZChVC3ZoGvk6OGIMd2tazqUo8gkkbvhPMbpQD5oRYN3Pd
2Esn+oC8Eq1Q6djq80Fj8c/EbKWEgvZef4zmME2YOyQvpN/myeU2DaIQFRiPUesC
9zliDc6xcFt9WTikIV8A
=twwA
-----END PGP SIGNATURE-----

--M70YYmmjmThh04Jd--

--===============0787655398292825154==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0787655398292825154==--
