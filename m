From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: bf5xx-ssm2602: Set DAI format
Date: Wed, 25 Apr 2012 11:17:06 +0100
Message-ID: <20120425101706.GJ3195@opensource.wolfsonmicro.com>
References: <1335346188-29823-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1705783361669255078=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A652A10486C
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Apr 2012 12:17:08 +0200 (CEST)
In-Reply-To: <1335346188-29823-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============1705783361669255078==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/qIPZgKzMPM+y5U5"
Content-Disposition: inline


--/qIPZgKzMPM+y5U5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 25, 2012 at 11:29:47AM +0200, Lars-Peter Clausen wrote:
> Commit 980b0bc69 ("ASoC: blackfin: Use dai_fmt") converted the blackfin ASoC
> machine drivers to use the dai_links dai_fmt field to setup their DAI format.
> For the bf5xx-ssm2602 the commit removed the manual call to snd_soc_dai_set_fmt,
> but missed to set the dai_links dai_fmt field.

Applied, thanks.

--/qIPZgKzMPM+y5U5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPl875AAoJEBus8iNuMP3dLdIQAJqedC2GCitvMX9RzV5u3dlM
Alh7mkhNEGDiGeJbkODh5fi8VT2ROTFalFm1ONz+BStYCnMX3S8ohISXS7Zfnu4i
kTLO22/xQ7824xdVHqeLUMS0+J6tAhRYo5cMsbEY+ZN3DvIvzByDzmsUo0dtN99J
rgy4H/62ISYOBDhYu8ogbM9xSjAZ2zpQnKtByAFk5F4LgZKmQAjR6BCi4rrltqFt
YIAkuI98eTYcjF83FqCjdNtugYJ2BYBwsTcDOkIXppp/BgMdpyU/QtjENIVKbPSd
icV5aFZA/6NiCqUvULGpfuN9uZCrdb4h1/F6a3ToL98WuVNoMiG2FjheArDm1Pow
Tm3ElLkDc895iA5rW5GSLtfyqzTg9eUFUrHPgXK6Hycd7A3JCRynWUJWuWLSGmn+
RdVOodF3R8lOwb7+DknsOep79KsDaDEKV5CEru1E2RzxLCjy0rE01qLgoQN2dl+5
793e7N3UH8SF8Y84p4h0h8Q5ziB/W1/N2oUyYlxd0uA40nK7y5FWrRfMWjxV1DXS
NpX7x9AOuOCTPgrb/W8OWw/DleqjDv5pj8b/ttZTh6NIzZIBEffSii+YrvETAKjK
uNf54fGTAzMS67kU9D6MUVsGI+BnAgrKDW++PYrGmk+DRi/HzlDHz6sAdUXnQ2vU
7X5m8t7NxuG3Q1OKSPYn
=FsNU
-----END PGP SIGNATURE-----

--/qIPZgKzMPM+y5U5--

--===============1705783361669255078==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1705783361669255078==--
