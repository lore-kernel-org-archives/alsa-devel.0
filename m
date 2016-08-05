From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: nau8810: Add driver for Nuvoton
	codec chip NAU88C10
Date: Fri, 5 Aug 2016 13:08:04 +0100
Message-ID: <20160805120804.GV10383@sirena.org.uk>
References: <1466152834-29615-1-git-send-email-KCHSU0@nuvoton.com>
 <20160627171546.GE17217@sirena.org.uk>
 <5775E4C7.5010303@nuvoton.com>
 <20160701100423.GM6247@sirena.org.uk> <5779D93B.80106@nuvoton.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1579492604298336367=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D28D2652F8
 for <alsa-devel@alsa-project.org>; Fri,  5 Aug 2016 14:08:12 +0200 (CEST)
In-Reply-To: <5779D93B.80106@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: YHCHuang@nuvoton.com, alsa-devel@alsa-project.org, CTLIN0@nuvoton.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============1579492604298336367==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="p8mP+8RrBGerSNjm"
Content-Disposition: inline


--p8mP+8RrBGerSNjm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 04, 2016 at 11:34:19AM +0800, John Hsu wrote:
> On 7/1/2016 6:04 PM, Mark Brown wrote:

> > No, you don't - this is entirely normal for 7x9 regmaps, I've never seen
> > such a device that supported readback.  Look at devices like wm8731 for
> > examples.

> Sometimes, we need to know the codec information and need read it
> from hardware, not cache. I'm afraid that it can't be done in this
> case.

What does the read actually look like on this device?

--p8mP+8RrBGerSNjm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXpIGjAAoJECTWi3JdVIfQfXUH/0M90B17NO13subj0T4WcdBS
UpRSdYKhhA4X1tcjSVEwjCmSAPwwvNQvZpTtPHmRc3wNG3bbs1Sc6MW/xqwhu2gP
p5/mk7zz+/dYmNLwCzGfSVwqgB98L+6wg8q0dAN72UU9i+TvEUScct7YZitoBJhv
7D49vuMHxOf1o95SKL3okJBPL8rHU6qrduaiVC9ylpn2lkLqOwtKwVvSQc2AwtAc
r1h9LUIozYx+r0pnrSm0+xvFuSMDod4qFinOMMNml1TgiOowrqwEtjVfGJzDEu54
F/mmHjYlNS8OpEsDLbPmRLEQJgirYpcpQBjvgqryM6IaiP8Yv9xGylWTJ0Eq66c=
=iSSV
-----END PGP SIGNATURE-----

--p8mP+8RrBGerSNjm--

--===============1579492604298336367==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1579492604298336367==--
