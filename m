From: "Tais M. Hansen" <tais.hansen@osd.dk>
Subject: Re: Re: [Alsa-user] Upgrade problems -addendum
Date: Fri, 24 Jan 2003 15:12:13 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200301241512.17848.tais.hansen@osd.dk>
References: <200301221234.33054.tais.hansen@osd.dk> <200301241341.09518.tais.hansen@osd.dk> <s5hd6mmptdh.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_D428PUCZD8QNS454PZ2U"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hd6mmptdh.wl@alsa2.suse.de>
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


--------------Boundary-00=_D428PUCZD8QNS454PZ2U
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Friday 24 January 2003 14:30, Takashi Iwai wrote:
> > Same deal as before, another 3 files filled with debug output. Good l=
uck.
> > :)
> it seems that we need to use CURRPTR always on your chip.
> i guess this depends on the board, how reliable IDX register is.

Need any specific info about the board? Chip? I saw some talks about the=20
ALC650 chip in another thread on this list and alsamixer claims I've got =
such=20
a chip.


> if the attached new patch works, i'll add a module option to enable
> this behavior.
> good luck for you, too :)

Thanks. Maybe we should exchange good luck more often. Seems like you wor=
ked=20
some magic here. :)

Ogg123 now plays but there's a lot of pops, clicks and stuttering. Log ou=
tput=20
were produced in both syslog and debug. Attached as allways.

Aplay played as always. I think I heard pops here and there but it wasn't=
=20
much. Log output from debug attached.

Artsd started as supposed to with a single pop. Noatun seemed to play wit=
hout=20
any noticeable weirdness. No pops etc. Log output from debug attached.


- --=20
Regards,
Tais M. Hansen
OSD

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iQIVAwUBPjFJwIIvLOJqwYc4AQJUkRAAjIJ66U1Fb2HDWHQcqRh0BnAIJKZaIki3
ky+IkXkJ32YqznaiO88Cv6GlRJjJAfES8IyRrUZB8WT0LA79mKGSQyoS5xoMK6MW
KsqPPHf/h1o3QCKa/rY8OH0oPUzD5PvfGqU1Iyk3uUTjtaQYm+4B/V7wpQjfnRbb
5sumdqo8oWchgzoKqeY17bdPE7lAMxYoWeRglIPMI6N1I/iyJNAONnfHNMFVH1FE
uZQ3EKipd7qMw8RZHA2+C29xTU3rK4aMqRMqsBHHNBXMzNsNIRuGenSYQAynHeCY
U0UzPBirqZKCOWEJuBWjhEWhAk1CCnBb1vsM1MVEJ0e47RfIF9HL3kHK4Eiwk301
fHOIGR+x9iAO/21en8oVzEj6sNdWGMMPXV1U+byJbe/C6I7nRBQCBMZDdbw2/haU
uvhzMoBihW7EwLoWlMFCXbseX3vcHf8lmSLyh39M+aK2FcMnYiFGE7gp0L84NS2Q
mnh6b9CFDPlffGET9+DULqZqv/clYsqHLOtT7ECjLyb3zcm6rGw+pU3wKNPcRtpW
GL0saHyIy1fhU6Z+LDSPYlcBDl0+AtjeGhNTG44UmrfW92SM1jJb0f52rRe0zelq
hih9SE6meCIHYjBk9/LcCYYAdBW9sybBPqjr+ywskbNrLH87TrfYftpUWXAq1sar
einpLW5cIcw=3D
=3DK4LD
-----END PGP SIGNATURE-----

--------------Boundary-00=_D428PUCZD8QNS454PZ2U
Content-Type: application/x-gzip;
  name="alsa-aplay-test7.txt.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="alsa-aplay-test7.txt.gz"

H4sICMZGMT4AA2Fsc2EtYXBsYXktdGVzdDcudHh0AIXMQQ7CIBBA0b2nmAsIQqA2s+u2cecJJjCa
idgSIKbHl6SLunP7k/9mWsA6MA79gN5DLutDgqzw4rJwQphu9wmU0pQqnfeocxD9ERrttqmA3nqE
zEXWCJwoV46n+WCvXT7YRLXBm2ulJ0PhzNQ4wmAu0KTn33FEZ/6Nrtv7+AWXMd/CyQAAAA==

