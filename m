From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: davinci-mcasp: Fix DIT only
 McASP instance support
Date: Mon, 2 Feb 2015 18:33:17 +0000
Message-ID: <20150202183317.GW21293@sirena.org.uk>
References: <1422880713-25414-1-git-send-email-peter.ujfalusi@ti.com>
 <1422880713-25414-3-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8048330016860897596=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 94D2D2606D9
 for <alsa-devel@alsa-project.org>; Mon,  2 Feb 2015 19:33:23 +0100 (CET)
In-Reply-To: <1422880713-25414-3-git-send-email-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, daniel@zonque.org
List-Id: alsa-devel@alsa-project.org


--===============8048330016860897596==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RRdy3lRbYtZ5U/43"
Content-Disposition: inline


--RRdy3lRbYtZ5U/43
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 02, 2015 at 02:38:33PM +0200, Peter Ujfalusi wrote:
> One of the McASP instances in DM646x line of DMSoC only supports DIT mode.
> This means that the given IP does not have support for rx and all the rx
> related resources are missing, like irq and DMA request.

Applied, thanks.

--RRdy3lRbYtZ5U/43
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUz8LsAAoJECTWi3JdVIfQG1gH/inmFnXo7kc+HuBpvw3kEq02
PLFhzWBugGKHCGqwcklBQChn2fKQjQTgD7BNcH+Ue0AscKCyfxpwUZpbieG0LXC1
+wTaefoap9HvT4/+TR35L/02c2tzq5nwkyIzSvXR/BED4VLY34XLS6d129w11Rsg
rfjJt4vVnG28bBnL1LugpfMQn12cFKoN7JH1A4mIayLGjjy7KA+aEgVCffRmogEb
nlZLpQmcxvcNyMq31AZnN/pVIo5cr7P2J1rEuzTQ5Ezf5nLoC5VSPEHRv9Izx0Gg
gs7PIvbdQLd9oSA+9jXCALXLblh7HCfJgiAClJcCix79rOWRjDdwsZ/Gbe8HMKI=
=3xHh
-----END PGP SIGNATURE-----

--RRdy3lRbYtZ5U/43--

--===============8048330016860897596==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8048330016860897596==--
