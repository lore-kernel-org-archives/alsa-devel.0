From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: ssm2518: Fix off-by-one error by
	ffs()
Date: Thu, 2 Jan 2014 11:54:38 +0000
Message-ID: <20140102115438.GV31886@sirena.org.uk>
References: <1387795375-17083-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6295020168788472370=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id EF4EA261685
 for <alsa-devel@alsa-project.org>; Thu,  2 Jan 2014 12:54:41 +0100 (CET)
In-Reply-To: <1387795375-17083-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6295020168788472370==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tnSXTZOLuLJuusSZ"
Content-Disposition: inline


--tnSXTZOLuLJuusSZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 23, 2013 at 11:42:55AM +0100, Takashi Iwai wrote:
> ffs() returns the bit position from 1, while the ssm2158 driver code
> assumes it being 0-based.  Also, the bit mask computation of the two
> channel slots are incorrect; it must have worked just casually.

Applied, thanks.

--tnSXTZOLuLJuusSZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSxVN7AAoJELSic+t+oim9TfcP/jDAJWAnIlHSbW47yn3H687D
Ao9Y3bJ6aUdWozJQNnLL9YGjVYeOqtMlSRQ9JuanUYLIraSAIsEkcCwUtGIVLpue
+S3Xj8qBmocPcd5KVZ1TCe28kmHwGYX9pOsbXgs4rUfO2KO3ivUWcivvaqc5CWB4
rli4pR2uxXmSKsSjzxMZofO0lt81tU8acjY9cRnWYP5bE4tOFSGWZLdrqco8bwCk
PNq8tqJlpX5qQ6FdIQjXrQVmRz8BFQlgyyQ0/2ojhCTwobG21qgSgKMQi94XeO/3
jbUfv1DqZxesoj/V5bGelH7V6FfoywPS7b1S2yBWMAoyzesau+bTC9ZhWrBI8E5f
qFprlGrOYZZRWQ2LpIqwYMJ4x6OPLhYZF2BBbaCrg/QPekUR51u+tWLeN3TqvhVk
AHNCnca6rGBEMomtD7zFBmnZ6KWr/spmdCgHbADivdk8plBskp9xi3ouOZSDS53Y
lq2EtC77iMzdfITwsLTsdjkOzvF+d1mXL0TM32e+DSbHhvsdZNMCyYk8WQk747zV
S+A++SeYmclVElBIO+cv0nOqwrcDDDCMMljdJ9ACMx7ZqIElXN1xZyAH5doKEtaH
HuTtzbrBv5ibQBrmia7+P8A6Wh2fedCYOMIylsHfRK+7p/VDAM76x5xrRromq3FK
rIoJckgKFDsXhFORXF+L
=zvNe
-----END PGP SIGNATURE-----

--tnSXTZOLuLJuusSZ--

--===============6295020168788472370==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6295020168788472370==--
