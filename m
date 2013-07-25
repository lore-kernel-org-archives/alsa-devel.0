From: Mark Brown <broonie@kernel.org>
Subject: Re: Ambiguous DAPM widget names and DPCM
Date: Thu, 25 Jul 2013 13:48:59 +0100
Message-ID: <20130725124859.GC9858@sirena.org.uk>
References: <51EE3F18.3030207@gmail.com> <20130723123017.GV9858@sirena.org.uk>
 <51EEA2A3.8030106@gmail.com> <20130723183038.GO9858@sirena.org.uk>
 <51F11916.1080002@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7618734458509595325=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id D6230260783
 for <alsa-devel@alsa-project.org>; Thu, 25 Jul 2013 14:49:02 +0200 (CEST)
In-Reply-To: <51F11916.1080002@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: ALSA development <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7618734458509595325==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ESXajHq3/vK+Jgyg"
Content-Disposition: inline


--ESXajHq3/vK+Jgyg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 25, 2013 at 02:24:54PM +0200, Daniel Mack wrote:
> On 23.07.2013 20:30, Mark Brown wrote:
> > On Tue, Jul 23, 2013 at 05:34:59PM +0200, Daniel Mack wrote:

> > OK, so the issue here is probably that you're overloading the single
> > McASP object rather than anything else

> Hmm, I'm not following. Isn't that the way things are supposed to work
> with DPCM?

Not normally - normally there's a single CODEC on each external
interface with multiple front ends connected to it.

> > Lookups are done first in the local DAPM context so so long as the thing
> > that's setting up the links is doing so in the same context everything
> > should be OK.  This is needed so you can have two of the same device in
> > a system.

> Hmm, but DPCM does not have such a local context, and just tries to look
> up the widgets by name globally.

OK, so this is probably something that needs to be looked at.

> > The prefix mechanism is intended to address this; however it's only
> > currently supported for CODECs.  If we move the prefixes to components
> > then they should be usable for CPU DAIs.

> But that's a static string as well. How can we distiguish between two
> Codecs of the same type, or two McASP instances?

The point is to give a different prefix to each device; giving the same
prefix to different devices rather defeats the poinnt.

--ESXajHq3/vK+Jgyg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR8R64AAoJELSic+t+oim9UUUP/jDUjApLu++2P7fUQGLLcPrE
KzNhuBiT1lugUvd0F829zUboh4fIBjd7INGV5pzTZ/EgYyYFnzs+7pO0CvCY4/aw
hEBSuoWuMujh2u4hJmWqfKXZmOk6fpg2LKpU8KnZMTv+gbW+5GEL2br2aKvzEiCi
nkosaeI7Elqrmerv9M1OPvwLEz0JYRLYP2Vy4BLJcQ+dPoVjQ4/wfpjSjMQWMQf8
sRtdNMRMdeLLyuFKEEMml/4yc4736WHNMvVy7IqVb3BgQWI93fWlQTVlHyZaCiZW
v+QWWT46nXW37l+J4TlFqld7hk7g3AxcIe8ZSQBVlgg4idxr0qSAABb9H5zO/S4W
5eununTMjpn41/5xDjn4/3L7auSjndlkPb/fNDHvrOmWtu5rxHIojgXex7jujQOj
rnYmn7KJx0uA8TmbUykwK6xrSyn29a94oJH3Fsc7O1Hp17RyqcyF/xtg6xVGtKvg
WsumliBDH2+KDFnfGfwy85vWvjLwLgqkg4w1iUYOBEs476OymdQ2QaI2e5uvM0c6
pthX1ZjB2k/D8aChKWtsYc9Va0DtYt9PD7Ql8WJTvwM6gTO0w5WN9kUnDQzc2wWj
9p2IR1DHlbL+spFTEjPCgBo1mADyzhE0k015nGkaHT+pHSqjkaUSxwHGIK26sred
4xt7QTJnSslWW0ruBx2/
=Fnax
-----END PGP SIGNATURE-----

--ESXajHq3/vK+Jgyg--

--===============7618734458509595325==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7618734458509595325==--
