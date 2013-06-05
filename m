From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: arizona: Hookup SYSCLK to inputs
 and noise generators
Date: Wed, 5 Jun 2013 15:37:29 +0100
Message-ID: <20130605143729.GD31367@sirena.org.uk>
References: <1370440291-2876-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1370440291-2876-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8123120191515890990=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 8316826549D
 for <alsa-devel@alsa-project.org>; Wed,  5 Jun 2013 16:37:34 +0200 (CEST)
In-Reply-To: <1370440291-2876-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============8123120191515890990==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aIPTgi9H47uqouUT"
Content-Disposition: inline


--aIPTgi9H47uqouUT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 05, 2013 at 02:51:31PM +0100, Charles Keepax wrote:
> All sources and sinks should enable SYSCLK.

Well, the theory here was that you only really need to bother with the
sinks as the sources can't do anything unless connected to an output.

--aIPTgi9H47uqouUT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRr00mAAoJELSic+t+oim9wcQP/3Zr1a8BsmKRjUSrCIZBA8Z0
mFAbUa3CRUzx8sm1AD7Azl/LyAeYwjmOzfvxvO81tzmoZhcW+0WcQH8FnIptYhjz
qXuLgGYTX0LAVeip97LRiln6UKhxmpk1PR1Q4PGv8P3Iob3ohuGMmolNrhjMDuVC
eHnJ9G9d6j3FsceXI33CF6BwFk8zB00+vEXnYIiw52lNj7VLQUsiXRmQc4LAOOc/
53bpXu083lj1LwrWxwhcaH6/bUs5yxL/QnCdwXQrJQCkzxQ9PxfuvavO1nXhbAXB
9YchAnK/beeKELKh+NxrGraqRr+KB5GWlNg4qdPrEsPELZ30v7gTIg3uwt3XwtmW
OwMcDSO9TOj7yKBweR1okhIdXKWyg5aOzjmUaw8OQaMEPlw3w1BtZDZwrddbG0wl
JafqbsSR21W9hGf9KiN1PDJJymiymEmIRXHbQRlXWP7MHBazCifHtlcbrfQsyF0K
eGvkj2g8AyBYll+VXGfSbSnhc+XwRKxDYoI91xafEctUJmBRIHJ9iBLq205t8UDh
mcZdV1NW0JDJp+93Y+zpy5N3LdWog6mtjgantZBhDRK8EbzOg3VeloujumesuCkP
DceAo0yZDiMfeBH6JAhPlpsy6CZlWCuof1Zg900tFPU2bmREIbveJQafCYUwpN8f
d2ZzMtjz5wL+TtZJ2pAi
=Rs2z
-----END PGP SIGNATURE-----

--aIPTgi9H47uqouUT--

--===============8123120191515890990==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8123120191515890990==--
