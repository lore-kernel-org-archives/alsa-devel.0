From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [RFC][PATCH 2/2 v3] ASoC: simple-card: add Device Tree support
Date: Fri, 1 Feb 2013 01:20:44 +0800
Message-ID: <20130131172043.GB15376@opensource.wolfsonmicro.com>
References: <20130127035943.GJ4650@opensource.wolfsonmicro.com>
 <87vcag3hcj.wl%kuninori.morimoto.gx@renesas.com>
 <20130129014808.GC4748@opensource.wolfsonmicro.com>
 <87sj5k3f83.wl%kuninori.morimoto.gx@renesas.com>
 <87obg8z4u4.wl%kuninori.morimoto.gx@renesas.com>
 <5107FF97.1070601@wwwdotorg.org>
 <87halz82bm.wl%kuninori.morimoto.gx@renesas.com>
 <51097F0F.2030501@wwwdotorg.org>
 <877gmuqir2.wl%kuninori.morimoto.gx@renesas.com>
 <510AA6CB.3050809@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0283266970476904831=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <510AA6CB.3050809-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--===============0283266970476904831==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K8nIJk4ghYZn606h"
Content-Disposition: inline


--K8nIJk4ghYZn606h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 31, 2013 at 10:15:55AM -0700, Stephen Warren wrote:

> In that diagram, it looks like the CPU-side simply doesn't receive a
> system clock at all, so it's recovering any clock by multiplying up the
> bit clock.

Practically speaking this is the case for most simple CPU DAIs, unless
you're doing DSP or generating the clocks you just need a clock that is
strictly faster than the data rate, synchronisation is irrelevant.

--K8nIJk4ghYZn606h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRCqeNAAoJELSic+t+oim9+3AP/3lBY1cddgQ1q+jegAJKc+nf
Sfyhx841bqlCdFAQ6kXMg/KoXA8hrZzCGmkdxWaHjpIP8cBgC5fPRWIVnBpWfG+B
MLUxce7tuUwztFpygaPGusRoNxDIoSV4xso74eKBTtMGXpvgb2jpRO+WV1Z9LuMa
RgaVq8taQ4eDCG1DKmkb+O7pVpcGZ4IZP8DYIF7rqjxQU5z8R0WaomzefI/AMZpx
5A/CJHadHXMjbnT9hjsf6Fv8dkOl0qp7uQMLxY0SUszALHJwhaeo2ZpD48sKC3vF
9SgsyQeVhy8mE3C77n2FZ26SrA4gsBXbD5s+GJR6wyfg3iFdW+5aPS5/Iew4Z3nb
+d8sgF3ZkNi1psti2n6mZMIPJ2CVTNFetgv6VcdsnQE5pO79+hz8haRG/InbeeSX
nTZoOWC3m2zvvgVpg2A1mBkHGIjfAdAVZc4nKDaMT6OAhcloBQBnx+VNHibZ/R5D
4xpyo61NkrOtlsHlldeklYfu6UWMCm2x49EwURg0bbx+2iS99gx1o8PKoxgPFMjz
c5X8D2VpC1fY2Ry9hLtmyF0uwIz5ZJGxHIG7gN/FFF2MaI/5Z5rVmRiWVhMR9tdj
/guTjZOBO/tuwAowz87Eay3T31isQ8D4pyA+gKWyYpCk0NeRgY44dklT4J+Q0D80
dJBYYjaPa4VK9jdUYs/5
=Spdn
-----END PGP SIGNATURE-----

--K8nIJk4ghYZn606h--

--===============0283266970476904831==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============0283266970476904831==--
