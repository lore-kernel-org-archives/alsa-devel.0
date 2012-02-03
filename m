From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 18/19] ASoC: fsi: fixup fsi_pointer()
	calculation method
Date: Fri, 3 Feb 2012 11:55:22 +0000
Message-ID: <20120203115522.GG3151@opensource.wolfsonmicro.com>
References: <871uqcjo9i.wl%kuninori.morimoto.gx@renesas.com>
	<87bopgi97k.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7426274128520137119=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E9F06103884
	for <alsa-devel@alsa-project.org>; Fri,  3 Feb 2012 12:55:25 +0100 (CET)
In-Reply-To: <87bopgi97k.wl%kuninori.morimoto.gx@renesas.com>
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


--===============7426274128520137119==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qxfKREH7IwbezJ+T"
Content-Disposition: inline


--qxfKREH7IwbezJ+T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 03, 2012 at 12:59:15AM -0800, Kuninori Morimoto wrote:
> current fsi_pointer() calculation was not correct for FSI driver.
> This patch fix it up.

This looks like a bug fix which we should send for version 3.3 but it's
patch 18/19.  Is there any dependency?  If there is a dependency can you
provide a version that applies against version 3.3 so that we can get
the fix into the next release please.

--qxfKREH7IwbezJ+T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPK8sgAAoJEBus8iNuMP3dtKQP/17zopPhsHz+HaZBv3cOkMrs
K8YbKLeuxJJNI+IhSX3NJ432qNf2a5FnDHZHEGEL9qBeCahBftUgnHnO7aKfwHvE
G+E/bX/HC4Q4Wuwm2ccdgyDvbCK0rN5kywIfplts9Ny3c+LpQjuN3R2vGAEdZ54V
mqgMDar4qx79IbeuevDNLmT682qBWLmgBlUQePmbTFzfx/EjoC69Vv1OybXMaQkC
IvENkmb034RgomMg+N0lMVVkzHqo4mRLVvhgVCyNtKXQsq68icsv1bFQU+VzzXbB
i80iRdD6fnMHgYGBzLleFnZxMGbKBZkOz22O6x4yx+tN1TBAvH0yoRL/iNFwaG56
kjebepjnSGFJ2q8xbyGdhiIddYLfJM9+WqhitF5u2TxqAoDuzZiEwZ3VnPcK2Ku4
EUrEm3k6nZ10f3QEIvlwJczYUWYNuko8YOlMJ9WhPVqYyAkWQhsDV0U3O0NGNrWw
S1+IpTnYLhcAVkmuEB6sJIHvVY60/Sy1dPg+0Bl6Y79p2bVo+BaExJWDry/xA6um
RWqsxWwwa9woC82lm32orMKABxvlwkBfH29BtTfhQIDkAJvEp0gkHivGb4jBnJ9w
uzKcPBohPmqF63OGionvkJMaZa4MCEDWAC/O24C0LxrJxFQ8I81IyAcC2ZzmqiMm
n3qOQ1StEAHEWZfXUpfo
=PaAB
-----END PGP SIGNATURE-----

--qxfKREH7IwbezJ+T--

--===============7426274128520137119==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7426274128520137119==--
