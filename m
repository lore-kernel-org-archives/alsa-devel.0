From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [RFC][PATCH 2/2 v2] ASoC: simple-card: add Device Tree support
Date: Tue, 29 Jan 2013 09:48:11 +0800
Message-ID: <20130129014808.GC4748@opensource.wolfsonmicro.com>
References: <87zk11487a.wl%kuninori.morimoto.gx@renesas.com>
 <87sj6t484z.wl%kuninori.morimoto.gx@renesas.com>
 <50E71618.8090302@wwwdotorg.org>
 <20130104193712.GN4627@opensource.wolfsonmicro.com>
 <87y5fvyy18.wl%kuninori.morimoto.gx@renesas.com>
 <87vcazyxr1.wl%kuninori.morimoto.gx@renesas.com>
 <20130127035943.GJ4650@opensource.wolfsonmicro.com>
 <87vcag3hcj.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2585100374634791986=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <87vcag3hcj.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
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
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Liam Girdwood <lrg-l0cyMroinI0@public.gmane.org>, Simon <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--===============2585100374634791986==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p2kqVDKq5asng8Dg"
Content-Disposition: inline


--p2kqVDKq5asng8Dg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 28, 2013 at 05:31:33PM -0800, Kuninori Morimoto wrote:

> > > +- simple-audio,cpu,dai,clock-gating		: if needed, see below

> > A lot of these are listed as "if needed" - this means they should be
> > listed separately as optional properties rather than in the required
> > properties section.

> Sorry, Does this means under Documentation ?
> Or driver ?

In the binding document.

> > I'm also thinking that for some of the above properties which really
> > should be the same for both ends of the link we should just specify
> > them at the card levle and copy them over.  The format and inversion=20
> > mainly.

> I guess it can share format between codec/dai,
> but it is difficult for inversion.
> Because it is depends on its default clock polarity.
> of course we can do
>  simple-audio,platform,dai-bitlock-inversion
>  simple-audio,platform,codec-bitlock-inversion
> but it is same thing.

Inverted and non-inverted always mean the same thing in terms of ASoC
and should always mean the same thing in terms of the device tree, if
two devices are directly connected you should always be able to use the
same ASoC format for them.

--p2kqVDKq5asng8Dg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRBypPAAoJELSic+t+oim9iLoP/i8ZrEz0TSX+nTqOU8ODb1sV
k4i5jzIbLPrQvkAI0VouxetzUCrvSwA7C18hUqil4Nn6lg8UvmgsaK4N0vQhqWPy
gmn57MnWFL+q7XVeu9bgR4+IO9IpaExDGUPt6DnN/uxcQOozsgZREISWX5/XG3fV
+OOiK4BxbSw4XZCDyCNCUUP7iJcsc2gtLtdiwcAP2Qar1iyhfelCELrRxOKYQ/y2
fI8t7hsWyg6ND9AxTVHxSuH+gh3orKcLVOeMqZ7kUwWY7cZKvlIrnQvsgS17Amg7
NfmKXnEKGESqf2R8VuSvHazpSPlIGh+tlt3ktEgS9BdnubkZ51cGEeO+jNhNkiuc
HD+ZmhJ0B/iYogBgvtQyNom1la4wzt9sLsmdYmuI7/NBLzxu6Rt1f3Ii3B+JS/y6
HOeuBWuxl7aE+JSJCvOkhVD6hqidUmZOjcRKhE3gd7yYf0n4LbiQQjRsat7hv6aV
wIzKkvf3zvoVU3yJifrNT8J3mO6sM9gWVgwTDBNGmZAtfJfvue02llQ3t5jn7htU
ITTUbqu+NQE0DAXc6ytC/JLkdDlV3XP6XEaDEvZaKLRbu+kpIwaQXSBVePrf1Aw8
i7sifqflujOmcG0xhgp+LviA3yDYnPTHBRsJKUxrs9kfi5R8BQiviFVPNMK30qB4
nfdyqBLWjrabtEhnNVu3
=bNBu
-----END PGP SIGNATURE-----

--p2kqVDKq5asng8Dg--

--===============2585100374634791986==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============2585100374634791986==--
