From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/3] ASoC: dapm - Use card mutex for DAPM
 ops instead of codec mutex.
Date: Sun, 4 Mar 2012 14:09:40 +0000
Message-ID: <20120304140939.GH3083@opensource.wolfsonmicro.com>
References: <1330711872-27436-1-git-send-email-lrg@ti.com>
	<1330711872-27436-2-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8538825836329141943=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8D5CF24624
	for <alsa-devel@alsa-project.org>; Sun,  4 Mar 2012 15:09:42 +0100 (CET)
In-Reply-To: <1330711872-27436-2-git-send-email-lrg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8538825836329141943==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SdvjNjn6lL3tIsv0"
Content-Disposition: inline


--SdvjNjn6lL3tIsv0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 02, 2012 at 06:11:11PM +0000, Liam Girdwood wrote:

Thanks for looking at this stuff, it's needed attention for a long time
but it's never been a practical problem and it's always depressed me too
much every time I've thought about looking at it myself.

> This patch updates the DAPM operations that use the codec mutex to
> now use the card mutex PCM subclass for all DAPM ops.

Hrm, this makes "PCM" look misnamed...  should we have a DAPM context,
or perhaps even just a separate lock for DAPM?  If we can have a
separate lock that'd be good, it's usually much simpler (at least for
me) to reason about multiple locks interacting than nesting on the same
lock but it's not always reasonable to split the locks, like with the
PCM stuff calling back into itself.

It looks like we're also missing a lock in snd_soc_dapm_sync() here, we
need to lock that as well as the updaters otherwise we might change the
lists underneath the DAPM run which doesn't work so well.  I might've
missed that, though (and currently we're not exactly 100% on taking that
lock when we should).  That's why snd_soc_jack_report() has the CODEC
mutex for example.

We'll also need to make sure the locking for the register I/O is sorted,
it's OK for the devices using regmap as that locks for us but currently
anything using the ASoC level cache relies on the CODEC mutex being held
for register I/O.  This isn't quite so risky as it was when we had the
advanced caches since the data structure is just a plain array but
writes may still go AWOL and that'd be a nightmare to debug.  I'm
worrying that right now something is relying on the fact that DAPM takes
the CODEC mutex to protect it.  But probably it's OK to fix that up
separately I think, we've got plenty of problems there and either
killing all the ASoC level caches or adding a new lock at the cache
level seem like the way to go both of which are basically orthogonal to
what's going on here.

--SdvjNjn6lL3tIsv0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPU3edAAoJEBus8iNuMP3d8k8P/jQymGkj4tXOmViiLADtNqOV
9wQXj5wSid9z8J9E8w3ZRtVzJBdYJuPRDNPdCfvXWeKyd/3WVj3i68ousxNb7WdK
WmpN1V0QGRU3lh2MyCbYSIM+ja1aA6WL9NX58d6jP6BGM+BF+SJaVyGKpKuTUuMN
PO1bFRzBxYaUzt2pUtjrQcTqrvprCY8C7hL6NScdZbkz6FJPYoL9Jexrlcb2HgLd
RqoUoHgY3CykJw0zfivxtXJub60+HJYcuoHMD7zfOWY7dGbaeVCMTFyAsW7nRQrY
g1mOJwUDv09GWQM4qO228pgoUKojdsZQnnfd4b7quXfGzKNVpFuTcYSauBXgZC/N
GbFgzwMHGztK0CHzYRR0nw4KK5JHs5++AQEIFcjEx3HDZS7q/mg6dfXwWQKZLSrs
R/0Jpf/oYXTHHtjqZG7X64yVXZpoPtiUpyYSP4p+IE7MRcxkENzxHByK4UpnNCyO
7L2X2vN7QlHN0eyQgNfHrxThusIMvxwbjexuTbcZUVQIWvH7hnx2E7FhgiRls9gZ
BpwCGw7KFXJ2v51I9VZcKJK8B80xS1zK/jFSuQgsXC0omXMXIgnHKf5EOB5xIZuC
8ZGPGicGjKb1iTUjokVKOxlHVvfteThR/H/kN1DflcWQR63ZyQPuf6mL0iS96kqY
wpM26EGDqvd02yy1Qch4
=09+T
-----END PGP SIGNATURE-----

--SdvjNjn6lL3tIsv0--

--===============8538825836329141943==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8538825836329141943==--