--------------Boundary-00=_D428PUCZD8QNS454PZ2U
Content-Type: application/x-gzip;
  name="alsa-artsd-test7.txt.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="alsa-artsd-test7.txt.gz"

H4sICNlHMT4AA2Fsc2EtYXJ0c2QtdGVzdDcudHh0AO3d327iRhTH8fs+xTxAmvgP2AapF3u76l0f
YOUFs7JKAQFZRX36UlJVm5xpjrFPjT3+3i1WzI4+B2XOD09mPpc7l8xcPF9G0TJO3OG439Sreu+2
5ens/qhOp/Jb5Y7VoSrP1drFs5k715fLP33+rxt/r467art0n3797ZN7fHwqt6fy59eLT4dV/fS9
Lovk5eVxtZwvsqXblPXlh+v1i/vFRU9x9nD9nw/709+vX+Ioih7c1+fNqf6zSq6Xiuul/eZ66Xrl
8vLff7/esNo/787X15sqshhqdrnT1bvv5bZeu38uf1k9H78czscH93yqd99exV5/4rCvd+fqCBJI
IIEEUgukFUgggQTSgJBKkCaAlMyX7lAd6/3aVdvycKrWb982idSYlEe+mPTjjR2Klomi5U2Kll2v
NO9K2o3Wom444TQdp/czL044dXF6P//ihBNOOA3FqcBpGk5qjlIfN6Xep02JTfaNE1G3dZO6rW7t
e++Wf4ECCiigGmQpoIACCqgBQYk8BVSgUN2DQk5OCPfzDRRQzMFAAQXUdKBG39UBBVTPOSFVF2b5
12WlJnWTZUublC25tatrNVqTsuGE02ScRKeCE0444TQQJ9HO4YTTlJ0M4sGceBDqxxsnnGhTcMIJ
pyk4lQVOk2h7cTKKB3P1zxEKbzyYm5Stj41m2g3VpGYggQQSSLJ/AwkkkEAa0JZFIIWIpAaATH0+
sPAGgMykZoWo2aJJzYpbv89tNVqTsuGE02ScxMSLE0444TQQJ9HO4YTTlJ3UeJBr8SDxLx/KTcrW
2x+NthquSd2AAgoooPSeDiiggAJqQFCi/wUqUCg1KCzUhUSZNygsTOrW13b+rUZrUjaccJqMk5iA
ccIJJ5xwGpWTaHtxCtNJiwdprMWDWeqLBz/e1yXWzUTdNk3qVt3Yz7UbrkXdgAIKKKD0XgUooIAC
akhQ7/tfoEKFUoOCeuxBkniDwrC3oRXdyt22oQUKqElBiUkYKKCAAgqo8UGJ/heoQKG6BwXvOcpG
ZetpfcjoqoYTTiN0Cm7+xQknnHCamNPou16cjNJBy1PRUpvtaHv70vdu+9ECBRRQQDXoVYACCiig
BgQl+l+gAoVSg8JMDQr+5wgzm7rJTWu/NqlbeWu30mq4JnUDCiiggNK7FaCAAgqoAUGJ/heoQKHU
oKCelOY/KCG1Odyip4Nv243WpGw44TQZJzEB44QTTjgNxOn9Qco4NWx7cQrTqXs88J6TYFS13jZZ
GVvZgAIKqKChgmvpgAIKqKCgRt/+AmWVE/Tzlv1BweYcvN66lbsdhAcUUJOCEpMwUEABBRRQQAUL
JYICUIFCdU9U/2ug6msV+djKBhRQQAUNFV6zAhRQQIUENfr2FyirnJBrOSHxbwllc7K4jHfzJmWb
3dqs3O1gcZxwmo6TmIBxwgknnHDCKUAnEQ9wCtNJjVGFuoAt98aowqRshSjboknZilvb3lajNSkb
TgE4iWkFJ5xwwgknnAJ0Em0vTmE6fRwP4mW00OJBlqUyHyTLOFJzRRq3vLPQbhvg87i3nXbb4Xb/
pAAFFFBAAWW2XAcooGyX6wAFFFBAWWS4y9vGahTLvIkqtqlbLye4tR2uSd2AAmpKUKKtAwoooIAC
anxQov8FKlAoNSiohyfmnsMT397XoW69nGHRdrQmZcMJJ5xw+rhRwQknnHDCycZJbXvVsz4Sz5ZT
b+/rULZMlC1vUrbs1un3Tlsv44TTlJzEr0uccMIJJ5xwCtBJfCuOU5hOaoxSN+71rzKy2Uetl/2T
2o7WpGo44YQTTh93KTjhhBNOA3ESXS9OYTqp6UDfrjfxxgOb7cH6WuNwp+3BcMIJJ5zUNgUnnHDC
ybKd6/a2fwEVuTeEvksBAA==

