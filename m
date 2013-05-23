From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: codecs: adau1701: refactor
 firmware loading function
Date: Thu, 23 May 2013 09:00:26 -0500
Message-ID: <20130523140026.GC2412@sirena.org.uk>
References: <1369310281-4323-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6560311004045923809=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id E6612264F3A
 for <alsa-devel@alsa-project.org>; Thu, 23 May 2013 16:00:29 +0200 (CEST)
In-Reply-To: <1369310281-4323-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============6560311004045923809==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8X7/QrJGcKSMr1RN"
Content-Disposition: inline


--8X7/QrJGcKSMr1RN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 23, 2013 at 01:58:00PM +0200, Daniel Mack wrote:
> Pass a struct i2c_client * to adau1701_load_firmware directly to make
> the code more readable.

Applied, thanks.

--8X7/QrJGcKSMr1RN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRniD2AAoJELSic+t+oim9lTQP/iuWMQGHprXT8qHu+uZug0yZ
C+C7SuP/LHVIUgNuCbAnrSM/MAcKf2iJzXHKgQhzV860rqbWerjSurA0gH9NWI0b
iuvB+yBkkTJNPgmcAgMN0EtVqe1yWVB673OswfX35i8tpPrimhdDFC6CbsbOB+Vd
yi6qReV+/Hrwist4L7rDb2PxoodIsBQaY2AF21TRTCrpJqW5mhaaVEOvAy4AuikW
NjsGApeCK3iK7EoDWDEyTnHxuJ6Ko1rFh4m51cebcGA9+pqnQXid7CXCpoHYjE7K
5mPPyHLfVHpMa9zF1IY1qnwu0zEUkEtpllEVF7tjSVfnQrG0UShHkTh3NvX0qTYj
/Xy6z3jHH3jYoOo31lcXsrE9B+J+6yvFQ+I8f1IFJv20uOPWPcoBA95zcTD/FYKZ
tN1GV+QstakRByH8i30Sly4Sv0Z0ZC5bbiqTuCPS64owDsgRHo2clIVlBS+2JCdJ
LYhHqMdKpSahi/VGtEUxKigSm9kY1cIi2msisGhYgCX1luh+WI6Jpuh8uklKattm
AN83tWDo3JhAmLFzDAOkfASt/Hs4xci0rRAuIic2RD83IlRi1BPL0fP9vcW3RjkB
6jwVouNTtYhl5LB1E3Vn4VRSktqdosTmTt3mlr8do9lVxruCk5yIHNUBxMBmYhnU
cZ6pCLxRvPgY0ECAgpdO
=JfQW
-----END PGP SIGNATURE-----

--8X7/QrJGcKSMr1RN--

--===============6560311004045923809==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6560311004045923809==--
