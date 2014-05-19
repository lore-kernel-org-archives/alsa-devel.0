From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: Remove needless
 snd_soc_dapm_sync() from machine driver inits
Date: Mon, 19 May 2014 17:19:39 +0100
Message-ID: <20140519161939.GC12304@sirena.org.uk>
References: <1400505447-8313-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6527841432502010494=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 57B2F260862
 for <alsa-devel@alsa-project.org>; Mon, 19 May 2014 18:19:52 +0200 (CEST)
In-Reply-To: <1400505447-8313-1-git-send-email-jarkko.nikula@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6527841432502010494==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p/zPc3xDMI/3LIaL"
Content-Disposition: inline


--p/zPc3xDMI/3LIaL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 19, 2014 at 04:17:26PM +0300, Jarkko Nikula wrote:
> ALSA SoC core takes care of calling snd_soc_dapm_sync() at the end
> snd_soc_instantiate_card() so there is no need to call it from machine
> driver init functions.

Applied both, thanks.

--p/zPc3xDMI/3LIaL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTei8YAAoJELSic+t+oim9QcoP/2HUh0oH19I3KTh/JiPwhbsa
EvcRDbBHaCZiOcAYrJJYQ7A/PnLoibWITEsZUSoO/qPKuwaKDXjc0ww7BN+69vrR
LlEr+vhGRV2ffPDRe/n7555ZFP/Ey4IlHfR6ZHoO5p62ZIfdhZoh9pp+XSnao7hd
sSG1GuiZ/FXnhvHE2HtTzw3U0lug8llz9j3QF7qUVfIdWgmLBs967Uv6mPQNltqQ
aW6lZakLcXVxW8Yh8iX+WEjQ4hVmDzuWq7XoU20CLYmqfeGea++LJMCGigChiYBw
y1+drShyuexY4w80zDzT5/sruZdokgL8uhbNS4S4xGHSfPk9KprvMgyr6gaCpssL
pnpsk7sVFrPOR9YdEPiecgRRAc19yDhSBNTvpFzmIWPtv/EQisBYTsVwnPQZd0qP
LVHdn6ENCPZzyP92GvVAdFa+V8JMZtWmWA66nzs94vJavUkvfWs5teMgrifDzgzw
lMv4W/tLM5vIK6yTNARpV1hO5jEMMxfvqq5Gkvie3SQJBrnyvfVQuDJxkXam3d1t
y5+aDM6QxlDrsZTgyot6sqyQOKurPFPAhcZtL2pUYqPGaYYCY+wNbbYliXjMSIvi
7Eutm4TdduuiIjfPqFWVR1L0sC+GHes5i4wdJ+N7iWz6di0+OjL6dCuhC+6fAtKl
V6St6Vz0sWovtvQDHQGr
=QQ3o
-----END PGP SIGNATURE-----

--p/zPc3xDMI/3LIaL--

--===============6527841432502010494==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6527841432502010494==--
