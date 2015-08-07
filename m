From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: fsl-sai: add 32 bit word length
 support
Date: Fri, 7 Aug 2015 14:19:45 +0100
Message-ID: <20150807131945.GE10301@sirena.org.uk>
References: <35057b1d49085839cdd1c6514a6ed7b690c713e9.1438928571.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3572920454412436221=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7EF8B26172C
 for <alsa-devel@alsa-project.org>; Fri,  7 Aug 2015 15:20:00 +0200 (CEST)
In-Reply-To: <35057b1d49085839cdd1c6514a6ed7b690c713e9.1438928571.git.zidan.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <zidan.wang@freescale.com>
Cc: alsa-devel@alsa-project.org, timur@tabi.org, Xiubo.Lee@gmail.com, lgirdwood@gmail.com, tiwai@suse.com, nicoleotsuka@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============3572920454412436221==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="phCU5ROyZO6kBE05"
Content-Disposition: inline


--phCU5ROyZO6kBE05
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 07, 2015 at 02:23:51PM +0800, Zidan Wang wrote:
> Add 32 bit word length support.

I notice that you're adding support for new platforms along with this -
does this support depend on the platform?  You should also have a note
in the commit log explaining that there are no code changes required in
the driver except the capability define since it already just writes the
width directly to the hardware.

--phCU5ROyZO6kBE05
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVxLBwAAoJECTWi3JdVIfQSNcIAIFOnUXypK1q9Nz5aLmbyqBd
vQY9E4qNN2q4jK801vEMxBHxR6Vij5Dp/CuaigVjxlP4UpzD1Xh7tHehhUngUaVI
qBTT9I3m1ScuZs0GDFI72Ithd0TBraRgvn5b6Qk7RGlzFq+7GlFNLpH+iSLs2LPE
ONJpSL1ib4VdoK51gYHdT+AFUHmEdn/iLvisGuXWZhmiydfklwcpDFucFgrf960z
ZzOA3pz/YyIew+kyaYrcmwT69M1Lk9SzNcrCBQ8kNqLv1AkopC9taGmbc4Rh90fS
I+LX4UKd2ArlmBIV2dk19WbGxCnAycHPWIdXoXqONUS/CqAXpvsLTLM0JwKAO3o=
=Ohh0
-----END PGP SIGNATURE-----

--phCU5ROyZO6kBE05--

--===============3572920454412436221==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3572920454412436221==--
