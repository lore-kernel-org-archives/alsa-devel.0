From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 03/12] ASoC: mfld_machine: Convert to
 table based DAPM and control setup
Date: Fri, 21 Mar 2014 18:04:33 +0000
Message-ID: <20140321180433.GJ552@sirena.org.uk>
References: <1394634460-15889-1-git-send-email-lars@metafoo.de>
 <1394634460-15889-4-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2085046838888295143=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D5812610D6
 for <alsa-devel@alsa-project.org>; Fri, 21 Mar 2014 19:04:48 +0100 (CET)
In-Reply-To: <1394634460-15889-4-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Ryan Mallon <rmallon@gmail.com>, Vinod Koul <vinod.koul@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Daniel =?iso-8859-1?Q?Gl=F6ckner?= <daniel-gl@gmx.net>, Benoit Cousson <bcousson@baylibre.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org


--===============2085046838888295143==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="enLffk0M6cffIOOh"
Content-Disposition: inline


--enLffk0M6cffIOOh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 12, 2014 at 03:27:31PM +0100, Lars-Peter Clausen wrote:
> Use table based setup to register the controls and DAPM widgets and routes.
> This on one hand makes the code a bit cleaner and on the other hand
> the board level DAPM elements get registered in the card's DAPM context rather
> than in the CODEC's DAPM context.

Applied, thanks.

--enLffk0M6cffIOOh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTLH8uAAoJELSic+t+oim92cYP/RlQbjdO94oLhf0Z8Nn3db8F
fLoki0KrJnBdycfz+QgXSBEdMQqReZrWBlYY80h3Si9eNu8g6faQVjSo7OEZLTaY
rJdMPPE6YoSXfWGojDD3DTl5kgUpKRKf1Vffjf/uI5p/QQNxcxzHLZroV0dzgeNv
lJZblCzS3go7vvvnfXllcomewIGHSKmVe8xqfFjsgoVMjMILuX3XYC9a8oUR80tI
4Hi8Oa13YNtZq4BZTzA+0dL/YgtteBnxeXZYYbMeh5/a7jXNrfCEzoi0q0Bs2bjN
77mZ5jKlUC1/B/xTHczD4TCQOLWitgTeFRqNL/LuB44Z/ZiaxZ7WOMA4NHy8TKO+
x9aPZhBzfeOf0UpuATg34YjYyT8W2jyGGB6/VUy3B8ANs8ZLXaQ0U/Gt+pBbfqIi
Z2IM3dxR7fDqPkLrVYvnUqPdMqeqqxWhKEuuidy/ueUJxoobsVjRyaWb9LEubjab
bAq+e1TDAeeIlgx3TCt/XXdO9pGSlLy8NlDYcNxyEJTYG6JMwCIJTaktld2K5Ksj
W8NbzLLny6qxVLRsDAgrXgZheBmQu+NeV7mggASeQSiuFPnGLh/6R1hh54JWNiTT
JZs8LybA3HtUGCsdN3Ttg6/kCfITvmXGV9u17Kov6U83QHCzaX3MptKR4pKq93G+
6d28MnwbRIk3lZ57FMeO
=zI5U
-----END PGP SIGNATURE-----

--enLffk0M6cffIOOh--

--===============2085046838888295143==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2085046838888295143==--
