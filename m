From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: wm0010: Add checking for .dfw info
	record version.
Date: Fri, 23 Nov 2012 21:44:53 +0900
Message-ID: <20121123124452.GM4529@opensource.wolfsonmicro.com>
References: <1353674255-23368-1-git-send-email-sl@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5116749129675109240=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D1386261647
 for <alsa-devel@alsa-project.org>; Fri, 23 Nov 2012 13:44:56 +0100 (CET)
In-Reply-To: <1353674255-23368-1-git-send-email-sl@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Scott Ling <sl@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, scott.ling@wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============5116749129675109240==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+gHRqQ1BTyNna/y8"
Content-Disposition: inline


--+gHRqQ1BTyNna/y8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 23, 2012 at 12:37:35PM +0000, Scott Ling wrote:
> The info record at the start of the dsp firmware file has been
> expanded to incorporate additional version information. We need
> to check the version to make sure we understand the layout of
> the information in the record. The srec2image tool is currently
> used to create this record during creation of the .dfw file.

Applied, but you really should send patches against the current
mainline...

--+gHRqQ1BTyNna/y8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQr2+bAAoJELSic+t+oim9m3kQAJI+lUpbbN56S56MgYgc1H3C
hYPeRSxgtOGSQ6sl5NPMKbvM60pnaUlNsY6QeGQmHKn4JTzUd75LdxABeoLG2Khl
IXMvajBnMPYflU3+KI/eWrauGay+2uLv8dari6al1TEoGWv8VqoKp93t7sIw2uvC
T19YP+QGRcaxjhOTN7coekGe6rUZbAoON/k/PzhSwxA4tib8bWzZUwyZQMQZ1VUv
2C8vt9xcw3KIoZczMIa5f02jyBkiNsDQygov7gsYe6a6PXgjaN+tG72e05Uyek0m
+xPTxRMP6qKOME6pofkrj3zRGDY/PVYJxljfuzO26ZohIFNh2NfrnTwt9LAM0dXH
JaX7xrF9GeMugUhu+4iCfdyX8OTz6xCaAJ6GqHq0GghBRJQsrw0kd8fXSqEyclPp
pdBlMDBgju+ziSlH+GKIsrWLdPj9OmtAOdILYf00idqhfMGNPbzwXq+E/IZr6X7X
FPcxzMPTfs3zmiy5j4y1C50J5oourl9JODUpZ70xi4mhcDfvTLKXjGCvt0J5aiVq
xyELi2N1ByEVtqkvnFY6ZrGWmpWkn45S+CvQT80XdQAuumt/5Tg+4qQlj94ANgCP
IKersjmHX0B1XaaAAlpWbxcii69FKf1HLCg0WxREooH5vy6jE5+C5dAxkd2TCEBk
T6NqctuV7Ksi/gTp7Ioh
=rcCv
-----END PGP SIGNATURE-----

--+gHRqQ1BTyNna/y8--

--===============5116749129675109240==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5116749129675109240==--
