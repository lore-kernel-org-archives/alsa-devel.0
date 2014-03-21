From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] ASoC: rsnd: add DeviceTree support
Date: Fri, 21 Mar 2014 18:18:13 +0000
Message-ID: <20140321181813.GP552@sirena.org.uk>
References: <87d2ib90t9.wl%kuninori.morimoto.gx@gmail.com>
 <878usq1scd.wl%kuninori.morimoto.gx@gmail.com>
 <87r46izhv5.wl%kuninori.morimoto.gx@gmail.com>
 <877g89qhdo.wl%kuninori.morimoto.gx@gmail.com>
 <20140310145254.GJ4400@trinity.fluff.org>
 <87fvmlpqi1.wl%kuninori.morimoto.gx@gmail.com>
 <87ob14jl2d.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HrsILUyxNtiOryfc"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87ob14jl2d.wl%kuninori.morimoto.gx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kuninori Morimoto <kuninori.morimoto.gx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Simon <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--HrsILUyxNtiOryfc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2014 at 07:29:55PM -0700, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
>=20
> Support for loading the Renesas R-Car sound driver via DeviceTree.

So, I've applied this but it needs some improvement - please do that
incrementally.  One thing you should have done here is CC the binding to
the DT list and maintainers for review.

> +- rcar_sound,ssi		: SSI subnode
> +- rcar_sound,scu		: SCU subnode
> +- rcar_sound,dai		: DAI subnode

This needs clearer documentation saying what the subnodes are - they're
actually collections of further nodes, each of which represents
something in the hardware.  The examples are fairly clear but the text
needs more than just "subnode".  Someone should be able to tell how to
write the DT just given the datasheet and this document.

--HrsILUyxNtiOryfc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTLIJiAAoJELSic+t+oim9apYP/A4MffB93uF8TTbdtzgale7z
h84DWW3yopo0bQZUV0PdQ+isa6a/nBB0YUBTnkPTnaGgSoEtDsHPQJecJsC1HIzG
n32C4GXuQVMoVnBxBPNYQYqrDKrEvVaGEst8ebxPdqUb84/VMITcByNZ5k1Dl1Sf
XOlgB8oZFv/pu20Wqqre+F2peN8blwln4DiiUTaLC5ihHHcdOFSotOU+8xZdtvAD
ZhwyDgIfjEQBC4hWM8UpmTRZVzEvWaeVOFKzU//Z0KZkeUN1cTsyhsv2qg9+ZkkO
z5dyLx2AQ/U+ptntgarAmaNJJe3KzYYtNijcQzp1JWkvYg+cWIUpH9vnyjwt2pSD
V6LtuDD/IOcNH0wJcs/OKwKX9u6J1sG3qqZpVvtKeQicz+IZFpHLr1Mpzc3gzGyF
6Cdox+eMb8WoftxAn13rpNmQVgV+13J4AYCoDjdFRKM+lnwQBdSr0Oh9lWsPcMnn
MJ6VcfxM5Ncr13zxLxe3pRa0zSdz3cJ1/evDgYkoiJbTSyJ32UCyKIZQudSTYWgt
e/E11thKaDmkHGce55tIpGumm23BrmliZp1k78OaVb4Jx2Yx+NWhdT51yWEr93Kt
c3q10He6Kn9G0t/frRVQHAavOT1lfUQEBbV/7evPQIRTSf2fZ0KbAlMScsHpO/5V
V0Wh5di1bczM480J9JsE
=kRHH
-----END PGP SIGNATURE-----

--HrsILUyxNtiOryfc--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
