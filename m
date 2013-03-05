From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/5 v7][RFC] ASoC: add
	snd_soc_register_cpu()
Date: Tue, 5 Mar 2013 11:05:48 +0800
Message-ID: <20130305030546.GB9391@opensource.wolfsonmicro.com>
References: <511C6A1B.9000507@wwwdotorg.org>
 <874nhfv5mb.wl%kuninori.morimoto.gx@renesas.com>
 <8738wzuu9g.wl%kuninori.morimoto.gx@renesas.com>
 <87a9qsg4lp.wl%kuninori.morimoto.gx@renesas.com>
 <87mwuptgju.wl%kuninori.morimoto.gx@renesas.com>
 <512FACAC.1000808@wwwdotorg.org> <5131147F.5090901@metafoo.de>
 <1362174130.4439.61.camel@loki>
 <20130302032511.GB6610@opensource.wolfsonmicro.com>
 <1362426516.4448.68.camel@loki>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2197954645150016053=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8094926518D
 for <alsa-devel@alsa-project.org>; Tue,  5 Mar 2013 04:06:18 +0100 (CET)
In-Reply-To: <1362426516.4448.68.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@intel.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Stephen Warren <swarren@wwwdotorg.org>, devicetree-discuss@lists.ozlabs.org, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2197954645150016053==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xXmbgvnjoT4axfJE"
Content-Disposition: inline


--xXmbgvnjoT4axfJE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2013 at 07:48:36PM +0000, Liam Girdwood wrote:

> I think we probably have more in common between platforms and codecs now
> than we have that is different (certainly, things were very different in
> the past). But you are right, is it really worth the big churn.....=20

Definitely, I'm just not sure that the existing platform object really
captures the new bits or if it maps more onto DAIs.

--xXmbgvnjoT4axfJE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRNWDrAAoJELSic+t+oim9if4P/3FAqZVRLaz1fVF2AV3ygIKb
mlxK2jl/eU0iqQ8pJID7g2n1HI/b1gUtRHHV+TdkMnFrY4/+IolOVXwt112O72qN
1M3/00KsPksB8bDbEqJyKjLBmnRTyNtoDv1VZxP5c3K0pYCnng4ajkm5HKsgPxkX
1hTkFZKPRnvSQ+Xvaa6WuvkgZaUCuiyI0BGpwe+mNCutvGC1sBJ6/8EHDGCar/+6
ao4oP4g9pnU4OweiJCod7KCJjlQZBgtFyO6CUz3Qw5wVXjD3B+PspC8Ifzg1p0h9
4EmHW0lJGR2k84h4rKugaJGBGQCSA5TKVsP+iJLyZOtq5IK/RtwUUf78jci/0nWt
C7q8a6pDxmhDa2RK++Es1XOR7VK7J74waSONWZffp8ityAPTLqTWFTQWIRx1T9xb
I/TfISRhhA4k0HWTg4A56tpAL4nm+Otr8NbZbMbnET+Q/yuVNyJoqCoI3RGCvcTX
CUzrbjf3+S+e2pmTT6NPeuoERuaBkvWHPU0h4DB6jX0YAsLeCAYU/L8R49Z3OeU7
zjcpxD33mweZlayC4DWqTzEK3uzOsQfMNVVWykeNHtJaOYY0vZfy0hdAMLwrpV6N
XXcpsSINOiUC5h7DdimJcw2h7UnILbymHArE4pTmX30t4GtfQCY11KcpFhzioMUL
167vttmcqEsD46TtBKSm
=1CNM
-----END PGP SIGNATURE-----

--xXmbgvnjoT4axfJE--

--===============2197954645150016053==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2197954645150016053==--
