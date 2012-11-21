From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/4] ASoC: firmware core: Add core support
 to create and destroy firmware components.
Date: Wed, 21 Nov 2012 19:37:56 +0900
Message-ID: <20121121103754.GC18117@opensource.wolfsonmicro.com>
References: <1353348765-6238-1-git-send-email-lrg@ti.com>
 <1353348765-6238-4-git-send-email-lrg@ti.com>
 <20121120032659.GC4483@opensource.wolfsonmicro.com>
 <50AB9E56.5050509@ti.com>
 <20121121004356.GC4673@opensource.wolfsonmicro.com>
 <50ACAB1D.2040103@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5079768678360954999=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 93DCF265CD2
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2012 11:38:07 +0100 (CET)
In-Reply-To: <50ACAB1D.2040103@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============5079768678360954999==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bKyqfOwhbdpXa4YI"
Content-Disposition: inline


--bKyqfOwhbdpXa4YI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 21, 2012 at 10:21:17AM +0000, Liam Girdwood wrote:
> On 21/11/12 00:43, Mark Brown wrote:

> >So, the text strings for coefficients were what drivers used to be using

> Yeah, it will be your standard alsamixer enum kcontrol strings e.g.
> for the ABE DL1 EQU has "Flat Response", "800Hz HPF 0dB", "800Hz HPF
> -12dB", "800Hz HPF -20dB", "4000Hz LPF 0dB" where the settings are
> tied to the associated blob of coefficients.

Right, but the decision we took at the ASoC conference and have been
implementing was to move away from that to just letting applications set
the binary blob to change the enumeration value instead and then putting
the management of multiple names for the blobs into userspace.

--bKyqfOwhbdpXa4YI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQrK6kAAoJELSic+t+oim93/gQAIe5PIXRPrXYNu6ez6CJHlph
TZo7jbDkqx+iLvGL9kwujuOFwAtuWqaBvZdgevQyuSSkc+ouJ7Rl+QubWiMtzi/e
RXVQD7rhYBCcNe0NU0trz2v3ZAmZhnfIL+gq+w4m/TUPxqWmy+rp4J8a2IdQq8wI
flr3ZmF2H4zifB+VhheLa7CbumqWLGZv6kzKVLvEYDocUkyXwPrphGYqV8Eu5CeH
9jz/OPKsYBMDDn0p+BpQQHYnJj5zVDkcRS72CBknWC9GdsCeOXBncH/13KcRwREq
9FYrx3DgFzYRYQmGBLFz9yI+jY8E2tYG1I+pHOeAy290Ef/mw7vjKvEg3RpRUNXp
rVDnYPsICui2FrdHUC6cpgx68om55pSmINb3aTsfZAzN9c6G9rG2jpdM6Ni8X8av
/+2WBkWTVr9D7OEfaL23zkhGqHqGC92tX+vT040XniCevl9YEYkuk83C/4Q6m6eK
Mmm35vY/BrUFTrNJ7v0wGZ2GSKsfVUa6Dv4B0M3gOBklBxMyNoPXVSgiJd5EkYS2
gGE4alx0eQl2EEJJG3nTLdahw8RoFY5TiNWIe9r28QfKCCtGyQ3xW8izaD5q3Pee
MIyVAY6e5tsyQbbLY8HBTn6VBJnqrnIRs54kM5pxTwvP+0Qmt6bw4Y04fMxIZjx4
mIskBXmIMm6xlptadWIh
=5x5C
-----END PGP SIGNATURE-----

--bKyqfOwhbdpXa4YI--

--===============5079768678360954999==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5079768678360954999==--
