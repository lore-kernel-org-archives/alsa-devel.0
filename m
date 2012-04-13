From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V2 1/3] ASoC: tegra: add tegra30-ahub driver
Date: Fri, 13 Apr 2012 17:09:08 +0100
Message-ID: <20120413160908.GY3168@opensource.wolfsonmicro.com>
References: <1334097121-18897-1-git-send-email-swarren@wwwdotorg.org>
	<20120413101748.GO3168@opensource.wolfsonmicro.com>
	<4F884C29.9060307@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8231984023724391189=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 10572104419
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Apr 2012 18:09:11 +0200 (CEST)
In-Reply-To: <4F884C29.9060307@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============8231984023724391189==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RLVVO53zhS75EYih"
Content-Disposition: inline


--RLVVO53zhS75EYih
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 13, 2012 at 09:54:17AM -0600, Stephen Warren wrote:

> BTW, you'll notice that the AHUB driver uses the same REG_IN_ARRAY macro
> as I used in the Tegra20 DAS driver's regmap rework earlier. I'd like to
> just use the same macro in both places for consistency. Are you OK with
> the DAS driver based on that, or do you still want me to rework the
> macro in the DAS driver since the use-case is a little simpler there?

I'd prefer to see the DAS driver reworked I think.

--RLVVO53zhS75EYih
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPiE90AAoJEBus8iNuMP3d17oP/ijEcUYpgLFcEOF0Oej2lxZ1
v3xWGmAQYtpSpsRXltebjYTi6Q1xHwt1pZGfxwi1OWuqZw4bPwhEsh87sj2bGfcf
vcwKW2CFleAKJ5NrYIEg4txgBw+VklPa5aGR4Kg6ez4IdY6M7m38lXdH/jOhaBQ9
wrT0KXB3O9HUTHvoBrqDmvJeBp1qw5RKM622QEfBnZ8MlG5mq4ivpzX6A32K8/2q
FF5Giqopu7TfQBk5tmwd0ovTF3Bg5HBsIzD7rrvIaO5yVmudMzxTbCgPcofbSYNK
BaUmzhC6YhyZPGnciKTnPh00gqtfkoBergyDjf03U8bNx+T9A1vKB9xVQmW3sdQ/
k5eEL89abO/RskYxvu0A8tisniTgFgdhyIfg4tRB88UzfTqpGxWK11ORXLx84qCH
R4nCK31N8h9eApZ26E8xQ4uqS+jeUlbTjoBLXmnGYkTEttRtau13vfUj+DhgIS8N
NtwfNRTjVi3wlO3L5YI8BhkoYMFttPX+LFton66019Gm3AvOEncpnvaeVka+E0ox
dHQvQvyeayadUJWcgZVDd67c4IAxNnquT6L7iSg0evKrH+my5+vPcMHtk0xyDHJN
KFjzh07dA5lWELW2KNl2C4EKiUEvso+ucvU/ONAy8gXC0t6LTIjZ5nRc3qy0Kx8l
Ir8jAoC7DWB0qpQpyCGc
=5CiR
-----END PGP SIGNATURE-----

--RLVVO53zhS75EYih--

--===============8231984023724391189==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8231984023724391189==--
