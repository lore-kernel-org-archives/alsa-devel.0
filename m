From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: twl4030: Debug code cleanup
Date: Mon, 20 Feb 2012 07:48:14 -0800
Message-ID: <20120220154811.GD3258@opensource.wolfsonmicro.com>
References: <1329747122-20878-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5388784562026908075=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 28A1824375
	for <alsa-devel@alsa-project.org>; Mon, 20 Feb 2012 16:48:24 +0100 (CET)
In-Reply-To: <1329747122-20878-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============5388784562026908075==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8w3uRX/HFJGApMzv"
Content-Disposition: inline


--8w3uRX/HFJGApMzv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 20, 2012 at 04:12:02PM +0200, Peter Ujfalusi wrote:
> Replace the printk(KERN_ERR* instances with dev_err in the driver.
> While we are here clean up some of the debug messages as well.

I tried to apply this but it looks like it's got collisions with some of
your other twl work which isn't in my tree yet.  Probably best to either
merge it via that path or leave it until all the merges sort themselves
out.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

in case it's useful.

--8w3uRX/HFJGApMzv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPQms0AAoJEBus8iNuMP3df1UP/jJ63mBiNkboEo1ct8L027jn
Jz5808EXI2EJ58fgZjHwMZtEMJ1thpT+wlhXbBPaQHhydBI//+eKRIBSkjxSkSTX
fvrYeVF+DhqSO5Izae8pmykKVj2tCD+IH6bUQpoqWN1w2MzKNiAYusLrw/fA1eno
KqEcy+yEtISfGm+3J0UdkYRgPP1e84PFuzp0t16x15mDbfEcNGtO9hV92Yg3wFhn
l/TlL8F28UR/KBy8jth3fS8M+um8+6PbGJCaiBtbKPY7HN39BLxCkc5FM66CKMLK
XjvSNE+LtqTDrBGXPPqZnnoerEWJyVLFeG0Arp7ZBvoXBoIC3Lipfn3r5W8NoaIX
S79aHXKeC7wfP8EYjrH0NFe60n/pDnP9uUMIa2hxo/TQsuupSPLuESi6w3IGVAG5
kb1B+4/YHPInhHmJcrANCd//iaFA+0lLe+jQ2ThwhJybm0Zy3d9KX8n9o0TghpP+
LKnNGTFmNWZlquWAb50pMGbL4NRgl9TNQv4xzM3hg9fHC9HQv6SEzVosZ04Gp0gB
RSpo+z3QpHrrvubMmkR2w+UOHrTTPb1/lVFLzfH6sSHunFymoPK7cbpyepnQPLP/
lvzefnHdc3fWnkK6SbRhjcH+Yk/cQw/soOnK2WQXi3u/b7GKD+SjZqzoVL5memDu
m+bC5u14zolxdPdP6rTh
=iBxy
-----END PGP SIGNATURE-----

--8w3uRX/HFJGApMzv--

--===============5388784562026908075==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5388784562026908075==--
