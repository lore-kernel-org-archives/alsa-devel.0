From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: tegra: Add platform driver for
	rt5677 audio codec
Date: Mon, 29 Dec 2014 15:55:32 +0000
Message-ID: <20141229155532.GM17800@sirena.org.uk>
References: <1419362942-26192-1-git-send-email-anatol.pomozov@gmail.com>
 <20141226163826.GD17800@sirena.org.uk>
 <CAOMFOmW5BL4HpzC9Q32Q48s90Mnd0cqM5np8gH5RxZEXCAEEdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4965606886327384310=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 24DB526671D
 for <alsa-devel@alsa-project.org>; Mon, 29 Dec 2014 16:55:44 +0100 (CET)
In-Reply-To: <CAOMFOmW5BL4HpzC9Q32Q48s90Mnd0cqM5np8gH5RxZEXCAEEdw@mail.gmail.com>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Stephen Warren <swarren@nvidia.com>, Bard Liao <bardliao@realtek.com>, Laurent Dahan <ldahan@nvidia.com>, Dylan Reid <dgreid@google.com>
List-Id: alsa-devel@alsa-project.org


--===============4965606886327384310==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RS1722//baS0C3Tp"
Content-Disposition: inline


--RS1722//baS0C3Tp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 29, 2014 at 05:25:59AM -0800, Anatol Pomozov wrote:
> On Fri, Dec 26, 2014 at 8:38 AM, Mark Brown <broonie@kernel.org> wrote:

> >> +#if defined(CONFIG_MODULES) && defined(MODULE)
> >> +     request_module("snd_soc_tegra30_i2s");
> >> +#endif

> > What's this all about then?

> Sorry, my question was not clear. I meant is it ok to put this
> request_module() to upstream code? If not then just remove it before
> merging my patch.

What question, I'm not seeing a question in the patch (I'd expect it to
be after the --- if one was being asked)?  I've no idea what it's there
for so it's hard to tell, my first thought would be no and you need to
fix whatever you're working around directly.

--RS1722//baS0C3Tp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUoXlzAAoJECTWi3JdVIfQIuwH/iJD+htTwXHCMHJC3cVz/2JT
L+3DpQUIz/kBEUx1cqw0lFl+BP+29OCBl8sBB/pd/sZOLENnrmYAZVD1rAXZcGb7
XEp+3bsVkoG4S1EnkphkejARik/pJfiGUKms83YgEwhkOMkkTaLV1ueNs0I1MLo5
C9KhWpBuogtqrFytxBTO5q57ofv1A3YnrYTFm2tuzHsilGVARVyiDUPnDwvGU4AI
SSnM+3vhhMBPf7je2iYm0g2M5VOT0u4q2Hyj1CiSZUmIGGA8YOKWfDzrzm474ZEv
9jUWH2aclSqNoYPxhJazwhbW1EWnBcrje034dDRQWJqrgIlxSeFYfqztVTw3a2U=
=74jq
-----END PGP SIGNATURE-----

--RS1722//baS0C3Tp--

--===============4965606886327384310==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4965606886327384310==--
