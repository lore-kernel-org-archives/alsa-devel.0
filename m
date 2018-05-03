From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: nau8810: change the target of
	MIC BIAS supply
Date: Fri, 4 May 2018 08:10:47 +0900
Message-ID: <20180503231047.GB13402@sirena.org.uk>
References: <1525315602-3620-1-git-send-email-KCHSU0@nuvoton.com>
 <1525315602-3620-2-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3854486625340522159=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E3497266F44
 for <alsa-devel@alsa-project.org>; Fri,  4 May 2018 01:11:07 +0200 (CEST)
In-Reply-To: <1525315602-3620-2-git-send-email-KCHSU0@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: alsa-devel@alsa-project.org, CFYU0@nuvoton.com, WTLI@nuvoton.com, lgirdwood@gmail.com, YHCHuang@nuvoton.com, CTLIN0@nuvoton.com, YCPENG7@nuvoton.com
List-Id: alsa-devel@alsa-project.org


--===============3854486625340522159==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KFztAG8eRSV9hGtP"
Content-Disposition: inline


--KFztAG8eRSV9hGtP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 03, 2018 at 10:46:42AM +0800, John Hsu wrote:
> The MICBAIS will not supply if there is only one path from MICP to
> input boost stage. The driver fixes the issue by changing the supply
> target to input boost stage mixer.

Does the input boost stage actually use the MICBIAS supply directly?
More usually a microphone bias would supply the microphone rather than
anything on the chip itself.

--KFztAG8eRSV9hGtP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrrlvYACgkQJNaLcl1U
h9DiHAf+J8T2ozrzbqNGTLWUM8TW/NHUonBf9Yq3/NR7e/zIp1ZISjua3s5vWPEO
S35KpfuUWbrRPCF+f+Nkf6aJvOpcPtlTi8MvV+iGzTyYRmBpNpnl2vaXnh0TyVq0
CNR1aGFNFyL2VEiANgwvMSibgKlcm/OK5I7zNM6Fa1K+fGoxC/eYDNOFa5OjYbOy
4luFZcLbtAzhtXVNCLT+H0L487M2EvCA5ptH1ZHnPNM4PcxtBrTNm3QdaQM2L3nB
wTQoojim2jH27IJ5sYFJP5kZND5M7rF+3udGnaL93AQctMjDJP/6qfKtdvey5edK
IcoKloUkwSID2yq6k5CuZ/1/FNeBqg==
=RDds
-----END PGP SIGNATURE-----

--KFztAG8eRSV9hGtP--

--===============3854486625340522159==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3854486625340522159==--
