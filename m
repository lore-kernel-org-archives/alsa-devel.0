From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] SoC: dma-sh7760: Fix compile error
Date: Fri, 22 Mar 2013 12:05:39 +0100
Message-ID: <20130322110539.GI22890@opensource.wolfsonmicro.com>
References: <1363343175-14744-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4436003888734788128=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 83D612664C8
 for <alsa-devel@alsa-project.org>; Fri, 22 Mar 2013 12:05:41 +0100 (CET)
In-Reply-To: <1363343175-14744-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Manuel Lauss <manuel.lauss@gmail.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4436003888734788128==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="N8NGGaQn1mzfvaPg"
Content-Disposition: inline


--N8NGGaQn1mzfvaPg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 15, 2013 at 11:26:15AM +0100, Lars-Peter Clausen wrote:
> The dma-sh7760 currently fails with the following compile error:
> 	sound/soc/sh/dma-sh7760.c:346:2: error: unknown field 'pcm_ops' specified in initializer

Applied, thanks.

--N8NGGaQn1mzfvaPg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRTDrzAAoJELSic+t+oim98oAP/3XIGEwxtyL8PTas6iZ4RIyi
h13wSHkUYROX1QwB5tWKohdY3oN+3rRJyvgmHBamzyD3FZPe5QZP+7RkSOQSFY4M
W5dOWyd5+vZ0YT5TB5UsXfEtrOT5A1+GiwP4nCED/7gBvesbwVibzXc5rC4f4kZW
9zEA+qg7I8xk0oK7HvzTytnfksTlEEu5bD9OWnC8nII4CBitbBs0t0IohGdACKJp
fHVHdIjjiENgjmt6iDJ/anByoLErJOWWwwlxFt8MxWYVxefOGW8KXodQs2F6TMS1
ZS/oAcRolVcg7CmcTM0lwShHmzxsAhigqsupPZ3ame7ML5Gwa0coalt6itXeW8vg
k1fCTZts4ksj6vdmPHNjKOK7hAGoaKM8LLKZXb+wHAGAR/x75g1/DIlAJaWQWlN2
9ekC7FUtHbBEUAIVgtHQ2FFChTVlS2P3tN3wfceDDwrUUDU7uNYHBXzvj17WCsVB
ZoT4k+j4n6pb4OCKZs6jlKtZc+7tQd57FJzgEuqRaMPBZNkdfOmdAmMvuZqLFWEM
CNz5+9VXWNlVMh1KdBpncZXD334e4dIQxEAkpsjtMSyqBrAo0VSYBGOeBHR3XxRP
yobntZC6EfUegNsKjYJlFz79huIBVyUIyEgFezxpEDT8RreJSrE/af5kTvE5ZuKs
a1e8qbP5l12FiPJLrdWT
=/2DK
-----END PGP SIGNATURE-----

--N8NGGaQn1mzfvaPg--

--===============4436003888734788128==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4436003888734788128==--
