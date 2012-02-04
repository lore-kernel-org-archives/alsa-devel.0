From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: core - Add support for DAI and
	machine kcontrols.
Date: Sat, 4 Feb 2012 12:42:32 +0000
Message-ID: <20120204124232.GB8042@opensource.wolfsonmicro.com>
References: <1328290989-14399-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5190313231758237636=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 164CE24154
	for <alsa-devel@alsa-project.org>; Sat,  4 Feb 2012 13:42:36 +0100 (CET)
In-Reply-To: <1328290989-14399-1-git-send-email-lrg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============5190313231758237636==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RASg3xLB4tUQ4RcS"
Content-Disposition: inline


--RASg3xLB4tUQ4RcS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 03, 2012 at 05:43:09PM +0000, Liam Girdwood wrote:
> Currently ASoC can only add kcontrols using codec and platform component device
> handles. It's also desirable to add kcontrols for DAIs (i.e. McBSP) and for
> SoC card machine drivers too. This allows the kcontrol to have a direct handle to
> the parent ASoC component DAI/SoC Card/Platform/Codec device and hence easily
> get it's private data.

Applied, thanks.

--RASg3xLB4tUQ4RcS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPLSeoAAoJEBus8iNuMP3dstkP/jXAe/CWmQG2V5+RMbQ8/VKf
KNgeEEyB2PfBgASKskhEIrpyuS4LJAtAy1cw8k5iIwR8bUcenCfvUYysEcXkQqD9
2W4YysAqzUaGsEZPfds+Yy3547YoEo94t8vcPCXVKo5PyT7h3IHJd+g2Sy/0zF01
XMFtdV/PG1mm0nMBbSbe//2GamnGsisKQIeNyeh+os6vurKT2iRdBLEmB+SzpaWr
3+ZgjkBARIJ0xSQU7olOQrXaqPafNQkMFOYemktfEke42kkHfKA2iQ/LlkxrWqtv
2zogjXI3zrTAs0kAeUwaiBR+6wfsGuhNd/vvF9YPoScFPVDUqEavufgoZtWiW2B8
3NdCXlZLHnX18tFEg2BQXw9m0bcInuX5+dgLu3dYPDvq/bnjgBAkhSs4PDaEVC4K
0XVQA66BYFBF9j7gWWDCiuA1qCo7/vJPsnLQqvTp903EFJiNzI9+vSs25Z3wx/7o
9qtJTMk0q5hWNZ3VfJrvR9Nhtlt1eqIbfze4WCrldNWgvIRC9NPpCWDInsZ7+Kpk
yvHLmCXwLzjZFdRktl49oSsEsqf7y7X0vOij89fftr2VQC6UyKUS505pmtxieKXD
+DjFMpne8OeWxzL0S3ssiG+acAROb/wZnMjckpdWUH/z4F9KgaUXsblOxtz1VV+V
W+SgK0Wte6xiaYq0szy2
=it6g
-----END PGP SIGNATURE-----

--RASg3xLB4tUQ4RcS--

--===============5190313231758237636==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5190313231758237636==--
