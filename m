From: "Tais M. Hansen" <tais.hansen@osd.dk>
Subject: Re: Re: [Alsa-user] Upgrade problems -addendum
Date: Thu, 23 Jan 2003 13:36:53 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200301231337.13089.tais.hansen@osd.dk>
References: <200301221234.33054.tais.hansen@osd.dk> <200301231215.29675.tais.hansen@osd.dk> <s5hadhsytpt.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_H136MWPGZ7W1GRXDSPVH"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hadhsytpt.wl@alsa2.suse.de>
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


--------------Boundary-00=_H136MWPGZ7W1GRXDSPVH
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thursday 23 January 2003 12:46, Takashi Iwai wrote:
> > I'm assuming the very first via8233a-fix.dif is still supposed to be
> > applied. (won't work without it anyway)
> yes.  the patch had been already applied to cvs.

Ok, I'll just do a cvs update then.


> > Well... Ogg123 freezes the same way as with test1. Artsd no longer fa=
ils
> > with "cpu overload", but it's constantly busy and can't play sound.
> > ...
> hmm, it'd better to start from the beginning.
> please try the attached patch (solely).
> this will generate bunch of debug messages at each interrupt but won't
> improve any behavior.
> so, it would be enough to run only once or twice if you got bad
> playback.
> from the obtained log, we'll be able to know whether the interrupt is
> properly generated, or at which condition, the read of register value
> fails.

Okay, fresh cvs checkout. Enabled POINTER_DEBUG and applied the=20
via-pointer-debug.dif.

Ogg123 freezes/stalls without ever making a sound, like with the previous=
 test=20
and test3 patches. Log output is attached.

Aplay plays a wav-file fine. No problems noticed. Log output is attached.

When artsd is started a short piece of noise is looped, as described earl=
ier.=20
Can't play any sound through arts. Log output attached.

- --=20
Regards,
Tais M. Hansen
OSD

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iQIVAwUBPi/h6IIvLOJqwYc4AQI/CBAAoZjVwgiDiERJiN2klyM/eriOO9fezFs6
ZOE1q3fugqhplVXr+CSiOA4P/KG49FUkGFoZYuuaK0xwJcEtneY6zvHcK+29E2zf
iiLPaUU19zrnN/Bd11pVqeKKa6zixYuNgG3WLVcXs+dhtCYIGIi930Pdk/5AjXq8
ChB5oTzBXfLZs3pm7wte3mELJSZ1sZQ9q3BUzkjEBUot7AkRW4LEx540MCTvQ6+r
d2fYjXswuEeOo/BySuJofCd3Uiv/1tx2jwkDPckjbFZNh0YVZtdp0as1phb/PVOt
05oUj+9nDVFRStqdMaBODSBOiKceewkXR7RwtHa9+OaprjRchGvpyo3x3gJjtfZU
HcJqhPQQnt1/xa9JHht2FanHMuY/GJgBJXiNo6bWMkhVWe3d30wcFJpxTL7vzu8h
hbbEsH5cAEAP5+KG+lPz07ZF2CZezJovevsE33aAk29Xm7bugDd56yWgLloarulE
Ihjk3RLRM3gx6/fdx4JQHt4HTg2cDjKQV2fWkl8XKGhEqDLTIF1D8yGSfVhUbdmh
J+F9Ntyhw2GXbaD9JXqDpSFx1QWURvj1BVtwbLZ8aTn7XGzNZiSGK+8UY02jXQ3+
cb5TzUganC9vYrLUfd3lSDiWZobXXs76epyWAAoyh6F00MeGBP3lbAXEdx3eph5D
M7RC9gOpl8c=3D
=3DHyhA
-----END PGP SIGNATURE-----

--------------Boundary-00=_H136MWPGZ7W1GRXDSPVH
Content-Type: application/x-gzip;
  name="alsa-aplay.txt.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="alsa-aplay.txt.gz"

H4sICMzfLz4AA2Fsc2EtYXBsYXkudHh0AO2czW6bQBSF93mKWbaSE/5sgpGqKtuqu6qrqrIIjFMa
Aghw4vbp65+mSj1AuNw5qFZnFWN58h3m2h+XAdt6jCorK+6s+ke9+xNefIhy4XrC8ULXD925KKti
ncZpIe5llcssFI9pFIo02Yp3wrZcfyayqG7Kot5vb+2ZKNbrOv0pnzf/PHZse7cZF5u8OWyvI3sg
rJRVWiQrmUVlLRPxxfnKTOkTYk4UMlBCHoO8jHl9eIad9Ah01GkJFGKwTF4Sfe8voG/zkRENuZAT
1aM1q0vKOlVSX0m6VAqZaH3rqERJJcbzAcw0f4yyNNmzA3e7XcWbalU21Uxs6jS/OwQQx1eURZo3
sppmxt35gP135jqnXH03OgsF2WvbmAucs9y+GFuKroEIt4NCAtzeD4S4nY5kux1UD4DbUUkBbicT
Nbi9hcl1O2jGIW6nOoztdiqQ5PbBNO1up8Q0bjduN243bj93tw/+4HQBT9/8NLf7Y0vRNRDhdlBI
gNv7gRC305FEtw9HMuuhIetUSQFuJxPJbp9ociAapuqGrWEq0Gj4v9Kwy0cupdGw0bDR8D+k4eux
pegaiNAwKCRAw/1ASDdMR7K7YVA9ABpGJQVomEwka/hWcU0Lk7vSAZpxiNupDqO6PeACAwhNu9sp
MY3bjduN2+EtttFwT4tNBfJa7GBsKboGIlpsUEiAhvuBGjQcKE5sQXLbJNB8a9h94nxrsGWkLC2R
mcnidGnpNeaQImupSEtYnyl3UFSI3KkSY98pgrSmehfgZHLn3AVo5N7T8NKR7B57Qvkze+zppMju
sclEDXeKnE9jYNxOd/tybCm6BiLcDgoJcHs/EOJ2OpLtdlA9AG5HJQW4nUzU4PYWJtftoBmHuJ3q
MLbbqUCS25W18cnczlkbN243bjduN243bqfQPHtkKToHAhbcUSH1u/0VIMLtI5Bct6Pqod/tsKT6
3U4ncq97oiYHoWGybrjXPclA1nVPo+Ez0/D69DJcG5LZJk2pWd51TzpQtWU/0DltS89pvs3Bwhws
dB4snLGl6BqIOFiAQgIOFv1ADbb0TlfURiDj07WxV5D+RPVozRqxDiaopAANk4lsDYMmB6Jhqm64
SydQvxkNn7uGlW9ljkByv5U5pYaZSydGw0bD56Bhd2wpugYiNNzPcgfY1O0v+v4nli6s55/zTeTt
Zsiv+d58/HQjrq6sKKujy+OTVlxU0irjh1WW3l7FoeN6oficy20p42Y3j9+eVr/Pnvfn0hsp3tRN
JaOHfYqZSGTW7Hbr0vOC3R49RFvxPW32r919DB3bXbwNxVNV7E7GD/+h2pSNiOL7vHjKZHIn31/8
AgzVslqRWAAA

--------------Boundary-00=_H136MWPGZ7W1GRXDSPVH
Content-Type: application/x-gzip;
  name="alsa-artsd.txt.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="alsa-artsd.txt.gz"

H4sICF7hLz4AA2Fsc2EtYXJ0c2QudHh0AO3dT4+aQBgG8Luf4j22iSsMoqskm2avTW9NT01jZuHV
TheBDKC0n77g7jb7B0wHhr34JCaK4fX58SQy3MY5SO3E6c7Jf+f1WzD5LBPy5iTmwdwL/AVlOt2q
UKV0zzrhOKCDkgGpqKIbch2xnFIs8yJL8+a4cqeUbre5+sNPh/8+C9etD8O0TIrT8Va6A8OWttKa
H6U957ncMWnOWBYckUeFqr98T+RqaCUrW2ntlfhWKjFCLodWIm2ltVcyt1KJEdIfWkloK23MSoyQ
3tBK2FbamPcSI6Q7tBLh2opr72RhpRMjJfPgUjxbcWP+d8yU4eBSfFtxYy47ZsrBTyfCZOU/Gzdq
KUbKwc8nwmTtPxs35n3WTDn4CUWYrP5n42yUkrFWabThWGZ5Pfxd/HjPy/vfLu0rXZOFBEwwwQQT
TDDBBBNMMMEEc1Tmsi+zaxBMMMEEE0wwwQQTTDDBBBPMC2Ne92V2DYIJJphgggkmmGCCCSaYYIJp
i7nqy+waBBNMMMEEE0wwwQQTTDDBBPPCmOu+zK5BMMEEE0wwwQQTTDDBBBNMMC0xF25PZucgmGCC
CSaYYIIJJphgggkmmBfGFH2ZXYNgggkmmGCCCSaYYIIJJphg2mJ6fZldg2CCCSaYtpl20tavN6hr
y1PJQcYqanJXXlVtwlJvskJPqcxVsjul08MZWaqSgvVk4jztjBnxXflyY0xRv95m3H75ekuzmSPj
XF49fOmEqWYnC/ebWN3NwkB484C+JVxlHDY78/w8bh7zmvSS6UNeaJb75sKmFHFc1DVdCdfzp7SX
Ff1SRXPuDa3E2vsY0FGntf70A7rMCpLhfZIeY452/Okl2H8GPl3t212CvNa9x5632T4oFtePg38B
HM/mNU10AAA=

--------------Boundary-00=_H136MWPGZ7W1GRXDSPVH
Content-Type: application/x-gzip;
  name="alsa-ogg123.txt.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="alsa-ogg123.txt.gz"

H4sICFnfLz4AA2Fsc2Etb2dnMTIzLnR4dADt0k1v00AUheF9fsVdtlJafyRpHUtVVYkNCBaAWCEU
TexJGOp4rLGduvx6nBQQCwyNIxdUvSt7rDk+z1zb2yrnZXbtlfdle4lHr1Qu4USCSRyG8SyUwtmV
SYyVW+1yncWyNSoWkzZyJb4XjSVTZVXYcrds/LHY1ao0X/WP5c/7wPfbZWLrvNqvV8vouK5pdEBZ
5B9XFh1ysudbdnFkmTqkzD+yLPCfQVuhnbHpQmeqKHUqH4NPT8g8fiQHlC3VI+pMvlWZSXe1Udg0
i6R2i6JyY6lLk6/37fKwo7Amr7T7d2MeYM4oUaJEiRIlSpQo/zflpK+yK4gSJUqUKFGiRIkSJUqU
KFGiRIkSJUqUKFGiRIkSJcoBldO+yq4gSpQoUaJEiRIlSpQoUaJEiRIlSpQoUaJEiRIlSpQoB1TO
+iq7gihRokSJEiVKlChRokSJEiVKlChRokSJEiVKlChRohxQedFX2RVEiRIlSpQoUaJEiRIlSpQo
UaJEiRIlSpQoUaJEiRLlgMrLvsquIEqUKFGiRIkSJUqUKFGiRIkSJUqUKFGiRIkSJUqUKAdURn2V
XUGUKFGiRIkSJUqUKFGiRIkSJUqUKFGiRIkSJUqUKFEOqJz3VXYFUaJEiRIlSpQoUaJEiRIlSpQo
UaJEiRIlSpQoUaJEOZRyEvt+L+UfgihRokSJEiVKlChRokSJEiVKlChRokSJEiVKlChRohxQGfRV
dgVRokSJEiVKlChRokSJEiVKlChRokSJEiVKlChRokQ5oDLsq+wKokSJEiVKlChRokSJEiVKlChR
onzKslnyiDqTb1Vm0l1tFDbNIqndoqjcWOrS5Ot9uzzsKKzJK+1GI2+rnJfZtZfqZb2Of+0I49lv
Om5ev7+R83NPZaU6e3joJdZpr0g2i8wsz5M4aHnyIddNoZOq/S6f7xbf+3bttZaTsnJabXYHG0uq
s6qd0lngh9OxbFQjX0y123slU39+cRrLnbOtfv8CVxeVqOQ2t3eZTtf6unso+9NudFmqtRanC612
lmk4l8q0j/8+zUecNAyCy/Y3zNT9skW1UFNpaZXWycmLNzfSXl++eyuVs/Uy09eno2/6bv7p5x0B
AA==

--------------Boundary-00=_H136MWPGZ7W1GRXDSPVH--



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
