From: "Tais M. Hansen" <tais.hansen@osd.dk>
Subject: Re: [Alsa-user] Upgrade problems -addendum
Date: Thu, 23 Jan 2003 01:35:53 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200301230135.58325.tais.hansen@osd.dk>
References: <200301221234.33054.tais.hansen@osd.dk> <200301221647.05780.tais.hansen@osd.dk> <s5hlm1dyx08.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_TN55X2GLPEEVZ9P49ZIK"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hlm1dyx08.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--------------Boundary-00=_TN55X2GLPEEVZ9P49ZIK
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wednesday 22 January 2003 17:23, Takashi Iwai wrote:
> could you test the following two patches?
> with the first one, the driver will calculate the current pointer like
> VIA686 does.  if this is ok, no messages will appear.

The first patch makes artsd freeze the computer for about 10-20 seconds a=
nd=20
then aborts with a "cpu overload" message. ogg123 sometimes plays noise w=
hen=20
starting while speeding through the ogg-file, sometimes it plays normally=
=2E=20
Only ogg123 generated output in syslog which I've attached in=20
alsa-ogg123-syslog-p1.txt.gz.


> the second one is to force to increase the index.  you'll see debug
> messages, anyway, if POINTER_DEBUG is defined.

First, removing first patch and applying the second patch. Ogg123 freezes=
 when=20
started with no sound and a lot of errors. Ctrl-C is caught after about 1=
0=20
secs. Syslog output is attached in alsa-ogg123-syslog-p2.txt.gz. Artsd st=
arts=20
but keep looping a short random piece of noise. No sound can be played/he=
ard=20
when played. Killing artsd produces the output attached in=20
alsa-artsd-syslog-p2.txt.gz.

Applying both patches. Ogg123 and artsd behaves like when only the first =
patch=20
was applied. I let ogg123 run a little longer and noticed that sometimes=20
about half a second noise where played. Syslog errors from using ogg123 t=
his=20
time is attached in alsa-ogg123-syslog-p1+p2.txt.gz.

Note: POINTER_DEBUG was defined and the initial patch you sent was applie=
d=20
throughout the test.

- --=20
Regards,
Tais M. Hansen
OSD

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iQIVAwUBPi8464IvLOJqwYc4AQK1Rg//d/KK5N09con1WpRHybusmLzQgCyAJes7
ZacJuyVjC3ZufbvaXWFrDtfP/H5FJp4CnZ0f2wOLj16vrgL5huszWLLUYdUrIGIg
J+HmUlEUydACBO55csHIX9L6LbIPJtlrUHI5JDGTkQ2Tkq3fLnmsgrhjt4FuikDa
mP+sX82Fqduiz5yaOmK9I5f5T8R+hkX/F0TkT/nBUDnZODKPGDwfe2NXvECXLS8i
p0cWyx4GZWZ3CrOghDz1+sqFNg3x3Emf+iX9VcF4a56RLUcDRoTkoLLyOyG2oXHs
HeyPjJValZRZ5K/O9R9XVRFqAqS7haI0lPykIb3QVekTa31D7cU/sWgyrG6/g2RB
Z7EViUL1hVa8hIgOQsSzfMHneu3CDQxaayXsYr6waNiu/jx2+ieRemQDq6nCJuSd
v+30YvOO5hJ4f3f5ix/PtG3Wq6B5mpPhtNWVzW/10V4jkB/3rjBiY4WSuDi4QX/8
WZz4J5tm9sxlwTu/es353FVxstvP9r5I8aB+82ontsEiSljrLrgWeiTiiY6Ucf30
lo3mUDmIz8Puif0d/3zOw9M2fu/szzSsyJimaJ61s/+slS2olUH+jE7FnKOoRmBt
tI4MvSxdW0W+j0U5VrlRP7YbsGN+ebRn3DzQ4Q7pyd6Fkk0+sagHEFsrRuMyifKg
pxf42L/p8YA=3D
=3Ds6sT
-----END PGP SIGNATURE-----

