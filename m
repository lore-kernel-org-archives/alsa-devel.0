From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 12/19] ASoC: mmp: Don't set unused struct
 snd_pcm_hardware fields
Date: Mon, 30 Dec 2013 13:59:07 +0000
Message-ID: <20131230135907.GH31886@sirena.org.uk>
References: <1387545625-19240-1-git-send-email-lars@metafoo.de>
 <1387545625-19240-12-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7414548279988976648=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 6EDEF261B30
 for <alsa-devel@alsa-project.org>; Mon, 30 Dec 2013 14:59:10 +0100 (CET)
In-Reply-To: <1387545625-19240-12-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Qiao Zhou <zhouqiao@marvell.com>
List-Id: alsa-devel@alsa-project.org


--===============7414548279988976648==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cvGDtX8LmIpY177y"
Content-Disposition: inline


--cvGDtX8LmIpY177y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 20, 2013 at 02:20:18PM +0100, Lars-Peter Clausen wrote:
> The ASoC core assumes that the PCM component of the ASoC card transparently
> moves data around and does not impose any restrictions on the memory layout or
> the transfer speed. It ignores all fields from the snd_pcm_hardware struct for
> the PCM driver that are related to this. Setting these fields in the PCM driver
> might suggest otherwise though, so rather not set them.

Applied, thanks.

--cvGDtX8LmIpY177y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSwXwoAAoJELSic+t+oim92PIP+wcFn0oJ+7mSk+maO+FMigTT
d4i5m1V6juV83CvOuerjubnKHv5nToCaa2AnH4im+PQKHkXjUrH+esrNHNnINlNq
EifSljImPCTeORySmBtC3FKoVNFBTpICRzVryG216r8WqaDtNk3QA99CC+HsNDHN
avkMQmCpE3K0ADbkEZ/C3UVcVuyNtlNqSvAvrKMnXRamcuu+afdaX4VGRUrowLlb
bIdgzoRci51hxTJHYNBZ+Az2mpYTOTbot4p3FFIe9nr/jv/VUR7NR5xkcmoAqzUY
qc20AhV+NYCM12ivOraVDAMBYb8fI6BwkjZt9RkZpfnD+AQxmyIkHS/ClG42pHpS
k9kTPdDUxX66/SwZG+AmaMQNF5WfdXbjyWmd8LHeqFr63ldbxwJUdkhrc2eAuFLn
fDK6fQsDrnztIa55wGl3NFrGYVG3iRQsW9AUAtP1VKOdh/vd5wNjSlLOG85kaijw
tmhsaxSx75MHpxaflQKDk6Tc+2O4MiAlu6k62gE99XCo2n3L5DXYdW+ZfiJPc+bo
KGKNkOiTXXlMjbLL5JuZd+LzbT1UXoF3VgKdm3p31L5u+82q49EnKGVgwCRXCrS4
SWgwCbQmWncsg7WK3/msRxyJfTEqLFQS5y13DiyUycHZ7B7KS/HfG+j1JGRTiSAn
4eJL5eOwVTUEROwvaR0K
=xC0J
-----END PGP SIGNATURE-----

--cvGDtX8LmIpY177y--

--===============7414548279988976648==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7414548279988976648==--