--------------Boundary-00=_D428PUCZD8QNS454PZ2U
Content-Type: application/x-gzip;
  name="alsa-ogg123-test7.txt.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="alsa-ogg123-test7.txt.gz"

H4sICBpGMT4AA2Fsc2Etb2dnMTIzLXRlc3Q3LnR4dADtm09vm0AQxe/5FHtsJSdmgQWDVFXppVLV
W5WzRWDt0mBAgBO3n77YTtPgTDowHvCf9MiKxY/3g2Xe7jrSt8u5f3HxJUiFaQtp+8ryLU/kRTaL
wzgTd7pIdeKL66/frsXV1ThIyuBy2zjOw3h8HwcTc7W6Cn1lKl/kuoizSOgkyEsdNS9rG38vmwRl
JRa6LIO5FoXOdVDpSEhPVHHd+nq/DnI8xxezIK5PjqOV+CDs8WS0+d08K+tDY6UMwxiJ2+WsjH9p
c9Nkb5qy2abpWcvTodwchtkyrTbHM21wiHUMo5aZ3gdJHInH5mm4LKZ5VYzEsozT+day7Rl5FqeV
Llhs2p9an9CcXWhuG2jOm4cmMWjWBKQmWaipXWpOG2qqKzWSWBZqNJtQaiZGzVQgNZOFmrtLbdKG
mtuVGkksCzWaTftTc3uEZuxCk22gvXFiFkbMMUFk1im9ZySxLNRoNqHUbIyaskFq9ilRI4lloUaz
CaWm0G+aA1JT7eSEWaFrTYtpEt/WeuTE9cVNqle5DtcX//4wfbzb9b0vtXhXVoUOFmv3RyLSSRX4
4lIa0hmJRbASP+JqfW6dFgzPee+LhyKrvdtcoFjmlQjCuzR7SHQ01x9pgrv656BPPeyfc0qhiSSW
5amn2YRS8zBq0oRjEy16Hyg2kcSyYOtnhkKhWbeu/AFqiifsDlDL0ZRyICN6hCJDky44PCqeoDtM
UUATywKtn6CLQ7Pg94yH2hDv2dkhQ6tvKQ2Q2SmV3zSxLNj6Kb8VWj664ESg4ikfB6J2sPKRaFMX
anu4L3fdN9u4L/+7j0ZWeKTjoTZM7X5+1PDIZcGlIE/kGmioO1jkItr0b2y2b6Cz5x4QlJv9jnx+
gyp2f2pkm/anBg2RbNSG+LCdIzW0hveA2NXsd+SrwlSxLNT6KOHry7p48gKWq5odj7weoYplwUaz
CcWG1iMeTK3ld/ZIFj7aC+7on0QXaaUN7IZodjz60YomluOxJ9qEYkPX+zywMpC05bPBp/aoSlmQ
9bHE2AYZkJvYiA2Rm84RGr4uDEzsNfudxOelreCu/qFVlQls22r2O/6n/mBFFdGm/alBW8jZqA0z
W3B+1CYYNXiompxSIUcSywKNZtP+0KweoQ0zw3N+0NDQacHjI88c+EDUDjQHTrYJo2ai244USM3k
2XY0zABJE8tBjWgTSg3fxAKOkObpbD2iimWh1sc+ljbU/szKXZQ/yyR78efItv9J2A1Qbs3v081n
XzwPSi/GyVkdkp7obFsf7+Z5Odk1v4NJpr0TvwErheZrJToAAA==

--------------Boundary-00=_D428PUCZD8QNS454PZ2U--



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
