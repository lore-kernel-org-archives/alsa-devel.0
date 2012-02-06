From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 18/19] ASoC: fsi: fixup fsi_pointer()
	calculation method
Date: Mon, 6 Feb 2012 16:46:44 +0000
Message-ID: <20120206164644.GU3070@opensource.wolfsonmicro.com>
References: <871uqcjo9i.wl%kuninori.morimoto.gx@renesas.com>
	<87bopgi97k.wl%kuninori.morimoto.gx@renesas.com>
	<20120203115522.GG3151@opensource.wolfsonmicro.com>
	<87k440x0ft.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5658511813017215802=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CEF53103BC2
	for <alsa-devel@alsa-project.org>; Mon,  6 Feb 2012 17:46:45 +0100 (CET)
In-Reply-To: <87k440x0ft.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org


--===============5658511813017215802==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JT7Km6uNxtC1LbQY"
Content-Disposition: inline


--JT7Km6uNxtC1LbQY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Feb 05, 2012 at 04:36:28PM -0800, Kuninori Morimoto wrote:

> It depend on DMAEngine series.
> This is bugfix patch for PIO/DMA, but PIO version FSI driver never
> got bug since it was sleeping bug.

I'm sorry but I'm having a hard time understanding what this means in
the context of your patch.  What is a "sleeping bug"?

--JT7Km6uNxtC1LbQY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPMAPtAAoJEBus8iNuMP3dUfsQAJhkXs+nRmSgHlJ+dnkzbdTL
t4Ys8oZ6AtL0ZkJ4vck90Ce7VrHtx2jfG/yA4J8kAOetzHz8DM5bvhOuGrFvoTpa
NYRIBuzW7BIWI4LdotxJKAeFrZbstlmXS7cDDG01NSBJFT4kt9KM0TRO6WHbCvSU
Ic0h+cjwT2iYOk6zGAyWmzd9MXTe/EH9vvANW5SiiXrAPOTE8R5N/G7RlSWMCgEK
7S82HEJ1U0GBVRQU/cpPe9k5h7+5U9oSG1R2JmChSsSgk3D0nJ2EicFgy3seN07d
NPJUNqHotxUo4ac4Qi3GXpO03Z63Y2n8oDKCcN+VFnDN5YZcUv/Fz8qV8oCu8cV/
75ePZURDdptp+qHhXEk9RxXfbjvV2y3YYOTO03rpVhhPtO2fw0f7EcJHLghIvA0e
objxpL/9sSNlDdsKfug/w7SupqBJUQ1HB0FgM71B0PNCOKoxrnmiSlMJZNnM9UzS
YIlutSGvYbtxJQRGLeTskw65Na7oZdHtQ3Rd9r5NDR32MCikyqm/jvxGB38LKI9W
LnNxbY/RAaPzikTUuVmbQhKNft16UJntkAzLwolKw0INUYdfAo4J6uxGVxFkFq/P
hCI4+Nh2gj18+wd2OogCvr6txe6zi0iKH8ioTRjsSGroeielehanFH0RATd2Ho7w
y0bRXU1VSPmEGyi1YUKY
=4+W/
-----END PGP SIGNATURE-----

--JT7Km6uNxtC1LbQY--

--===============5658511813017215802==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5658511813017215802==--
