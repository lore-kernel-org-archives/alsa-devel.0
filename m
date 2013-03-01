From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH 1/5 v7][RFC] ASoC: add snd_soc_register_cpu()
Date: Fri, 1 Mar 2013 17:44:08 +0800
Message-ID: <20130301094406.GT25302@opensource.wolfsonmicro.com>
References: <511963F8.5020107@wwwdotorg.org>
 <87bobqf5yq.wl%kuninori.morimoto.gx@renesas.com>
 <511C22E2.60701@wwwdotorg.org>
 <87obfnofsx.wl%kuninori.morimoto.gx@renesas.com>
 <511C6A1B.9000507@wwwdotorg.org>
 <874nhfv5mb.wl%kuninori.morimoto.gx@renesas.com>
 <8738wzuu9g.wl%kuninori.morimoto.gx@renesas.com>
 <87a9qsg4lp.wl%kuninori.morimoto.gx@renesas.com>
 <878v6cg4io.wl%kuninori.morimoto.gx@renesas.com>
 <512E8C99.2040708@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6157299305784695833=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <512E8C99.2040708-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
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
Cc: Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--===============6157299305784695833==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O0IT7rLmWuveAsNR"
Content-Disposition: inline


--O0IT7rLmWuveAsNR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 27, 2013 at 03:45:45PM -0700, Stephen Warren wrote:

> I can't recall how much influence the existing CODEC objects have on the
> various routing/matching decisions inside the ASoC core. While this
> patch does register and unregister CPU objects, I wonder if it should
> have more impact on any of the existing core code? Certainly I'd expect
> the CPU objects to show up in ASoC's debugfs and any similar files...

All that happens with routing is that routes will be bound within the
current DAPM context before other objects are searched, otherwise
everything is very flat.

--O0IT7rLmWuveAsNR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRMHgGAAoJELSic+t+oim97/oP/2TNpljLhzSrddkLe2VSV2ug
DZgK/BI12KepHmVNPzSNNicIUvCcDFhoQml2a/qkwT/DYAsHsIkOxgO7ec9QIbTy
zVxFXDjFIIiLh8FucwzCZWrTxC5MaFEhKG4qcxjXeDwr/hL39jepSvhvrEJ4791b
uAPK7t10G2IN+d+HDlPbAinowAPgcCY7nDQXmA/kNvfwEJLmcdD5Gxf1blDyLDyn
QEpKlmTJmBRnYHkOztnXcmTjDf6TIyymYItdyDSaNrOARaMWUh4Mky+nbCswiKHX
T61z59pKPUmdJDLg+kHWT3Fax1upNtfYAVmDOSuBRQYecZIU/TIHlNOs4C0zrR6S
hKY+1PTn4k3Zf5puQeyCqfFQUBb3I4Mm+dfSo0oxpUTH94X14tnB+D2dQ9NNnZH9
fOIY8AOSuIVkWBbu64cIgHCXZAf42lVfDNnxTgZMDvdXK4jseT85viu9or7BWKX3
nd5J37wAlI1CKhcz98lQyBcOU04Agku8VVTvDsS/6JVxPp/7rpU4dyiGHXBWn9gY
QcSjXIyKeytFmrqOthsqqkyQ/y9cBkR7NXkJyOpToUAlM5Br+ocTq7rAkzDICC1A
wJlr/x52hJXVPo+Tg1UOrQBcaoEzc8ng6jLALDdM/RwRVJdj8eozXowwt+0uTs3j
9rgc0ZSb2om57Vg6hmyx
=o9uO
-----END PGP SIGNATURE-----

--O0IT7rLmWuveAsNR--

--===============6157299305784695833==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============6157299305784695833==--