--------------Boundary-00=_TN55X2GLPEEVZ9P49ZIK
Content-Type: application/x-gzip;
  name="alsa-ogg123-syslog-p1.txt.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="alsa-ogg123-syslog-p1.txt.gz"

H4sICA80Lz4AA2Fsc2Etb2dnMTIzLXN5c2xvZy1wMS50eHQA5ZJBCoMwEEX3PcUcwGqMtVqhC7fS
XQ8gMSZlqCQhUZGevhJLt65KF9kM/MfA/AfTMAU0A5JWaVblORirJXLU8BRWiaECyXCd2C9whSIp
IxiYG412ayRLSQiJoJukw5egHp080tIjTwpPvjH1ketJjT7LMzk0ey3q272GOE7Y4Nhxg4nhmMzI
SrosMa/yC11rqpkN2MMHt3yyrRltBJND9fDVYdswGtUo7P7ln/uLwP17Ebh/Gbg/DdufB/7/3V/9
37kOTo8ABwAA

--------------Boundary-00=_TN55X2GLPEEVZ9P49ZIK
Content-Type: application/x-gzip;
  name="alsa-artsd-syslog-p2.txt.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="alsa-artsd-syslog-p2.txt.gz"

H4sICLk1Lz4AA2Fsc2EtYXJ0c2Qtc3lzbG9nLXAyLnR4dADzSsxTMDJWMDC0MjK0MjFTKCjKT8tM
zsxXyE4tykvNsVJIS8wEkpkpFQq2Cgb6hmY6CjmJxSUF+cUgfoWhgYGBjkJSaVpxZlWqEVjIAiyU
nwYWAosAuXA2RENyfmleCUS1iQGXF8INRlYGRnR3Q7IBFwAkJ35CBwEAAA==

--------------Boundary-00=_TN55X2GLPEEVZ9P49ZIK
Content-Type: application/x-gzip;
  name="alsa-ogg123-syslog-p2.txt.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="alsa-ogg123-syslog-p2.txt.gz"

H4sICH41Lz4AA2Fsc2Etb2dnMTIzLXN5c2xvZy1wMi50eHQA1ZNRCoMwDIbfPUUOICytbmuFXcBb
VE1HmbPSVpCdflphDGFPBWEvpfloyMcfWqsBeAHIKiar4gKjs9q0xsKD3EB9BVqZ5TTdDDfAk8ih
Vz6M1q/lzBAxh2bS3ryIR1RGZHVEkSzl5741tHYawvZaYFanKTQiTSFVgKdmoCk5A+R/nsFOoPwS
WOfAk7xXdwJHI6lAHZRcQDAL/t14jPl1v72zPPoTSY7ZGwz15HXIAwAA

--------------Boundary-00=_TN55X2GLPEEVZ9P49ZIK
Content-Type: application/x-gzip;
  name="alsa-ogg123-syslog-p1+p2.txt.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="alsa-ogg123-syslog-p1+p2.txt.gz"

H4sICKU3Lz4AA2Fsc2Etb2dnMTIzLXN5c2xvZy1wMStwMi50eHQAxdRJCoMwFAbgfU/xDlBohjo0
0At4i9QmECpGHEB6+koWBbMwg6ndCO9ffbz/mYq3QCggzEjJcA5dr6WqlYaX6FvRMJBcLV/1nOEO
xaU8Q8OHsdPDMqK5RAid4THJQb0FMdHVRFqayCSFSb4jNmOtp3Y0s+ToVK0U5baC2ArqoyAOhdiv
ILsVK8ONYbJtyGxD7rOJLGgTUQqPTTgUew1Fgk3YBsffcVAb4Yr0bYQaftAGxdsGbBuIjwEHthGh
8GjDoQg0HPFeRinSvpcUMfz/m4hTpL0JD8MBNxGnSHETH50PtMLUCAAA

--------------Boundary-00=_TN55X2GLPEEVZ9P49ZIK--



-------------------------------------------------------
This SF.net email is sponsored by: Scholarships for Techies!
Can't afford IT training? All 2003 ictp students receive scholarships.
Get hands-on training in Microsoft, Cisco, Sun, Linux/UNIX, and more.
www.ictp.com/training/sourceforge.asp
