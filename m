From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/5] ASoC: wm8903: Move pin configuration
 into I2C probe() function
Date: Wed, 13 Jun 2012 18:52:43 +0100
Message-ID: <20120613175242.GE7804@opensource.wolfsonmicro.com>
References: <1339211396-31711-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<4FD62A2F.1050204@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8532736558389041850=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 48F98104541
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Jun 2012 19:52:44 +0200 (CEST)
In-Reply-To: <4FD62A2F.1050204@wwwdotorg.org>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============8532736558389041850==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qz2CZ664xQdCRdPu"
Content-Disposition: inline


--Qz2CZ664xQdCRdPu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 11, 2012 at 11:26:07AM -0600, Stephen Warren wrote:

> (although I had a little trouble applying it; what was it based on?)

It's based on my work tree which has a couple of broken changes for
the device sitting in it that I need to fix up and release.

--Qz2CZ664xQdCRdPu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP2NM9AAoJEBus8iNuMP3dXe0P/0GQB6xPHldBzeLZiiSDDYJi
QIuDnwwH1vg7t15I+rKL+AF/9guROh7WhLV6ZUBK4PZ/BPzogEh9X7Vp2VrijW/U
qeRu89nP6RfviNDi875LiTWyTq94Gussg9CpyhVivrl1zNmk0vuAcZTiDayR3EcU
6WeBcdKrze3fZa1tbIKYF6l+C6TI3ktuHUjImxZRiA0q2YqbNHXtVymYhrp2LEFj
ZgK3JY6dORfJup937S/Tqu+avunrTepoy8tUcwztvMeIgOkFa+piMQdgp7vQrycM
WAtQPE9lR52xNSqfwIhPB7v3CKOERnGU7hZ3vEsv7Ym93F4avs/DCehYg6+BXKhs
nRHokVQaoB1tScVAzSJgP+dGC3NkP2qVMJnW9n/3mL0i62P8X5Cd9R0KVP+2/dUk
T90Vr4nXHkl8E2ea34Y6BqB+KYmUmuYAZAbPF55xdf3ioT9eX9WDwZen1SFPV9nz
x6H1p4mn+QiGfas1NoRxLyFM3m1+FsBUc+c0H7lAHl4s1Ff7fHob68Yf6vRbhQjq
LkOb7GUZtUYAC5skzmYcb81bP+AkGkrVs2Uw64UA4RdYXDAeTDX+Zh7IKgCWNYB2
ClbqFbVPyJ46M7Gfo+5nShvWDPo5zjMInmbp0XojFLM+z7shlYfb1KkqOHURjqoK
KmL9LWZ9hF6A4odjR5lu
=hiub
-----END PGP SIGNATURE-----

--Qz2CZ664xQdCRdPu--

--===============8532736558389041850==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8532736558389041850==--
