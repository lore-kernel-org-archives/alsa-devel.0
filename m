From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] ASoC: wm_adsp: Add code_probe and
 codec_remove stubs
Date: Tue, 9 Jun 2015 17:00:43 +0100
Message-ID: <20150609160043.GD14071@sirena.org.uk>
References: <1433863017-25349-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4378655852458202502=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 87990260532
 for <alsa-devel@alsa-project.org>; Tue,  9 Jun 2015 18:00:51 +0200 (CEST)
In-Reply-To: <1433863017-25349-1-git-send-email-rf@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============4378655852458202502==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3RfTNxEu1XWqbbj+"
Content-Disposition: inline


--3RfTNxEu1XWqbbj+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 09, 2015 at 04:16:56PM +0100, Richard Fitzgerald wrote:

> +	ret = wm_adsp2_codec_probe(&priv->core.adsp[0], codec);
> +	if (ret)
> +		return ret;
> +

I'm still not a big fan of the double registration that's being done -
if nothing else the fact that it's not also factoring out the creation
of the DSP controls seems wrong.

--3RfTNxEu1XWqbbj+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVdw2qAAoJECTWi3JdVIfQIP8H/RIowccXd0z4EMqmYUPVNqNH
QnHqeeBzJkUywYXnV2uKXEHa2vG5F9p6Bcd3uykKM0v8Lo/xtqTwYiEJTMlkbVd/
O0Z2v1WaRFgolDEBwx5qMyiD5gZfggTzNVRb3cvEzY/jRE8XOv5pEBvqMJVuz3Qx
+MDpVPdlTp0BdyMP/p16oswQaOpnIgwu2ooLm3yR/7Mx9HJLxYj8xUu/gYN8RQjh
qf2aS0ceRMcp2ZbRTYi7Iu/NvHpugal9ZHpwPxG3d0h6yzlME/f2/2FCbqBr/p0A
6BhibaTQv6ndlcZFTVzMqe2uyy719sFPUu7g647HRYEOhiTxQ/xQ+oXzdb7iSAs=
=uxhP
-----END PGP SIGNATURE-----

--3RfTNxEu1XWqbbj+--

--===============4378655852458202502==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4378655852458202502==--
