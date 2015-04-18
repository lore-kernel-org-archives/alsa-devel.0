From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: fix a compiling issue
Date: Sat, 18 Apr 2015 18:03:04 +0100
Message-ID: <20150418170304.GW26185@sirena.org.uk>
References: <1428893250-21092-1-git-send-email-yang.jie@intel.com>
 <20150418121106.GM26185@sirena.org.uk>
 <CAOf5uw=x2F9AFxoFwGNh-2FbjX-E7sZuki5e6t71JH0amyAb-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5412933813812479755=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 906D8264F0A
 for <alsa-devel@alsa-project.org>; Sat, 18 Apr 2015 19:03:12 +0200 (CEST)
In-Reply-To: <CAOf5uw=x2F9AFxoFwGNh-2FbjX-E7sZuki5e6t71JH0amyAb-w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============5412933813812479755==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bOC9TN0n4iVUZoxs"
Content-Disposition: inline


--bOC9TN0n4iVUZoxs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Apr 18, 2015 at 02:19:37PM +0200, Michael Trimarchi wrote:
> On Apr 18, 2015 8:11 PM, "Mark Brown" <broonie@kernel.org> wrote:

> > Rather than have the ifdefs in the users it seems like it'd be better to
> > fix this by providing static inline stub functions in the headers.  That
> > way nothing else will run into the same trouble.

> This was my "English" suggestion

Yeah, I hadn't seen your mail when I wrote the above.

--bOC9TN0n4iVUZoxs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVMo5EAAoJECTWi3JdVIfQfWcH/icAds0gAyH3Avz/JSRVfdD2
AWKHPbXKMnzL/TqdAk0jR36pKXpQp9btmDDQHLr6q7vB+A0U4qqquQ+P+27eKNed
Vam3GEABOn3H2HBDP/On4TYlhyK2br/2hmSoOtA3hFZwaSNXTTLpqJHvAFfv96CX
xLxtLsSG9/IUEWXqYiNdrr+Lu1HLlXA4BaFnJxHNqYwl5soC7DuK7g+1y2kpQbK/
jPM08/XtcVSkfeEwu6TiZrG/F4KpiIp3hkJJWcw4ZUhMmE4ftYciHwszUWADHyp7
xRG0xz9SD+TeAafv91DD6gqRtAnXih8iXZPJYXJyLwhsXNLT2lZlYRwd2E1W4Q8=
=+rmg
-----END PGP SIGNATURE-----

--bOC9TN0n4iVUZoxs--

--===============5412933813812479755==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5412933813812479755==--
