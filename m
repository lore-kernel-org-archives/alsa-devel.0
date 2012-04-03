From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 5/5] ASoC: sh: fsi: add FSI-WM8978 support
Date: Tue, 3 Apr 2012 13:31:17 +0100
Message-ID: <20120403123116.GD3192@opensource.wolfsonmicro.com>
References: <874nt2aphw.wl%kuninori.morimoto.gx@renesas.com>
	<87wr5y9au1.wl%kuninori.morimoto.gx@renesas.com>
	<20120402214233.GE3160@opensource.wolfsonmicro.com>
	<877gxxk58z.wl%kuninori.morimoto.gx@renesas.com>
	<874nt1k1yf.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5849174557723276041=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1A86D24528
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Apr 2012 14:31:21 +0200 (CEST)
In-Reply-To: <874nt1k1yf.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Rafael <rjw@sisk.pl>, Linux-ALSA <alsa-devel@alsa-project.org>, Paul Mundt <lethal@linux-sh.org>, Liam Girdwood <lrg@ti.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5849174557723276041==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u65IjBhB3TIa72Vp"
Content-Disposition: inline


--u65IjBhB3TIa72Vp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 02, 2012 at 07:02:03PM -0700, Kuninori Morimoto wrote:

> If board selects their CODEC driver, the driver will be forcefully included to kernel.
> And some of these are depend on extra config like I2C.
> I'm afraid about this kind of "forcefully select".

> Of course we can create selectable Kconfig for each boards.
> but it is just complex..

I guess, yes.  Though thinking about this further perhaps what we really
want to do is provide a way to list all the CODEC drivers which can be
supported by this driver and then have the driver select them all
together, that way we don't have to keep adding Kconfig options for each
individual device.

The driver isn't really particularly FSI specific either...  the main
thing I want to avoid is having to end up doing lots of this sort of
little update on lots of platforms - it feels like we should be able to
avoid having to add a Kconfig entry for every single combination of CPU
and CODEC unless there's specific code to support that combination
somehow (like when the CODEC has fancy clocking arrangements).

--u65IjBhB3TIa72Vp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPeu2PAAoJEBus8iNuMP3dWeUP/1IkWzddgsga0TUJT413y/ld
ZFo2WFE4VUq0dO+urnZkDDMjeh6ScuJ+4V7qTW/pACFe+JLF3nrIq4CH5/bm8XD7
Bm3X7WB9zF+We3MXxz9V1CX9yVq47XK9lAHwCyICFk/fvpeOnJw4tutQeEooKvVz
0CZmq3DmidGlohVi9qIFZuCyYBJH3uK6b8DHS6wcPW2AEJrggu9IzNisnxh4PkZV
tFejfzmV/UMhOD+kmjwyhE4U9XZC0UH2WCte5lZJNhhblnk8/XuUMzV9CuAEHN7d
pRhYtJNKRVb3PbYEtDK45e18Q5pPRI2LfzIz24uwdn0Z3bYDJeInAzCIGqE9Re86
tQX1COWLBydq5BQcW7/gEl4JwX5VquHV6jQQ7NUawFvczg3K2JaeP//znyoQcunA
ynBtNUz1S8HPTuInpLVMecjJOeIllNDFNVZz12DBYhYQQU9EXcrQRnUzCcop0CEN
o1Y4n6KmJgZIblGIZdlONCTGiYdm2/xIQCm5SbrKg4WCfCbYpoeKopT8KnP2E6l5
rTw8PYaLcEkkmpc+eYK/jJu2TSnnu25+8+uHnm3uvBkIFmZAD5+AhS2bmaW/3tmV
FAjyeCVMGnRwVddaPe0Z8TP+oZvr6m20+fK2m9WvHQP8VtrVvFiahcWSJmYhjLD7
PZ01cM7ynSTs9ce2GVis
=Z6cp
-----END PGP SIGNATURE-----

--u65IjBhB3TIa72Vp--

--===============5849174557723276041==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5849174557723276041==--
