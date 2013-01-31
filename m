From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [RFC][PATCH 2/2 v3] ASoC: simple-card: add Device Tree support
Date: Fri, 1 Feb 2013 01:11:59 +0800
Message-ID: <20130131171158.GA15376@opensource.wolfsonmicro.com>
References: <20130127035943.GJ4650@opensource.wolfsonmicro.com>
 <87vcag3hcj.wl%kuninori.morimoto.gx@renesas.com>
 <20130129014808.GC4748@opensource.wolfsonmicro.com>
 <87sj5k3f83.wl%kuninori.morimoto.gx@renesas.com>
 <87obg8z4u4.wl%kuninori.morimoto.gx@renesas.com>
 <5107FF97.1070601@wwwdotorg.org>
 <87halz82bm.wl%kuninori.morimoto.gx@renesas.com>
 <51097F0F.2030501@wwwdotorg.org>
 <20130131013500.GA4759@opensource.wolfsonmicro.com>
 <510AA551.30400@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1963437220710323606=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <510AA551.30400-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
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


--===============1963437220710323606==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 31, 2013 at 10:09:37AM -0700, Stephen Warren wrote:
> On 01/30/2013 06:35 PM, Mark Brown wrote:

> > I suggested this because it seemed more legible to repeat the
> > properties by having a named structure for each property rather
> > than by repeating them all with slightly different names.

> So the only need to repeat them at all was if the two DAIs needed
> different values for some of the properties rather than being
> identical (e.g. signal polarity) or precise inversions (e.g. which end
> is master), right?

There's more attributes that we might want to configure on the devices
than just the actual DAI link.  Clocks for example.

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRCqXWAAoJELSic+t+oim9CMMP/Az+KtaXSZQbONOKhhAYfw+/
7KxVE4SX7j/ixgGKSxAqXFcFtnkTky2Al3lYZ9JqGiA2MCvcBCacD95pihHK3xk3
JVCNVomeqgPZVWgSCzVpIQv5+8HhHYb7uvz1s456Y97TH30ySk78Y5AGKcjMGl0D
g23hNph8b/Dfg8aydz6dpGKwhbsrTor0v8zx/RarjUcvraHdFZ7UK/9uq+1D/qCq
4yjDhXTK5uyOswJEZSsiVu6j13u+f5/OkOHR+CDW8X+dDjQ2SS4QdzL2g1a7VOx7
ztKDqq0DFqGc0gS8Q3fCF9uztEOapktzYhbrXHVrhL5KEWsWsfSoiLhZOIih2+SQ
pz/x61PydLxkSpkvmJdYc3aWxIE+6cddNSR7aFtMQ3Qn3sRHxko/HdSKxQbpdPp4
NFTdO8IjxBTeNWRT85HKtQP2CtL6zc9fB3i5ow38Kg0d/tuiz6p4v2MvhMP3NXRu
UElk4sXvIozk0d10lmiwsEJ0sG1RX2MdaNZVfqic9J8rcyHQGy9S/wX8RIGngCnU
l+OtcsX9UHqYps+c7IbezrekvO4Rxx5RQJcKl2XrqUQrac+5U+dPxJV7QJwfl6xN
3FtBaJ06Z6QMoSHviY84BBZfZcbqXjQD7alUva+s/eddPlmRC+a6ZuY4rQr2yfeJ
l/JY+MO+cCFLxAUAM9ib
=B2Z5
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--

--===============1963437220710323606==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============1963437220710323606==--
