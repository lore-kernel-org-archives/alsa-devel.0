From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC] ASoC: Add mediatek HDMI codec driver
Date: Thu, 5 Nov 2015 15:52:08 +0000
Message-ID: <20151105155208.GQ18409@sirena.org.uk>
References: <1446638053-12143-1-git-send-email-p.zabel@pengutronix.de>
 <20151104120343.GZ20228@sirena.org.uk>
 <1446736519.3894.113.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8444521185517841476=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 092CB2660C7
 for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2015 16:52:22 +0100 (CET)
In-Reply-To: <1446736519.3894.113.camel@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Koro Chen <koro.chen@mediatek.com>, Daniel Kurtz <djkurtz@chromium.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-mediatek@lists.infradead.org, kernel@pengutronix.de, Matthias Brugger <matthias.bgg@gmail.com>, Cawa Cheng <cawa.cheng@mediatek.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============8444521185517841476==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QVgWX4+QEldMe/r9"
Content-Disposition: inline


--QVgWX4+QEldMe/r9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 05, 2015 at 04:15:19PM +0100, Philipp Zabel wrote:
> Am Mittwoch, den 04.11.2015, 12:03 +0000 schrieb Mark Brown:
> > On Wed, Nov 04, 2015 at 12:54:13PM +0100, Philipp Zabel wrote:

> > As I keep saying I really want to see some collaboration and consensus
> > here with the goal of sharing code and achieving a consistent userspace
> > interface rather than a lot of individual independently implemented
> > drivers.

> For eld updates and jack handling I could try to go forward with
> Russell's notification prototype from the "[RFC,V2,0/5] another generic
> audio hdmi codec proposal" thread:
> https://patchwork.kernel.org/patch/7339011/

> Or are you saying there shouldn't be a Mediatek specific HDMI sound
> driver at all and this should be handled by generic code?

Well, now I take a glance at the code I'm not seeing any actual hardware
interaction here so it certainly seems like there's nothing MediaTek
specific going on.  I've not actually looked at the code beyond a brief
glance and doing a search for the helpers, like I say I'm really looking
for collaboration and consensus among the people working on HDMI here
rather than a specific solution.

--QVgWX4+QEldMe/r9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWO3sjAAoJECTWi3JdVIfQCgYH/0NxMtD4+qpVp6Fv2VWpnH8s
0NZ6i6QvJRfICX+8QhAk/C+clbXyd46neR0EJjr8M+tSyZRpIMNcOPmJKmZSlEfD
7mkLmrM2Sm49K2GVGFvMJtbqWbj6dXOAdXSOwvh0LUFwBbdytjgs4vOUPSpjaSL1
0EsyxBDSaboO+RcJ71uvXALhXfxIH9w472fpOlDjsH1IiXHEjIuNLAtgSmbcw0dw
DFC2WPO82FEq3W0p4/nuc+fiA7jbiHINQ6alp2AV1x5dwOD6tU7myMpKkB7W/NRA
HDC1uDuBeUy4GY0cE71xXGsEIQ0j2ZQE4UvWxZyhAGE3reJIxORCNyPkKtzCyvc=
=1b5Q
-----END PGP SIGNATURE-----

--QVgWX4+QEldMe/r9--

--===============8444521185517841476==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8444521185517841476==--
