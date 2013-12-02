From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: omap: n810: Convert to
 clk_prepare_enable/clk_disable_unprepare
Date: Mon, 2 Dec 2013 11:16:15 +0000
Message-ID: <20131202111615.GL27568@sirena.org.uk>
References: <1385827528-32149-1-git-send-email-jarkko.nikula@bitmer.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1912950327871123324=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 874182610CB
 for <alsa-devel@alsa-project.org>; Mon,  2 Dec 2013 12:16:17 +0100 (CET)
In-Reply-To: <1385827528-32149-1-git-send-email-jarkko.nikula@bitmer.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1912950327871123324==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MGkO3B5rqHsDzYnN"
Content-Disposition: inline


--MGkO3B5rqHsDzYnN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Nov 30, 2013 at 06:05:28PM +0200, Jarkko Nikula wrote:
> N810 audio driver has stopped working at some point. Probably when
> OMAP2 was converted to common clock framework since now call to clk_enable
> dumps the stack trace in drivers/clk/clk.c: __clk_enable() due
> clk->prepare_count is zero.

Applied, thanks

> I'm not queueing this to linux-stable since OMAP2 common clock framework
> conversion in commit ed1ebc4948fd ("ARM: OMAP2: clock: Convert to common clk")
> happened before N810 was really usable in mainline and user base for N810 is
> anyway small. Potential linux-stable candidates are only those after
> commit 3d3a6d18abc6 ("watchdog: introduce retu_wdt driver").

That looks like it still means v3.10 and up could use the fix?

--MGkO3B5rqHsDzYnN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSnGv8AAoJELSic+t+oim9rmUQAJoUchAZYi5/WPd5BcNywQVY
0dY8HjUtjy0Kz5VYaj7buHPhy3nMIZuZtuYFXGCpH3wGyr9dLVomFimeMpDMu0pQ
kVHrGdtbF5oBsV1XwXqJZJoUx8OqychKL5G/ANq6vab+A/o7EUGi/xlh7295WS1p
6KoQtqf4iKqv3tUsNIKsMeeMQFAcQRW4rIvLqZxDiOx1v8cGVeEnSyskfZLQ6Em5
WQ7N6N0Yte2oBYnDpVfxIDj4zvhL/qs5Yv5wakdRpURgTNTR6xcm+KlnZ/Ng+Uo0
cBkKDDLKbKalp50jwHWbc7vhJ3hGrstc+Ccxu7FY6Fw3XQed1gc+rs3BIMNzf2CJ
B7/t15fEuHUPfCTMy/YuRZfI92jrNUWAZcKCytKsv6FEV5e/zzf8M3WtBBvhMAGq
edljEOES68zVydTD8zoexDSlMm6YcCoK5qJH5AXXLQM01qClHt+KFxQ/qGN+1ElG
9TEigZ9OzoYBz8SkqcPpIpKhyY7z+2/86XUWW+AZ5d/iNGyK82K9q67Z8ejRd4Jl
ZA3T8hb+Az8/tAIH0OyEBN+L/tSWeTaMaaqJg0fWOjUycEV07USN4VBef+jOEY+8
NxQLQoA3lrP4ZTvnDEKdp3J2WmJ7wMKlPtFOsYSiQqu5RUpXDtkFvEonATYlWdvm
zMbvKuaHCTXlaeAoyEl4
=ZLGZ
-----END PGP SIGNATURE-----

--MGkO3B5rqHsDzYnN--

--===============1912950327871123324==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1912950327871123324==--
