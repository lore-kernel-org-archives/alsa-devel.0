From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3] ASoC: add RT286 CODEC driver
Date: Fri, 7 Feb 2014 21:02:24 +0000
Message-ID: <20140207210224.GO1757@sirena.org.uk>
References: <1386727090-15543-1-git-send-email-bardliao@realtek.com>
 <20131218192040.GN31886@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D702946A@RTITMBSV03.realtek.com.tw>
 <20140207125103.GJ32298@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D70297E2@RTITMBSV03.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7404915309989573807=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0DB2D2654BE
 for <alsa-devel@alsa-project.org>; Fri,  7 Feb 2014 22:25:58 +0100 (CET)
In-Reply-To: <ABFD875FF5FB574BA706497D987D48D70297E2@RTITMBSV03.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Flove <flove@realtek.com>, "leon@leon.nu" <leon@leon.nu>
List-Id: alsa-devel@alsa-project.org


--===============7404915309989573807==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RHdRtM27np9fZUoh"
Content-Disposition: inline


--RHdRtM27np9fZUoh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 07, 2014 at 01:45:45PM +0000, Bard Liao wrote:

> The problem I meet is rt286 uses different registers for read and write the same bits.
> That's why I didn't use SOC_DAPM_SINGLE_AUTODISABLE() control here.

OK, so same thing as a lot of the other code in the driver - less magic
numbers and more documentation so this is clearer please.

--RHdRtM27np9fZUoh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS9UncAAoJELSic+t+oim9ANMP/32cU+nyiXliHPNdc/sJO9Ew
F3MCAJ66DsNif7IH6R6zEPFKx/yudNjcxistmm3slhI6dq1O1+2ERDtEnAeZAK98
GwK083EFSHfrSz0XPu80RXwCrnXgETAC4jVXgj5eSAejjniirfj/mzIV3J9KGbqf
YWF7El1p4Ia5jieWdj+6QrCVdoeeJZj+Btpg1Xy8g54dZMidD7rQxmiVBRncTH/L
tjZnmCp3FzNbmi3ZTlq1ma/Y1AxxhlENaa2JbqK8EWixwZyFBvGxk/tr9R29vzgh
fJXcdxLlqLBOKlKMwapNU5nMJudsc8QF2At7voHeNTd9NDu8+lRMmkMIfrYfIQBR
wmpuLEnz3Y5Ma2LIJvGlL0jlrgXjBXDgW85TQx3GmnqwXduSRJqWUtDh2dsiAEjz
r1O0UabpldJwlU3IxYP2nUAa9wdcwpn61P842TUSprL8NbF1pDjLK5pm7P1P/q0E
ydl9pxtsvNdEW++EjGaI9lZC9opaZHWBcgk5bKbD4RJB2Bvob3xph96Ex/kkkD9o
I/PHUnR6VEEKbL6rv32PwJL3v+2hObJsi08cRfxOMkO+QtE3mM0dLhG0zHvZIIxr
wMulcKtGTJDh3VTWULezGxT4Zb1Msi5ntnUIW61RFh9rH4sbn07ct6rThoAMZB0x
Lsu2twhRr9Pqju6+EUJN
=8eV9
-----END PGP SIGNATURE-----

--RHdRtM27np9fZUoh--

--===============7404915309989573807==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7404915309989573807==--
