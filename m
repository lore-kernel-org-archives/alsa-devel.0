From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] Revert "ASoC: wm8996: Pass the
	IRQF_ONESHOT flag"
Date: Thu, 9 Jul 2015 09:27:56 +0100
Message-ID: <20150709082756.GH11162@sirena.org.uk>
References: <1435843604.17967.1.camel@ingics.com>
 <1435843741.17967.3.camel@ingics.com>
 <20150708183422.GY11162@sirena.org.uk>
 <CAFRkauBW5UySoHCt10S9uN8SLqzp_CE4BqtsdNS-W8yUKDRQ5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4545152561729479118=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C2F3F260504
 for <alsa-devel@alsa-project.org>; Thu,  9 Jul 2015 10:28:20 +0200 (CEST)
In-Reply-To: <CAFRkauBW5UySoHCt10S9uN8SLqzp_CE4BqtsdNS-W8yUKDRQ5g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, Michal Marek <mmarek@suse.cz>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Julia Lawall <Julia.Lawall@lip6.fr>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Fengguang Wu <fengguang.wu@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============4545152561729479118==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NffpD3bBbNaSNdk0"
Content-Disposition: inline


--NffpD3bBbNaSNdk0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 09, 2015 at 09:52:23AM +0800, Axel Lin wrote:
> 2015-07-09 2:34 GMT+08:00 Mark Brown <broonie@kernel.org>:
> > On Thu, Jul 02, 2015 at 09:29:01PM +0800, Axel Lin wrote:

> >> This reverts ed043aebe6ec ("ASoC: wm8996: Pass the IRQF_ONESHOT flag").

> > Please use subject lines reflecting the style for the subsystem, even
> > for reverts.

> I don't get it.
> I thought if a patch is actually a revert, it should look like a revert.
> So I generate the patch by "git revert". Is that wrong?

You should edit the default subject line to be a normal subject line.
Reverts are patches like any other.

--NffpD3bBbNaSNdk0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVnjCMAAoJECTWi3JdVIfQVlsH/0h3q1YA+cNYUkms3Pmu1ZHU
4+213L2xLgqnsUH0mftzmLg7p7BPEqCVA7M63IaBAxOb9uUJJfOY46q3r02QPHxy
LQV1xmftyno1rA+HY57rgIT9oq8knTIFD8o6qw24mUuFVuoES/zFX9Q6kOp3e5TB
WuAI7bPgl51frTLe3k7bQlIIuku6RuN3OcmyHK4L0PpzfhDeqO9WlBhMJr7x7U+k
T9G+Jed/NjCNIO9S0VoDbfvQ9mq4qA+lJzsDxmMigOF5LAT2d70+gE9FrGmwNiLp
o6sSulI+C5w0iiKquQZ84rIKjXED4+9ArLI5EejPOKz2w7M+ZT4+DiC6DB+T3w4=
=2gXf
-----END PGP SIGNATURE-----

--NffpD3bBbNaSNdk0--

--===============4545152561729479118==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4545152561729479118==--
