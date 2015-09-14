From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: nau8825: Add driver for headset chip
	Nuvoton 8825
Date: Mon, 14 Sep 2015 18:54:11 +0100
Message-ID: <20150914175411.GY12027@sirena.org.uk>
References: <1440805070-39150-1-git-send-email-anatol.pomozov@gmail.com>
 <20150830144717.GD12027@sirena.org.uk>
 <CAOMFOmUR0DQD82AU9-8XrA0vscRkC0UxaV5ZvOOa6TG4RZDs1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7787975188824754585=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8CF1F2605FF
 for <alsa-devel@alsa-project.org>; Mon, 14 Sep 2015 19:54:17 +0200 (CEST)
In-Reply-To: <CAOMFOmUR0DQD82AU9-8XrA0vscRkC0UxaV5ZvOOa6TG4RZDs1Q@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anatol Pomozov <anatol.pomozov@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Ben Zhang <benzh@google.com>, Dylan Reid <dgreid@google.com>, mfelton1@nuvoton.com, Chih-Chiang Chang <ccchang12@nuvoton.com>
List-Id: alsa-devel@alsa-project.org


--===============7787975188824754585==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7iH89WndFPCVpQsx"
Content-Disposition: inline


--7iH89WndFPCVpQsx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 03, 2015 at 10:10:05AM -0700, Anatol Pomozov wrote:
> On Sun, Aug 30, 2015 at 7:47 AM, Mark Brown <broonie@kernel.org> wrote:

> > which is only called (or only does anything) if there is
> > actually DT data (if there is an of_node set).

> device_property_read_* handles both DTS and ACPI that covers most
> (all?) modern systems.

> Or are you talking about case when a platform driver passes
> pre-initialized data from using dev_get_platdata() (like what rt5677
> does)? I assume this is a deprecated style that predates DTS/ACPI
> style configuration.

Not all architectures use DT or ACPI, the driver should really support
them.

--7iH89WndFPCVpQsx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV9wnCAAoJECTWi3JdVIfQNlUIAIUso5Z4QR9rNtbEq+2NEPjY
Pby8yKVLbIzGbT/kRPzzU90LL3A+61KKj9Wmi4jhJ2kcj75cf1A6/DMv4Bt++zbr
CT/K2Efsq+Xm1rBy+vBgFkY5jYIVs8JmHDPb9mKFzi6k9KFNfSvjhvrnAbBd3bKt
FdjyURooFnnRDSoDp0pWFv5+WRQFitA/YPnYxKV9J35sL5njfKSHppoCRAGWFKEI
KDvg9xHHZ5S0DF3HeF8G9kerhYo7w+W4+Ex9nSyjFkZbm52SezAMCCdDVGfwBshU
LLZ7JBdpZflrl9slx21Uf5tTRgCzxNBfS1H/Bn5CEE7NB0IEtgmP0eIKtyl+XNM=
=iAyy
-----END PGP SIGNATURE-----

--7iH89WndFPCVpQsx--

--===============7787975188824754585==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7787975188824754585==--
