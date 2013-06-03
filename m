From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: pcm: Require both CODEC and CPU
 support when declaring stream caps
Date: Mon, 3 Jun 2013 09:56:25 +0100
Message-ID: <20130603085625.GB31367@sirena.org.uk>
References: <1370124976-25047-1-git-send-email-broonie@linaro.org>
 <CAOMZO5Bwo4hFG4vkN+Xnnm4FFUO1Enbs+83Yx1C50KWW0mmY-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0281292981987443513=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 53252261A1E
 for <alsa-devel@alsa-project.org>; Mon,  3 Jun 2013 10:56:33 +0200 (CEST)
In-Reply-To: <CAOMZO5Bwo4hFG4vkN+Xnnm4FFUO1Enbs+83Yx1C50KWW0mmY-Q@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Marek Vasut <marex@denx.de>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============0281292981987443513==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XF85m9dhOBO43t/C"
Content-Disposition: inline


--XF85m9dhOBO43t/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jun 02, 2013 at 11:45:46AM -0300, Fabio Estevam wrote:

> Now I got it working and your patch does fix the "aplay -l/arecord -l"
> issue that I reported earlier:

Ah, excellent - thanks for testing!

--XF85m9dhOBO43t/C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRrFoxAAoJELSic+t+oim9zGIP/0kUS/BOgfaJum2SbqIzngWp
+j8XTvcDi0Dm5rR0PABscqbzLRYsKEMjZj/pYZ99SiDPUl0HGxygLqGg2B9NGRBq
Vba/SANJXRUBZQyJyvA8T7AWr5X4tRba3DAmuHmdaInm8T3y5iBrWQMXxf3lz8Y4
ABGsgjQTQKLmULao40A4wWzDXmX4WB1GsDZVGdkfBLPt+f+dzOYOu0ykDg6D5pI/
wrIfsvPPVX6CJXR8b4wCfwBbrbZQ5iqaloNigqIxjxEMT1aYgqi6tPr3fYVxJ7Da
i9FByIYuehx0fh3PUjLNSzn3X5XepXWgviUuUzPu90fRX2Er3H0FsfmjPwsA32JM
X+7y4EfqSKA5jQ+LMO/FbeinFLdhHhHPkLwvDfbazD/sGZgS6v6va436J3JY94if
B6d+jv+1I8l7njsGSsbA9S7jUA+gF2Hc7v+6wmE6+1VBj9x9q/dAwVVkfrN8NbbB
yJh+z+q6wlFgZTTcDe4aBB81Zqk3hNxQ2inVH94x8N89uMBQ2dRw6wQMmRieEdh+
g7Eq5wn7/vS6G2kRBIYAKdeYmrbOLzsRNYWh2FREPBJqraV7XPPHa69HFaqcymZh
SG1vjJUaquQwFPnwbMF4MzhF2qumBMyKZ6IEF/b8YFTeKZ8C4JITRlvgyZszNyct
PMbFcp6U51pBFP9Mj3Wq
=SQ1F
-----END PGP SIGNATURE-----

--XF85m9dhOBO43t/C--

--===============0281292981987443513==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0281292981987443513==--
