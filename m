From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: dapm: Add platform stream event
	support.
Date: Wed, 7 Mar 2012 21:01:42 +0000
Message-ID: <20120307210141.GN3107@opensource.wolfsonmicro.com>
References: <1331137979-25731-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2747832339988574521=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 43F8A10412C
	for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2012 22:01:45 +0100 (CET)
In-Reply-To: <1331137979-25731-1-git-send-email-lrg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============2747832339988574521==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JH9OCe1BwbSt0K9U"
Content-Disposition: inline


--JH9OCe1BwbSt0K9U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 07, 2012 at 04:32:59PM +0000, Liam Girdwood wrote:
> Currently stream events are only perfomed on codec stream widgets only.
> There is now a need to be able to perform stream events on platform
> widgets too.

Applied, thanks.  This is all starting to come together really nicely!

--JH9OCe1BwbSt0K9U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPV8ueAAoJEBus8iNuMP3dHw8QAJ6MVnumzh63o88zG1nF3xVS
KhA/EPbZPIEmMLrBjevnVVuxi0FvQZdBX8kAEBI5nV7eeF7AX5Rrn3wHvR01thMw
QjclEO47eUgJjdujrSURMo6SonfR403caqxe4YgkYD5meHoqfLUc6TE7DAKdY9Fs
z470qYtUr4arnO75B97kU8on1KBRLjhh3eQ9ieDFZP5Qwjqb7ZkjLLSonOD0uZ4f
qOQkOe+RWPtZBW6GGx4GEO4Ulq96SE/OHBW0YK5y6nRe6BENoo6VjZu+6xvHahBf
ao9a4BTqGJSoJu0EN+KguY12OUa6C7OwlPOtU5Wn2d7Lo+NxP8oN13mZfpD/EedK
WaJO+twaZcYpIbteF0K23InG6z0DdPGF0PLJmGVIYKp0rMEErl6SRYzb83iXnWnP
yH6fTw+RUtr05IpXy9reQO6Fxu3G1pyuNHtf3fl/v/k0G5Db6Lt42jMESu03aCXu
NVh8okhTO39uzLEMKbvWR6Ve6htOThMBghybJBug/gu+wpfNOJPvv+klolrdeQwO
iR3scGJ9FrDuAvn/yN6+rWgraq6b8KRNB6GPYSGXtdXSdSxINwEVwdiFBwCL3pjQ
kkyopPksvfDn7bJK+1Au6qQ107S45iU7Y1Hyj8hUrtbR3UUNDblG/5Wkw0IIQXjz
Y40voLDxFlXnBvXZaHLf
=9QYe
-----END PGP SIGNATURE-----

--JH9OCe1BwbSt0K9U--

--===============2747832339988574521==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2747832339988574521==--
