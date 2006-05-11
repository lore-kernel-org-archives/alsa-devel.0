From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: alsamixer and short slider
Date: Thu, 11 May 2006 17:32:25 +0200
Message-ID: <1147361545.5330.0.camel@johannes>
References: <1147358935.4692.2.camel@johannes>
	 <s5hvesc1u3j.wl%tiwai@suse.de> <1147360673.4692.17.camel@johannes>
	 <s5hlkt81t50.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-cCDdRZIVxQB9pe/dNKmm"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hlkt81t50.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-cCDdRZIVxQB9pe/dNKmm
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-05-11 at 17:24 +0200, Takashi Iwai wrote:
> > Well, it tries to, but like I said, I cannot select anything but 0, 4,
> > 7, 11 and 14, but for a range of 3..28 it should be selecting
> > approximately every 4 items from 0 to 100.
>=20
> Sounds like the minimum value 3 isn't handled properly but assumed the
> range 0-28.

No not really, if I turn it down all the way it sets it to 3. I'm
inclined to believe that there's a rounding error, but the numbers are
all large enough. Not sure.

> Does amixer work as expected?

Yes, I think so.

johannes

--=-cCDdRZIVxQB9pe/dNKmm
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARGNZB6Vg1VMiehFYAQJ2sg//dB5fcyyvqY/L/Ths3qIhBNV/XIVjH2yR
SjUusk0f2dYSrw7/+gS2T5NbzHEWwwCZqChuj3ePmb24o7x0onoG1mRQC2E+VfR+
uuXDRI/fbgSWSyXfNyk9/swZklVg1RerFs4890gJmHC/K8rqHdgkVX7VhKl3PExx
NflRrqXbBYwcpe9pPh/PlyEiTF5VxLJD+jAsEeM7yOFBPeYq69YPzdgxuHx7d761
4pQn51VoukWNTN37drPSjFKrxwKO08BCU+Aegb4+C/0njSJABbOi3ZlLq7eByPTH
R6XPqg6ozepUZ39omhMTar/H8eP7d4fOiNZLFP8w/mtKqzeITlZZ5Az8qCZAUBR+
tqmvqBozIrOty/XXwTF4awCp/WFb4a8mJ58z7A/OWX8cm5sgJ37rdXp6mbgGAsCb
4+ruXMRf3bqJ2V1d7AdcfWWUk5upWzDX+epw85faGRAdu5FEACl6RSEy2k0fgWg2
WmZHgc+eM70asRTWAtGUaAZw+xsq5r2nIgx/CvE5rd8kFBmCm8y8EWZT2gddjPRz
k9Lqz2YNGxCdIkugrRX3x+mhFHtSOFoyUcNff3/ceteFsv3LauviiBILWelhsVli
TA5MGmK8IXkry4l4AoK23NdpE7ghuX4ScR/J7GyRtV2TpOEqzoCa7yBwYpPYqFyP
v705FpgDKiQ=
=mN3R
-----END PGP SIGNATURE-----

--=-cCDdRZIVxQB9pe/dNKmm--



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
