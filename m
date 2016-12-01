From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5670: Enable Braswell platform
 workaround for Dell Wyse 3040
Date: Thu, 1 Dec 2016 10:50:27 +0000
Message-ID: <20161201105027.tdndbcmnorkb6tkq@sirena.org.uk>
References: <20161130161920.10817-1-tiwai@suse.de>
 <20161130163615.GG6408@localhost> <s5h60n52an2.wl-tiwai@suse.de>
 <20161201033058.GI6408@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5926857789040694245=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F25426648D
 for <alsa-devel@alsa-project.org>; Thu,  1 Dec 2016 11:50:42 +0100 (CET)
In-Reply-To: <20161201033058.GI6408@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============5926857789040694245==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fbcqfemcad2dgprk"
Content-Disposition: inline


--fbcqfemcad2dgprk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 01, 2016 at 09:00:58AM +0530, Vinod Koul wrote:
> On Wed, Nov 30, 2016 at 05:30:25PM +0100, Takashi Iwai wrote:

> > Well, the question is how generic the given platform-specific setup
> > is.  I guess we can keep the dmi thingy for a while, although we'll
> > need more generic solution (or a pattern matching for a wider range of
> > machines).=20

> Mostly if people stuck to Intel ref designs, then it would same, which has
> been a problem on embedded side, but who knows.. :(

That's just not at all realistic - if the systems are only going to be
supportable when people copy the reference designs verbatim then we're
going to have serious problems, that's just not how things work in the
real world (especially at the higher end of the market where there's a
greater desire for differentiation).

--fbcqfemcad2dgprk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYQABvAAoJECTWi3JdVIfQFnsH/1U+DnSCniFQMAJibkbo8D4G
DWNEWg3TEozD2LXR/iws/b/WCTbGo51Zm9PrShGwGV/0xqt+RVEcQDchS6eh3C6f
8eaWVK6uAqCTtBkvB8uRS/ecwWDILuZcZX+HfBbU6DL1Jc0Ap/6nmuLKqLRmeZCU
ZzGsIF8N73Iz1HDxdRGBV4D8+i+Bf3R6b5CZspXBrpDhQs0xbzU6aSS+4+GEBuvd
QBNeM8UMrObZn/17IL2IsFZ8H1L0AChDkOHnz4R2V6FFauAnP7mSYLNgd7AveuP3
/+6ST+Pmh9D4PlWMSWEvY8NxSPln3m+KP0ICTZtJ0hXTrepbfYf9n2/bt4iMVb4=
=ef0V
-----END PGP SIGNATURE-----

--fbcqfemcad2dgprk--

--===============5926857789040694245==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5926857789040694245==--
