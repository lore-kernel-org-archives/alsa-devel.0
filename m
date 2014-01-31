From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] ASoC: davinci-mcasp: Move pm callbacks
 from platform device to soc_dai_driver
Date: Fri, 31 Jan 2014 16:41:05 +0000
Message-ID: <20140131164105.GO22609@sirena.org.uk>
References: <1391088092-4157-1-git-send-email-peter.ujfalusi@ti.com>
 <1391088092-4157-4-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1016507806866588484=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 25B402625E6
 for <alsa-devel@alsa-project.org>; Fri, 31 Jan 2014 17:41:17 +0100 (CET)
In-Reply-To: <1391088092-4157-4-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, nsekhar@ti.com, Liam Girdwood <lgirdwood@gmail.com>, jsarha@ti.com, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============1016507806866588484==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LQyQLyduEnelPo/g"
Content-Disposition: inline


--LQyQLyduEnelPo/g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 30, 2014 at 03:21:32PM +0200, Peter Ujfalusi wrote:
> Handle the PM callbacks via the ASoC core instead of device core.

Applied, thanks.

--LQyQLyduEnelPo/g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS69IeAAoJELSic+t+oim95RsQAI7RrOztyhZWDWfWmywDlOg7
E109mmr6Fsl09nyuj1Gk1cH8FqxtfDSTpLfc+DTpyX6Jjle0TucAIBw9SnxjL3Ge
aiMtcQmvoSAMMz+4Cv/N4yCgTlscBW0GCgZ30Os1LwZ/ghrF66aVVeAUJLUxqer5
jp2yVi8Qq6vYyKVJ9GYsF/4iR4GwnhynW7rxW6x/7asAmamU/uOMlNGt3cfTkrpu
xNL+6coLGzXBXMQruKLt5XgFtdYw5fbajk4vGhr4rXt5tFS1p8TT6t2uhV3B91EX
OZCLM5SCt/+GuNouPtRyqCdaAFFXClPiR+w9dkWM4DBy84z78DVbfc99I1cGtGUf
taImuwFBA0aj+o5D3gDbuAE8ZLF1eSXkYPnmt5xIfHyXuEomaJtiKOp1weu94sO7
uBYa95Fc8y6c+i6lU6NuMY3vg0WbptfH3ilqxFSW678p78Wn0lVGvXb2OANoKUPy
F/q3uAzTEXth29DgD0fnYL+v+UXFdI/EmbaxWrpbupsCNYC33igdSRTkv9uaDYpx
uZkuZF4MtgT5rYWVO/OfZEod4vQvKdI4cZx0jsjIU4jF2k/geYczW5OsVFJcC3pk
T964AYr4hOKZSYfETA/XwJDY9nSYey8w6OG8sd3j/t95UnCk6d4ADACSwgb77QTF
/P9aVjfN8ZKVNhbhoxF1
=lWqj
-----END PGP SIGNATURE-----

--LQyQLyduEnelPo/g--

--===============1016507806866588484==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1016507806866588484==--
