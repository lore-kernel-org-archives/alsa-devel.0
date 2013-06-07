From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dmaengine: add runtime status
 checking in dmaengine_pcm_dma_complete
Date: Fri, 7 Jun 2013 15:34:28 +0100
Message-ID: <20130607143428.GR31367@sirena.org.uk>
References: <1370606249-19955-1-git-send-email-zhouqiao@marvell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4805097866588898988=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D8DF265706
 for <alsa-devel@alsa-project.org>; Fri,  7 Jun 2013 16:34:34 +0200 (CEST)
In-Reply-To: <1370606249-19955-1-git-send-email-zhouqiao@marvell.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Qiao Zhou <zhouqiao@marvell.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, zhangfei.gao@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============4805097866588898988==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SyWwpI3Z1FWsG80s"
Content-Disposition: inline


--SyWwpI3Z1FWsG80s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 07, 2013 at 07:57:29PM +0800, Qiao Zhou wrote:
> the dmaengine_pcm_dma_complete callback is usually executed after
> the dma interrupt, which uses tasklet_schedule, workqueue, or other
> method for quick int handler return.
>=20
> in some corner case, where pcm stream is released unexpected, like
> media server is killed, the runtime parameter will be freed. if it
> happens between the t1 and t2 in below chart, then the callback
> will try to access members of paramters which is already freed,
> and kernel panics.
>=20
> to avoid this issue, add runtime checking before other handling in
> dmaengine_pcm_dma_complete. if pcm stream is already released,
> just ignore the current handling and return.

This doesn't seem like a good or robust way of fixing this, if we're
tearing down the resources the DMA is using while the DMA is in progress
then in the worst case that might include the memory being DMAed and of
course there's races if you just check the pointer - the pointer can be
checked at the same time as it's being freed (or between the free and
the clear).

I think we should be either halting the DMA or waiting for it to finish
here.

--SyWwpI3Z1FWsG80s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRse9wAAoJELSic+t+oim9eZkP/iAyOd+wE6/C9ml5tPkzRmZa
ZLg+1EzFhIWLMDXfK78zVG0HBeL9DLcOSJK1kvOjJOQXNyYqFFYeDF6tRJ4ZDe3F
d8m2u6HUMgK0cciidicmKJBv8nJZhzAe5I2LKNgPwhs5D5eN4ETRcc5syg+YXF5/
XKEAggXrzmAqV+lhAoBG9BoYIJmNCjKFgzImYQ2W+nATeAFrIBbphMOG6VQjU6+9
vLt+KT7YcDGjuPNi8/eTTe/bLGhrYQjJY6KHqLZnu/BpVHpr3ykBOqLFtUt9SE8+
YzvnZUD0i4s9lT011s8QWz5xpmFeTheZWghMckuSMUF7T9heKQhWuANo2jGgY/8f
aRBqAGevgBFi+ZX1gr69dRouniASlyebyiAG/tqrTMfQeDHaPxKNcVp49IGryYY6
9Kste7UvXi6fQZg5yMyPHTpduzgma+9QzaUu4uD3+OhKTng6hMQtOC/liJtsz8Xu
DONE4cKi8HHL4q80uDm6Xh+tNRuAnxn+rVjLaMoZF/Zm+maZj7k+YF2uP3DcceRo
2uIvet4+7NUAT2EjHuSjPV35pCSNDEcldQoVBIehGFAcNcqyKGTfFemNQchu3HQW
WZXaJ/F7gp/y7DehDcM0ITO+x2q8UZw7CH36ZGDe7EIGhDjBOUYEYjNgRLqIrjn4
oFDj+M1LkC4OqaJ6Fw6P
=Kmgv
-----END PGP SIGNATURE-----

--SyWwpI3Z1FWsG80s--

--===============4805097866588898988==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4805097866588898988==--
