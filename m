From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/4] ASoC: davinci-mcasp: Code cleanup in
 davinci_mcasp_hw_params()
Date: Fri, 31 Jan 2014 16:11:53 +0000
Message-ID: <20140131161153.GL22609@sirena.org.uk>
References: <1391087725-4088-1-git-send-email-peter.ujfalusi@ti.com>
 <1391087725-4088-5-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6817443785489972420=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 15C9A261B19
 for <alsa-devel@alsa-project.org>; Fri, 31 Jan 2014 17:12:00 +0100 (CET)
In-Reply-To: <1391087725-4088-5-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, nsekhar@ti.com, Liam Girdwood <lgirdwood@gmail.com>, jsarha@ti.com, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============6817443785489972420==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Rl6QTk5rIKeAVhSO"
Content-Disposition: inline


--Rl6QTk5rIKeAVhSO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 30, 2014 at 03:15:25PM +0200, Peter Ujfalusi wrote:
> Rearrange the code in the function for readability.

This doesn't apply cleanly on my topic/davinci, presumably because of
Jiri's recent work though I didn't look too hard.  Can you please check
and resend?

--Rl6QTk5rIKeAVhSO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS68tGAAoJELSic+t+oim9fyAP/2hnBLF5AJhM1CctsSYu+M2m
bqjRkuJhzD2FmMid1ninpgNsAlIpFnFmBlD0pWyKQIhavHdj5lJSuCg6KUfF0FtL
TxK7Bsew1GWAC5OIoe1CwAnw0WY5zZlnlChtQMKEK8e6nL/w4WypmUPXGcLHvJJ4
0vwE1pPmeYaunmw7QRoRmc5KrKrlLAEqV5YuqieeIJqj1C6te2k9YJpXNrN/aq+Q
2m/FW5GeoOd4+uT8lZdZCFwQdA+EZdvJ71W6SukclIs2DqzDh1Wj0hd+lcEGQyR3
O0BUVLKw8oRLAw+ZS7RM8ifE9Fuva4kZVwx1nFyiFfZ/GfxHGzAQW5u9NgmICN8y
BTCZ53QWxY4+GrcvzCWOM7nyHDoC1YmJ3H6Nv+c5Kis/NCELvNBFK5Obo70bLS6Q
rIqNh5aIT2RtoIR6w+JLOxP3ZCHqfjUgacnqfvrvzFquknVkOenOu3xqdI6/fxTU
DbVHiBNlvN+gIcN07h+VobPMAoieow1XkXGaH6/IZzb6dvQdWKstT2Nj8+WXo+K9
ln8qZfWxzUMnHUTkKcxNklN4zkhDM/J/nvFtcPLHKCPOZr8fslSkcoph25p1o/W1
CFt7VdgrbvajktHZ2L1BloPkt0sqcv+GJpqSs0Xu3W4Vm+wz5Wq9lpsLNQQUT2IV
gfIDPGKxizhewi7EjNsv
=lDMr
-----END PGP SIGNATURE-----

--Rl6QTk5rIKeAVhSO--

--===============6817443785489972420==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6817443785489972420==--
