From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/4] ASoC: ts3a227e: set irq flag base on
	dmi
Date: Thu, 30 Apr 2015 21:08:22 +0100
Message-ID: <20150430200822.GI22845@sirena.org.uk>
References: <1430358238-74659-1-git-send-email-yang.a.fang@intel.com>
 <1430358238-74659-4-git-send-email-yang.a.fang@intel.com>
 <CAEUnVG6_cGAOPf24H=ECSAC8AU0rsvLBPeLUZ-yKgT_0dpW39Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7056013283180238642=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 647222617A5
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2015 22:08:32 +0200 (CEST)
In-Reply-To: <CAEUnVG6_cGAOPf24H=ECSAC8AU0rsvLBPeLUZ-yKgT_0dpW39Q@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dylan Reid <dgreid@chromium.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Denny Iriawan <denny.iriawan@intel.com>, Yang Fang <yang.a.fang@intel.com>, Praveen K Jain <praveen.k.jain@intel.com>, "Diwakar,
 Praveen" <praveen.diwakar@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Vinod Koul <vinod.koul@intel.com>, kevin.strasser@linux.intel.com
List-Id: alsa-devel@alsa-project.org


--===============7056013283180238642==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7zirqQNUUcp8IXhb"
Content-Disposition: inline


--7zirqQNUUcp8IXhb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 30, 2015 at 10:45:04AM -0700, Dylan Reid wrote:
> On Wed, Apr 29, 2015 at 6:43 PM,  <yang.a.fang@intel.com> wrote:

> > +static struct ts3a227e_platform_data cyan_platform_data = {
> > +
> > +       .irqflag = IRQF_TRIGGER_FALLING | IRQF_ONESHOT,

> As we discussed internally, using an edge trigger here can lead to
> missed interrupts if another event happens while an interrupt is being
> processed.  I'd investigate getting the level interrupt to work on
> this platform, and only if that is impossible try to make this work
> with an edge interrupt.

TBH given the prevelance of devices out there which only support level
triggered interrupts it probably makes sense to handle this somewhere in
genirq, either generically in a driver that handles whatever bit of the
platform creates the restriction.  At the very least it should probably
be put into a library since it's a bit of a pattern.

There's some workarounds for systems with similar restrictions in a few
of the Wolfson drivers if you want to copy (they do need a GPIO mapping
though IIRC since they do the level trigger in software).

--7zirqQNUUcp8IXhb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVQou1AAoJECTWi3JdVIfQ9UkH/3aPmvAwn9nF+viqUW587rlf
UUaPbIbYK4tEJB+nJGKRXAl8IL9a7TrTuO34gqUfygm0Ufk6uIWEAKg26Hsr+g7+
ZBodj1NDLYxtGn/DSOV2qNgv5YhS2NqCOyEtBJV/+7aWuxnA/fFnu9s4rX40qlYd
CjhfQKxqihn3Dw0kU+fUOQSJTwI2y4OLAA2s4rLiDR3yyuxVi56aPzErma91mOeb
l7wVJzRLWphDMJVbOaHjLlh9y/WsUrosFJ5AC5kPBCOxaVOpd5mWpq/ymA9iSHM3
ZUWDBzNaOXOoaej8ZMa3IbI4AUvdn5fUcDY6wnrBprzHU9DaHlnYuGifJ4540Uo=
=xxDw
-----END PGP SIGNATURE-----

--7zirqQNUUcp8IXhb--

--===============7056013283180238642==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7056013283180238642==--
