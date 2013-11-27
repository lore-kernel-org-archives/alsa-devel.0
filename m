From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: pcm: Always honor DAI min and
 max sample rate constraints
Date: Wed, 27 Nov 2013 14:49:53 +0000
Message-ID: <20131127144953.GV14725@sirena.org.uk>
References: <1385542698-13362-1-git-send-email-lars@metafoo.de>
 <1385542698-13362-2-git-send-email-lars@metafoo.de>
 <s5hk3fu6sqt.wl%tiwai@suse.de> <5295D500.50607@metafoo.de>
 <s5h7gbu6q6y.wl%tiwai@suse.de>
 <20131127122153.GU14725@sirena.org.uk>
 <s5hwqju56oe.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4023889369112845267=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B19C261AB2
 for <alsa-devel@alsa-project.org>; Wed, 27 Nov 2013 15:49:57 +0100 (CET)
In-Reply-To: <s5hwqju56oe.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4023889369112845267==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1nWzwthe/g5xaf/W"
Content-Disposition: inline


--1nWzwthe/g5xaf/W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 27, 2013 at 02:13:21PM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> > It seems neater if snd_pcm_limit_hw_rates() does the right thing no
> > matter what the rates are - this centralises the logic for handling this
> > which reduces the complexity for drivers.

> Well, the difficult point is to decide what is right, if the given
> condition is already wrong (e.g. rate_min/max don't match with the
> RATE bits).  We can accept it somehow silently (as of now), but I
> think it's better to warn (and/or refuse).

I agree it's better to warn if it's wrong, I was more responding to the
comment about it not being quite correct to call snd_pcm_limit_hw_rates()
with _KNOT or _CONTINUOUS.

> I think Lars' fix will handle such a case nicely now; at least,
> merging between RATE bits and rate_min/max is solved, as long as the
> given conditions are consistent.

Yes, it should work for the time being.  It just seems silly to have
more than one set of merging code, it just increases the chances we'll
get stuff wrong - switching to use the core constraint merging code
should avoid the possibility of such errors in future.

> But yes, we can certainly put some sanity checks and more handling
> code into a core stuff.  But the drivers giving wrong parameters must
> be fixed in anyway.  IIRC, even ac97_codec.c does something
> misaligned.  Warnings would be a help for hunting such ones, and I
> didn't intend it being more than that in WARN_ON() above.

I'm talking about the code in ASoC that combines the constraints from
the devices on the link here rather than the drivers, as you say the
drivers ought to have correct constraints standalone.

--1nWzwthe/g5xaf/W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSlgaNAAoJELSic+t+oim9sXMQAJzEkShlH07merCSAdnlnCin
t1jARhO/FIsB+Q2XecCFxcdvXpPsGQrz0xfpEp7yHwL9LazRufA9JDrVrONUZjbt
XbIb9nuRrH6AqwwapCFcq9jmx3kHkUCuk1eKZ3iKzLA8c5kmxLwlk3JL8+PWTgEk
YazAvMzqojkX3mkQI0tI3IwIaFPRRKM/c5GT8w1Tj+RrCW8urc1Hm6ELDz4WNeW5
OQ+iUFKIna6C9syoLWqkElFboCaAl0HfwoNltO49zQyv0Z28KjUa9ZhPzIpEGdRR
JkN+S3oKyWIirmZe2TKw+9rRKR/yCp+HKGHNFJ5ROkG35lKNmSzTOpDXo/5IiD38
+Tbiscl2a4reu3J1GYgT5eYkDHpAlBGPNxCyEl8vVDQoe+jbuL2JHmwNrR08pU+c
dgs6fPBdY5Da7RVvMaCnpn7K+/cP2r+EY945Q0uYvYrA29JBacnmSoSTBbErXwa8
D1kR3WFujMrorEQVg7lFzJARUZkk7+8Lq0m2bSmYkBuCagA0/WTsLKNqxU3K0N6x
CzRsjoyfGaTgJNoDv+NfQ52XcOb9QXFtdx0Oxz8To3Ct/NZmB0xiOGA5qmWPtCwk
ZsLw/foCJfqINmnbV8AQz1vruxzGbFnVk2SLLMgU7T7aPX61pZxni+D6urH06Kmp
ByBcWxTdoekw2IAuItsd
=gJIX
-----END PGP SIGNATURE-----

--1nWzwthe/g5xaf/W--

--===============4023889369112845267==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4023889369112845267==--
