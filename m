From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dpcm: prevent error for paths
 including static links
Date: Tue, 29 Mar 2016 14:22:24 -0700
Message-ID: <20160329212224.GM2350@sirena.org.uk>
References: <1458056089-885-1-git-send-email-piotrs@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8215115416330070641=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EE32A266987
 for <alsa-devel@alsa-project.org>; Tue, 29 Mar 2016 23:22:30 +0200 (CEST)
In-Reply-To: <1458056089-885-1-git-send-email-piotrs@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Piotr Stankiewicz <piotrs@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============8215115416330070641==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QUAc4O4i7jPlU8jt"
Content-Disposition: inline


--QUAc4O4i7jPlU8jt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 15, 2016 at 03:34:49PM +0000, Piotr Stankiewicz wrote:

> This happens when setting up, e.g. a route starting with a dynamic
> DAI, which passes through a static DAI (say, "Some FE" -> "Some BE"
> -> "Codec to Modem link"). All DAPM widgets involved in that path will

Is this not just a normal CODEC connected to a back end on a DPCM
system?  What are a "dynamic DAI" and "static DAI"?  Your changelog is
very unclear, I really can't tell from your changelog what this is
aiming to do or how it proposes to do it.

I'm also concerned that nobody else seems to be seeing this, that's a
bit of a warning sign that you might be misusing things here.  Your
mention of a "Codec to Modem link" sounds like you might be trying to
use DPCM for off-SoC components somehow which is just not something
that's expected to work.

At a minimum this needs a much better changelog.

--QUAc4O4i7jPlU8jt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW+vIPAAoJECTWi3JdVIfQIhoH/1pAZWW4EVxUcNfmuU6uq5Io
m1m9VFCSYcFSvoSk73R5DEGY4IAJ6wLQhV5i3STiWB1oDodIAp6gEG7ynU1OvgZ4
OGLQhiqc7ES2OC+cZ2o5vypbd+94tDIi1M3NeV6VXMY3VBK94gPFqTFvGwHk6h8I
pnf6suWFwiHr5RvOOy8j8WqVsNKN8+tJOIMbiqs2bVLhFC+nmmShyDE+T6kQQVRO
OyIPebQcP4RDJmKSVQGNuagHDbuhUmmPbepd30MsSnM0suxyGJ3IWJnxONUhUDo5
FkHlenBnRiss1a9M3K3IMPLGAXTY2jOlh/LAkiRZuqvPI1qPm2q9Zj8iUHW9dC8=
=Xk/X
-----END PGP SIGNATURE-----

--QUAc4O4i7jPlU8jt--

--===============8215115416330070641==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8215115416330070641==--
