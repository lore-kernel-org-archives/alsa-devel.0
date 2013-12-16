From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: sgtl5000: read chip revision for
	once
Date: Mon, 16 Dec 2013 20:15:00 +0000
Message-ID: <20131216201500.GS3185@sirena.org.uk>
References: <1386916983-27832-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0868527572640106548=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 42C162617AD
 for <alsa-devel@alsa-project.org>; Mon, 16 Dec 2013 21:15:03 +0100 (CET)
In-Reply-To: <1386916983-27832-1-git-send-email-shawn.guo@linaro.org>
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
Cc: alsa-devel@alsa-project.org, Xiubo Li <Li.Xiubo@freescale.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============0868527572640106548==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Pa4xkLBhPDIhDLv1"
Content-Disposition: inline


--Pa4xkLBhPDIhDLv1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 13, 2013 at 02:43:02PM +0800, Shawn Guo wrote:
> Store chip revision in struct sgtl5000_priv when sgtl5000_i2c_probe()
> reads it out from register, so that we can use it in
> sgtl5000_enable_regulators() with no need to read register again.

Applied, thanks.

--Pa4xkLBhPDIhDLv1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSr19BAAoJELSic+t+oim9apkQAI9jJin+SmoZ17fdMlXVbbou
GmZ+xxMNr+d5QxVJe0fRiJR+6G6yDKRzwSuQdY7fPiU2nVe7NIwq1DsuXHL2zTEI
dJZCBfmjyTDCipbEGgQ1xVYC/hLBtVy6Qg+wd/46HBQ8nmSB9+p/cy7pWSIrmUqE
pShFl65b00LJaWpTPxeytlmpN7QAKGc2Rm1dDMDEPXs9OQOX/+qbgFXrCTlHq1zA
Un396IEqF+M69sbgyvkbU//t+OFvu+nACLv/Xfw1DSdi3S6WPZKd0TLnLdPmFeAe
+jNtGGfOudNWc3HM4FgwdmHTtxrpiWGa348W0Vt4Qh3vwgaCFY0nHKCXugG5fubA
Zd4N49ElDLQhsiyN8fjF3ot45sDD4Bw+3XFNC0xKbp3vwZ3Qp6adgNBp1ZsjLZzK
ujOoCwOpNLiof+Qyc/2oJUWmXV3B43pLUtemvn7vv7Z7FZDeJcySV9IZ19CggPED
RKi0Bmjr4eJ1P2uW2Cb/Dm2dCx8825ZDcGajCrDrXfqvxBaREYSrEkssOVikjQbp
Os68C3TX+EqTiceG4VmGrXvMhOdBgMOJiFgqWR12m9MpkeYXDa+ZwQo9JcuBiEny
Ozj99b6WxppdDoSCNNB8K79XugVbNVJpdDdv2hdC2DXcKZoNG/GJD5iFPumgn6bG
u7IjDKOomfrfovOuV6Le
=moRU
-----END PGP SIGNATURE-----

--Pa4xkLBhPDIhDLv1--

--===============0868527572640106548==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0868527572640106548==--
