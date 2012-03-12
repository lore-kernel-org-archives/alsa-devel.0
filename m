From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: omap-mcbsp: Export functions for
 threshold configuration
Date: Mon, 12 Mar 2012 12:17:33 +0000
Message-ID: <20120312121733.GH3110@opensource.wolfsonmicro.com>
References: <1331550064-28349-1-git-send-email-peter.ujfalusi@ti.com>
	<20120312115954.GF3110@opensource.wolfsonmicro.com>
	<1331554230.13303.14.camel@odin>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2216089829043013188=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B60A7103F9F
	for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2012 13:17:35 +0100 (CET)
In-Reply-To: <1331554230.13303.14.camel@odin>
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org


--===============2216089829043013188==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JI+G0+mN8WmwPnOn"
Content-Disposition: inline


--JI+G0+mN8WmwPnOn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 12, 2012 at 12:10:30PM +0000, Liam Girdwood wrote:

> I agree, but in this case the ABE series will be huge. We're trying to
> break this into smaller and more digestible chunks rather than a massive
> series.=20

> The commit message here should have been more descriptive and described
> the ABE use case.

Yeah, or just mix this in with whatever part of the series needs the
export (indeed it might make sense to add the export and the user in the
same commit).  Splitting the series up a bit is good but this is going
to the other extreme!

--JI+G0+mN8WmwPnOn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPXelUAAoJEBus8iNuMP3d1EwP/iJO5NsSRwUp6BkjaEFIp527
Z7JGWVEh5GZSOmXaTFHRoABji65Ob0RGtu6OyiliWMI6Qf/oxMrTmKhZiHqoBhC/
+oikkuDY1vKjDON/+MP8IzlAf61aTCE224XXTqBvOxFTP8fG7x/SpdMdPG60HWyy
IeY0fUBmG/tafqV8cPjNrrq1vE2jzrTPYvZyZujOE9zstowzp+Gr+FypjAl3e48j
+M7ngyKq5RS6D0VC81kD2I8gXegJkkSUnc1s74bFn+OcN08vy9uOW22h0osdRIO5
bFITS0ZsY2lnmH7FkGIjP3BoZZ5TTtXqLnkw9ZkpC/7DZNlpTeF42oatZ9/j5vdq
Xkf5E7npW91EIhEPPrPSRrQdE+QrsFbT2/fDPHifSsmRtpmh2TKR6b3WVt9eMCS+
ikR0DdJ1ZHcj0BzTiKiVh55TlAza4r0GtKCpoIbr3mJSP4PPTjX0TDqsLZKOcZxF
ihGpDroYhLvYQ89/eULGx0okZoj6yL519YyszuNfN2P/k9//B8RiV64sud6DEwaq
3jA2vk4kzxtkzvoa4MQE0z5V/mdLlD6zFWsnlzN9loYckowrAEk7FmB3iJOAnzj1
ljFzrOxIYRmthwAvYmUG+xRFrAqr1ndcHF8YsxCPvQEQEXgjkfxk4dLM/mEdZ4CA
uFO5EYGicrb/oUhtl3j2
=p48d
-----END PGP SIGNATURE-----

--JI+G0+mN8WmwPnOn--

--===============2216089829043013188==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2216089829043013188==--
