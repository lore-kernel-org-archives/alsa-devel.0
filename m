From: Mark Brown <broonie@kernel.org>
Subject: Re: HDMI codec, way forward?
Date: Fri, 16 Oct 2015 15:06:37 +0100
Message-ID: <20151016140637.GK14956@sirena.org.uk>
References: <5620E482.6050507@ti.com>
 <5620EE2F.8070504@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5802091073748859524=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 20DDA2606A2
 for <alsa-devel@alsa-project.org>; Fri, 16 Oct 2015 16:06:55 +0200 (CEST)
In-Reply-To: <5620EE2F.8070504@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Russell King - ARM Linux =?utf-8?B?4oCO?= <linux@arm.linux.org.uk>, David Airlie <airlied@linux.ie>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, lgirdwood@gmail.com, dri-devel@lists.freedesktop.org, peter.ujfalusi@ti.com, Vinod Koul <vinod.koul@intel.com>, tomi.valkeinen@ti.com, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============5802091073748859524==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="O6uyWUGY5J97yCxj"
Content-Disposition: inline


--O6uyWUGY5J97yCxj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2015 at 02:31:43PM +0200, Lars-Peter Clausen wrote:
> On 10/16/2015 01:50 PM, Jyri Sarha wrote:

> > My conclusion from the Lars-Peter's latest mail [2] related to the
> > subject is that the wind is currently blowing slightly in favour of my
> > version of the hdmi codec [3], or at least not in favour of Arnaud's
> > version [4].

> > So how should we proceed? Are we still waiting for some feedback from
> > DRM/video side?

That too, though given that they have never commented on these serieses
at all as far as I remember and are generally not very vocal IME I'm
probably OK with just applying something.

> What needs to happen is that everybody who is working on HDMI audio suppo=
rt
> should get their heads together and come up with a common solution that
> works for everybody, rather than having everybody trying to push their own
> solution and put the maintainer in the spotlight of having to choose one
> (Mark has been asking for this for the past half year or so).

Longer, I think.  In this context things like the work that Russell has
done with the EDID handling is really great - making common code that
other people are able to adopt and use, and where I can see that there's
reasonably widespread buy in.  There was some debate about the
differences between your patch set and the very similar patch set that
Arnaud posted which was good to see but it felt like that petered out
rather than drew to a conclusion, I'd at least expect to see a new
version appear that the pair of you can hopefully agree on or some
active statement that you both support one or the other version that's
there now.

It's one thing if there's unresolvable differences that someone just
needs to take a call on but right now it just feels like it's more that=20
there's a lack of engagement.  What I don't want to do is merge
something and then find a few months later that it needs big reworks
(as opposed to extensions) because it's missed some important things
that are a problem for large classes of hardware.  Having separate
approaches for completely different classes of hardware would be fine I
think but we need to understand what they are and ensure that as far as
possible the user experience outside the kernel is consistent.

--O6uyWUGY5J97yCxj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWIQRtAAoJECTWi3JdVIfQyqIH/RKA7whO8QpdcAlC2BV40YSY
1SfJ/yIrjy1Y0d1L1fLW++0Vm6HTQG4mDcWgYmx/MTpQPT2wPd9htiqYtqUhanFl
curSlwtNBgt4OBw4ufsxhrSND1ElctaHhTPHRFNY455h1WaFIWPUgOKUZrZyZ4MG
NOJcG0L1fcohPJAZYB8p60oIbYGl+uMusNJahrvcw5il34KOzURv407N5hHvkYpb
8Lqix7XyMRZuY+GZ8tonc0N/x1Z1EVqAZ8jwY2Nheo5gG/J4yVvq8dDG7XxorsMQ
bkqHS4oq4ehvzUmFkK1NjivU3qCNOCu5FjnnTuIrAYNLkl2jCktOr4l4iFbbHvY=
=Qo6b
-----END PGP SIGNATURE-----

--O6uyWUGY5J97yCxj--

--===============5802091073748859524==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5802091073748859524==--
