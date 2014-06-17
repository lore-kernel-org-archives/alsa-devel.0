From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: fsl-ssi: fix do_div build warning
 in fsl_ssi_set_bclk()
Date: Tue, 17 Jun 2014 15:45:05 +0100
Message-ID: <20140617144505.GV5099@sirena.org.uk>
References: <1402663360-15377-1-git-send-email-timur@tabi.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8641087551658096450=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3CC0D2654A7
 for <alsa-devel@alsa-project.org>; Tue, 17 Jun 2014 16:45:11 +0200 (CEST)
In-Reply-To: <1402663360-15377-1-git-send-email-timur@tabi.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@tabi.org>
Cc: nicoleotsuka@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8641087551658096450==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TtEoAK7RgeNCqf2w"
Content-Disposition: inline


--TtEoAK7RgeNCqf2w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 13, 2014 at 07:42:40AM -0500, Timur Tabi wrote:
> do_div() requires that the first parameter is a 64-bit integer,
> which but clkrate was defined as an unsigned long.  This caused
> the following warnings:

Applied, thanks.

--TtEoAK7RgeNCqf2w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJToFRuAAoJELSic+t+oim9H6cQAJtltzu/ETGpEkm1BMP9/5Wh
gF8IJvSoRCG9d1k6/ZKq7Vc4btE1Bjw6FjWFN1b1Uko1V/4aZEGXWNcD8dqFYdTC
TaNdRHmQnmugSSqVNW9rLA6w2QBIsgfawo40EOEYhbtQWjE9tIQP+bBr23ink5AT
mWJMeo6CeQ8m0gYRoruFTuM5QDwHnt+M33ZFhj7TdIV43hB74kWJVrqzxnaYSGx3
yl8wXi1KvPmf5zkrOPpt6mQ3Zj5bGp5Ib947vS2IZG1eWRkfdiVPivH1YzoLd+zg
5e0ybY0DneK4asqWEc+1hwET9cBM6E2aRXffHdfsa/h2ZeJGbeiHsPLUCbyRHZik
AZ7htY0aa1J9mw40hpUxRrOFcNYDc2VlvnmAB579dEtS4n9B/G9RmgZsIaH21pRU
Da7POSdd9cvaCszEdeTqiEVmBnXUPhmhGJYAHwuDDOptrvw69YCtWMS2kZMOVdFI
4vcOzFi1tGQjMk0+LMjqBnhtg2JvLOeiHFgG1gMaoGBy6J0baLRFyAz/fb47wpCa
mzqc2xceAY8zwzSCTJNPezH0rmtNvY2Ha86MZPq/qFLQhy45ooihnHX6H1+xyWHt
4y5zoGSkFYrl5D+DZWMFkTh/JQgeu0e3lpnf0sjktDbLnDl80wahxaaN8DR0lG0C
BPxc+U0HoJkoxbWKgISZ
=7INk
-----END PGP SIGNATURE-----

--TtEoAK7RgeNCqf2w--

--===============8641087551658096450==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8641087551658096450==--
