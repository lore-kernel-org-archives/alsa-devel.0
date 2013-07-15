From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: sgtl5000: defer the probe if clock
	is not found
Date: Mon, 15 Jul 2013 17:12:50 +0100
Message-ID: <20130715161250.GR11538@sirena.org.uk>
References: <1373900110-19929-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8192796233282453923=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 03E1C261698
 for <alsa-devel@alsa-project.org>; Mon, 15 Jul 2013 18:12:53 +0200 (CEST)
In-Reply-To: <1373900110-19929-1-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8192796233282453923==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VdnGiXwuH6t1Tqzo"
Content-Disposition: inline


--VdnGiXwuH6t1Tqzo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 15, 2013 at 10:55:10PM +0800, Shawn Guo wrote:
> It's not always the case that clock is already available when sgtl5000
> get probed at the first time, e.g. the clock is provided by CPU DAI
> which may be probed after sgtl5000.  So let's defer the probe when
> devm_clk_get() call fails and give it chance to try later.

My previous comments about this being better handled in the clock core
appear to have been ignored and...

> +		/* Defer the probe to see if the clk will be provided later */
> +		return ret == -ENOENT ? -EPROBE_DEFER : ret;

...please try to avoid the ternery operator, it's not helpful for
legibility.

--VdnGiXwuH6t1Tqzo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR5B9/AAoJELSic+t+oim9azMP/jaqwGBIoy45o81Dj7T1HyRM
abNdUdjp1P7rIVm2sHGqN7im/rv5VAthReKkddjCESjWVjbKytoEZcRxmXUK2YQ2
OsSA0GcVRjjOTFHfrej8ZNBq/VinJQ4+NX48GTRFLAoR4KmnPC9o79TmlkauDpHv
yZKbFU82gtQcSDcivNR4hpnTjfvdgDGmwNFodzPZHpJapv9T2WexDGWGSTBCRafB
2byEYDIhtpCmr1IoKKSv/gFsPKCx9UfGU9zjWOjL0nkwez4VtSJBNQPer53RfSs0
x1Vla9iXGNdRcGShHEZYdgYxfN0rTjdaY9q0TJbps2/vdHqptK4vBeplyi1yLLjV
vtHWg0odQ1MP/AOKiKTcOm6MxCyDlmbAGJ38irQWhP+wEqhcYZXLVE6mVudn77fm
1k+qVHQIDf5ivfKTOFEeT+QGaGaRBCdhtY3Nh3ZiF0GGOcGpqsLeqoB0c9HpQgFs
j9CZHcgwFDk03ZraRlV8QyGvsub2MaNHjmbRa+BKSYNOdMqhNuE2QK3D0q96xQzi
hqN14CGsQyujE2IS2xtXmEXlt9Ro2ZPbuPLC8pZdyDD3cheI+ly6DzHxgCzo5qOQ
DFeQH27J2scU9fvhBnEStHSmbJoH3d1NeeMrqU4O5ARNHCu53K3KUX3jTLjKg2eh
6lwmYPs4ABzXonMsexPf
=0k8x
-----END PGP SIGNATURE-----

--VdnGiXwuH6t1Tqzo--

--===============8192796233282453923==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8192796233282453923==--
