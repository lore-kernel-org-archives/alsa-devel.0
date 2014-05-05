From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Make soc_find_matching_codec() static
Date: Mon, 5 May 2014 12:29:38 -0700
Message-ID: <20140505192938.GR22111@sirena.org.uk>
References: <1399223910-28710-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3318743870905264774=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A41A26501B
 for <alsa-devel@alsa-project.org>; Tue,  6 May 2014 02:58:58 +0200 (CEST)
In-Reply-To: <1399223910-28710-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Sebastian Reichel <sre@kernel.org>
List-Id: alsa-devel@alsa-project.org


--===============3318743870905264774==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pqmPt9oPL4cuP/b5"
Content-Disposition: inline


--pqmPt9oPL4cuP/b5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, May 04, 2014 at 07:18:30PM +0200, Lars-Peter Clausen wrote:
> The function is only used locally, make it static.

Applied, thanks.

--pqmPt9oPL4cuP/b5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTZ+aeAAoJELSic+t+oim97MMP/0c9/PF9lX+IAVKjwGatmpu0
PyRjB1PSwbG+Y5SJW2XZ8zvf/McB+pbCl2kzxeQ8QhaN2Es0a3oZmIhn0ouUuagj
Gg9q2dMrwVyMY5Hwm6ZrgZu939o+ogu1dw3kK5qKri70MOKrGMnI1Gd20w8CSthf
abog73IkZuDf7xaK5vJzgGkpiLTyX9czkDl/ZlpZ8iwPDL+AOx6Axq9WuIF3xMmJ
3Eu/fdVvUa9Eh51MjTe3tHYhG6i6EAMN5GNd6XQ8d8cg4Z2ajsRdGPAzv04aNwH7
lfoGrnk9QliwwJBctqf9qnymvceHLPNIq62rOFhklnMw67Xds03owZXqlbwTAUQG
IFnsLkTg1CQPTkt0B7+8+2SZ5jfE/Phb4tAi9dF4mt77DS2pZOWw2Ak50bIO/F3i
8Mw7fIZ5QoL/zsbbraIP3EVtaOYcIc8RVBG3okrZvUz14RizeFvC85pauP6RMlQv
AmTPNDCEZktErLf/oc0XmNCWa0lOVCyDLQIDOwt3VHK7wuJnAiSIE5wy2SN8njNX
x/9tJJ0vX9Q0QZVSx/e5rbgnU01MuY4BfTkBG6d1Hvajv7p5J1riOcFvqsS25KYZ
Z3fRMivzKGQTQdtJMRrzt9fh8t4ZAdMi0aEHp2tg7uuoBaFnnJVeLH8rWMFSRxzS
RNG+4jSpYVY2R2ljACO4
=TdCs
-----END PGP SIGNATURE-----

--pqmPt9oPL4cuP/b5--

--===============3318743870905264774==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3318743870905264774==--
