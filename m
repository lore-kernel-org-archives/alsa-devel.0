From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] ASoC: mediatek: Increase periods_min in capture
Date: Wed, 23 Sep 2015 09:12:53 -0700
Message-ID: <20150923161253.GN30445@sirena.org.uk>
References: <1442213477-63721-1-git-send-email-koro.chen@mediatek.com>
 <1443002599.22786.2.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0014409613296469143=="
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1443002599.22786.2.camel@mtksdaap41>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Koro Chen <koro.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--===============0014409613296469143==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Mqntr8YLmpnm4ZyH"
Content-Disposition: inline


--Mqntr8YLmpnm4ZyH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2015 at 06:03:19PM +0800, Koro Chen wrote:
> Any suggestion for this patch?
>=20
> On Mon, 2015-09-14 at 14:51 +0800, Koro Chen wrote:
> > In capture, there is chance that hw_ptr reported at IRQ is
> > a little smaller than period_size due to internal AFE buffer.
> > In the case of ping-pong buffer:

Please don't top post or send content free pings.  I'm not entirely sure
what you're asking for here - the patch has been applied, what further
suggestions were you looking for?

--Mqntr8YLmpnm4ZyH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWAs+EAAoJECTWi3JdVIfQr2sH/2DcvAQXsNg0/6FjockBC4Pf
rWi+D4koFVTphUJcJeSmBEpureHRAlm77rV0CojzZkej4bjzvZ9VJ5X9erpLybhC
AdCX5g5Je5okkDtv05QYSYWGLfE57rxuF4d88yUAsmq/XG6viJHkgkX2JOxCFX5l
OZI3hgSdV6GU2jsituqXoFRpaAukdprl6Wd04FADL2bwpsWAlKUrz1hS8RJzeANQ
0nESlXNVrka/+QLyz028yothLAy5/bXPYYdHFK2YJM/IRH8N457Y5qOdFhXgx5v2
7VqFWOBDjEqI/19YKnDQAXLt/kslrvJ+ZsaIG0HgrdxsFkiCvwGye2fOM/7C6Jw=
=hatT
-----END PGP SIGNATURE-----

--Mqntr8YLmpnm4ZyH--


--===============0014409613296469143==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-mediatek mailing list
Linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-mediatek

--===============0014409613296469143==--
