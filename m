From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: lm4857: Use table based setup
 for DAPM and controls
Date: Sun, 28 Jul 2013 19:09:41 +0100
Message-ID: <20130728180941.GD9858@sirena.org.uk>
References: <1375029929-19036-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1813051234942973800=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 7090F2617B4
 for <alsa-devel@alsa-project.org>; Sun, 28 Jul 2013 20:09:44 +0200 (CEST)
In-Reply-To: <1375029929-19036-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1813051234942973800==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cDbX0hrGVz5yRR/6"
Content-Disposition: inline


--cDbX0hrGVz5yRR/6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jul 28, 2013 at 06:45:28PM +0200, Lars-Peter Clausen wrote:
> Let the ASoC core take care of registering the DAPM widget and routes as well as
> the controls. This makes the code a bit shorter.

Applied both, thanks.

--cDbX0hrGVz5yRR/6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR9V5hAAoJELSic+t+oim9gtAP/3Jbol/i+jmhwYKSYbXUIqux
G0uXisKjNSvZTCHKL3pHdv5jeOVLv7zGvA4pRyNgf7MdfdvDJua0QlXBHU88V9Av
tMRWEAO1sUNf3IVqExVaf6sajYSqg/sfShp88RyQCaXa9V83a57h+VUgbI7xtCyD
CU3Z0Y27uaG0bOB61/vwumlYAf8zBbyrw1/lKkly2gGPipudTio9GbikTUfbJHNc
Q8rF6jKN53/7sPLbFtG/c9ZzW3dXm3mOeJiipaTWtzw+cXqXNdJuunEl5jevgGsz
6HMOPw5khA9qpxjnNeKxWi5kcttjAfCUrETMpSY5Ff3Dq1UD1JL8IzZEUyEv9ia5
g4vYr3ME9enO7IKgsBF3gnTwA/Jb5CH3av8E1aMXBCInGKSHZFyXpV4ezPXVvw5F
hE54ShwVXpu0YZhRqsw/XgYdm7Bqinpy6EvycRViGWaht3XpkhW1HSKfUq9CbIE2
ej8rrYu6M4PRGgHXp6yiNY2qjuRLLkf7r3LGbyCuIe1FA+VwSFFW4JFxq++DDszn
7cWM2lh0oJYAwSJoVq/eT4FYPA/B3mV6gh7OCsRxnAcUVMzrGaraL5+XcP3GCP3d
DrjkuJlqQlyQcpF1aNZzd2rABOy3nLtoe1pNeHgOlVSBr2TOBvMekPiOaWrB5+T+
67imkivfbdglPDF9YLIx
=c4re
-----END PGP SIGNATURE-----

--cDbX0hrGVz5yRR/6--

--===============1813051234942973800==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1813051234942973800==--
