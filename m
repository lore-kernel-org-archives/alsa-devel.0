From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: sirf-audio-codec: Add missing
	Makefile entry
Date: Mon, 17 Mar 2014 17:00:49 +0000
Message-ID: <20140317170049.GV11706@sirena.org.uk>
References: <1394785572-28315-1-git-send-email-lars@metafoo.de>
 <1394785572-28315-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7493721065244928725=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id ED8802619F7
 for <alsa-devel@alsa-project.org>; Mon, 17 Mar 2014 18:01:02 +0100 (CET)
In-Reply-To: <1394785572-28315-2-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Rongjun Ying <rongjun.ying@csr.com>, Barry Song <baohua@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============7493721065244928725==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uOZhbHG+Ruum37TI"
Content-Disposition: inline


--uOZhbHG+Ruum37TI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 14, 2014 at 09:26:12AM +0100, Lars-Peter Clausen wrote:
> Without this the driver can't be built.

Yeah.  On the other hand until the issue with sharing the registers
between the CODEC and DAI drivers is resolved I'm not sure this is a bad
thing.  There were some patches for that which I didn't look at yet
though.

--uOZhbHG+Ruum37TI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTJyo+AAoJELSic+t+oim9DC8QAIEykGp42Q/JhsoV2fDmNSEg
WV+dl9RhzslpUCYjtYzHMAv2UskSZQY63s6NBIbVJ9Jzob2+iD3ZwqMjCl0dwHWp
TQAIoNa7shpsgGVU7ytxu/4yaIcpQ2oYCRYtKv0XwelUYl3PyJAVzR0x/433RZOy
R8QSsnWkJ35znHl7uvy/WCg2xuH52IoKIGasR5lvGBRDHXmzaymu2JjwF36UTfOP
jmDYoruW5GgSh60OjyusAjKPkvK7kL/cMTG8LX/Gz7NF2CNlGBSvzzZ4bHX24a41
TgUM7FqOApQHoGkqFDqQWrAXrDr9SIrgjP/MCwTjSeA+OXXivomG/v/x19LvKULE
wSXyQIXZlIOe/Yoh67CNMMKg89+fZo6wXXAm+uHpWv8Pe/VPnwv97FZLcd8CQftr
q0O39CulxcOypPuy7tLipcslmTA/c6EHDBNUaRtt4XkR90JDN6w+sRGYixooPkVf
YcbslKQTCvZaPpL3YE2wpTASc1+bVbQf2Wg5YvClbpwKJMnt4VsAgXnJj0/RiPtj
cJrexSSmWyg04rKh3A3sLeq/8lRrZSHr5UegWMNnRD2l3aVPxpuGGr7DWjhgkhfe
+OWm2TycNTkVPOiDS6EyXIHKCfFdqWCavyHq60o/l2F5Sh38RfVqOZ6AWApPSKnU
yO38dqOKQASDANU6TXDB
=NXcR
-----END PGP SIGNATURE-----

--uOZhbHG+Ruum37TI--

--===============7493721065244928725==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7493721065244928725==--
