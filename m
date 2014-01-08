From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] Patched to allow fine-grained control of
 PLL and clock dividers
Date: Wed, 8 Jan 2014 12:13:31 +0000
Message-ID: <20140108121331.GS31886@sirena.org.uk>
References: <20140107223047.59BCAE395C@parallels-Parallels-Virtual-Platform>
 <1389182888.2346.22.camel@loki>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5002463528509682348=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D440026513F
 for <alsa-devel@alsa-project.org>; Wed,  8 Jan 2014 13:13:40 +0100 (CET)
In-Reply-To: <1389182888.2346.22.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Daniel Matuschek <info@crazy-audio.com>, Dimitris Papastamos <Dimitris.Papastamos@Wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org


--===============5002463528509682348==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Pe/zYa7ALBEfMxba"
Content-Disposition: inline


--Pe/zYa7ALBEfMxba
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 08, 2014 at 12:08:08PM +0000, Liam Girdwood wrote:

> Please make sure you CC the maintainers on patch submission otherwise
> they may miss the patch. Please also use the correct subject prefix too
> e.g.

In general follow the process in SubmittingPatches.

> > Changes:
> > 1. allow the driver to accept S32_LE PCM streams
> > 2. fine-grained control of the PLL generation

These should be sent as two separate patches, each patch should only do
one thing (as covered in SubmittingPatches).

--Pe/zYa7ALBEfMxba
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSzUDnAAoJELSic+t+oim9x8oP/iq6DYBiwMQCibfEtRl5DyEM
Bgk96gjxNAWWCqGeiNtFcbhEPhhIPFBb4ET6DRL7ClXSr6b5ygjqL/4taL3AXAfA
q8/8C8C3sRQ3n4rYNmuqG6MslR6MLdM75NkpbBOWelxfBZZZzd69rijdHS0R0J2W
FBIMxxz5MTRTTE0HHPkl7oOG+6HBUvqfcQMBuEE8UFr8XdUZsEL8XHn3mLi6PBUW
JXM3UmPMAVQhOJRoF0Mx8jFj7CmRD9s4MS1Zf9/vI1qe0qp82Y9Ml+5evI/zAzrE
4SRnv0XZh4N8StpYnZtilaG6KHVtiIowMR4Qjgp2UD16tGORvBeTVosb13lMbyIA
Uwv8fcjQgjV7nbq5aurM6PAIrg1ugX57encsOwS/jyDzkIovmDxyMQDvXmftcvZJ
rrVzAfVTRcQnxj/2edJqR+6KdbMOdY4J62blas2T3cURNbEHBE/MfRInbiUN5vJz
DTK2i3vrlWqGOYfv32DuRYbS8VfE1JFj7lVg+QUKo3pHp054gc00XkvgO0TawDSN
Pyje6JMOJmNejZosND0sGsku8RTU8vSyHdFtfokBbjiTUzQW/N1oL8ryEgeoISqS
F2J3FL4d8Ig5V3rENuuF3YT0yv7Eq2r5SDfnSiq+LxQ5rUTC3hu9fNpKGzELZK2y
mvaO+f173vPcod4FYwXz
=+Z1V
-----END PGP SIGNATURE-----

--Pe/zYa7ALBEfMxba--

--===============5002463528509682348==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5002463528509682348==--
