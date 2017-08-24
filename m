From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/4] ASoC: add Component level
	set_bias_level
Date: Thu, 24 Aug 2017 11:32:54 +0100
Message-ID: <20170824103254.sw2dsc7wj63nnyw4@sirena.org.uk>
References: <87bmn5rdqf.wl%kuninori.morimoto.gx@renesas.com>
 <8760ddrdnw.wl%kuninori.morimoto.gx@renesas.com>
 <87shghpmg6.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1454528174435354374=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 076E52669F3
 for <alsa-devel@alsa-project.org>; Thu, 24 Aug 2017 12:33:04 +0200 (CEST)
In-Reply-To: <87shghpmg6.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter <lars@metafoo.de>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org


--===============1454528174435354374==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vv3ij6rr2z5erwnh"
Content-Disposition: inline


--vv3ij6rr2z5erwnh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 24, 2017 at 05:31:36AM +0000, Kuninori Morimoto wrote:

> Oops... new component want to have .idle_bias_off / .suspend_bias_off ?

Yes, they're different and both useful.

--vv3ij6rr2z5erwnh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmeq1YACgkQJNaLcl1U
h9AfwQf/cfKwMdbr0FHgEUINWEuyCxeb8iRezz/WTY+PrHX9lDojTgjex24zSeK6
s76JACxBcmbj0EKUWdcnTAWLlCMAK+ZVMNxu0ikRCm1JCGw90ustD4MSmFS1Yqyl
rW5ZT2M61AXlT7b4lkOFYJRLyAlHGnntr2y7EeUBBaaERwUFMKaJ/ppj1fVqFXLW
4RJYWzshafAWBzQEhHzpwJ/Gy1Fv7toHgz3OKgbGUID+8gOCXU2aIRAcIjpS5Cy8
ZHk+TEY3ZJm32ie/R8rsorpRZV2rN25Zj9khd31XWfnJKva+R3rvav93W3V9fp+N
kjZ2bwvh1rE82GWyPvZKT1zuTMPKjg==
=dysQ
-----END PGP SIGNATURE-----

--vv3ij6rr2z5erwnh--

--===============1454528174435354374==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1454528174435354374==--
