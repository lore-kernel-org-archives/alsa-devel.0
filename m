From: "Tais M. Hansen" <tais.hansen@osd.dk>
Subject: Re: Re: [Alsa-user] Upgrade problems -addendum
Date: Mon, 27 Jan 2003 15:42:43 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200301271542.48663.tais.hansen@osd.dk>
References: <200301221234.33054.tais.hansen@osd.dk> <200301242224.47436.tais.hansen@osd.dk> <s5hn0lmoouu.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_7JNDBN7IYG9KO9W698MQ"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hn0lmoouu.wl@alsa2.suse.de>
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


--------------Boundary-00=_7JNDBN7IYG9KO9W698MQ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Monday 27 January 2003 11:42, Takashi Iwai wrote:
> > I just gave it another try with aplay. Bad idea; froze the system.
> > Something's really wrong with the test8-patch.
> ok.  now, i rewrote the patch completely again.
> the module options was removed again.
> here we go...

Ok. Hope you had a great weekend. :)

- - Fresh cvs update. Recompiled & installed alsa-lib and alsa-util.
- - POINTER_DEBUG enabled.

No sound from aplay but it had a lot of complaints for me. Two files atta=
ched.

- --=20
Regards,
Tais M. Hansen
OSD

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iQIVAwUBPjVFZoIvLOJqwYc4AQKPzQ/8DJDYSkSdi70eIaQ/4seWEiN3eC6gOhuZ
5gXmWoLFDvOTaYf4EI/TlXrrWUYqIjDYn3m6PtS4Enn0zXe5FBztguQu8vOMYGcS
OSLaC1Po6gjOgI/klEgawn/G0W4ffn8YVXSYxNJGuYXYmZa2QOcYfbN/MpqH/bnj
NPBc8DFyKDnMTspsz0Fr+bL8mfrJnFQzSagV5mKIGDZVExFzqzQWyU2tWpOdoOft
i6OB4CnuGZWhQOmnK8fAyijfWn8m+g7UJ7UfcjhagcQnvf7xoUov5kjzZ5Js4ZaY
5jKEow9UF2vij7GfpLidHIi+LyvTybOr1YzXEFCMpb/2qt93xavCdBh1P76xRSTo
By7oN6u5wV3rYBP+V3twxKff3g5Q5EVoJhCj4RKjqFIOzQdGsqlF2JZ5P+ODI37I
AxL4BBKzIklKKQh0W+PBQoxlJWv+OYVFUUclDjSDYRo672IwvdrIUO4TBllawWhK
5A4LYWHeoIebzA3PFKUhdlRLa/3kpGZPWeOEbsDuJnB/9FTMiCxo6AUd/9MJ3PUC
GUV8z40FkIei589mB866PKdhWx567/dJaRgcezKWtY5JWNjDJpDjP34Y/sGwodku
Y1YKgqKRScrls+G/jzhzT4XXNkYE81BVF8/o6ClwQUXNUfuM0T6DcCKeHRjWYAHP
yqqN7mvVJj0=3D
=3DD2I5
-----END PGP SIGNATURE-----

--------------Boundary-00=_7JNDBN7IYG9KO9W698MQ
Content-Type: application/x-gzip;
  name="alsa-aplay-log-test9.txt.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="alsa-aplay-log-test9.txt.gz"

H4sICEJFNT4AA2Fsc2EtYXBsYXktbG9nLXRlc3Q5LnR4dADt3c1um0AUBeC9n+I+gGMD5sdB6iLZ
VKq6q7qOBhiiUbFBDIncPn1JIleqSjqJw8AFzpZY+My5M59NpCiZTB7u49XqiziSF5EbxLsgdgOq
6jJXqSrph6yPsojp5uu3G9pstqLQ4url4rZK1fZRib13Om3SOPD9mCpZqzIjWYhKy6yP24Z+GFMt
0/JR1pTX5YHUsaljUtmJPpEXbr1wTYXQTVXq9oJzctbPr7h7eUEwp6X5vtz/tTrXGSXH/jpzLOTg
UvO/y+tlF707RyqTvYUclmrmMj0L5//jB3VOMbgMGhpCwyFqDhndtmcNh8lgZGjKMbgM2qzhMDnM
Gk66ZrOGw+Qwa8ipZi7Tg4bQEBpCQ2gIDaEhAy6gITRkMj1oCA2hITSEhtAQGjLgAhpCQybTg4bQ
EBpCQ2g4GQ0jOw1fdFsLDA2Tw8zQpHNwGbeZw2FymDnkVDOX6f2fw5HAmFMMLoOeucpcaoaGjG4L
DbnF4DJoaDhlDaHQRI8/kxhcBg2FpqwQvpNBwznE4DJoaAgN2dbMZXrQEBpCQ2gIDaEhNGTABTSE
hkymBw2hITSEhtAQGkJDBlxAQ2jIZHrQEBpCQ2gIDaEhNGTABTSEhkymBw2hITSEhh+oeaV/6qK8
+J9xpGUt23c53BUqad/BjdqV3n7/HJNuaikOT6tZ03lZUZILIZM1JQ953lah1S/5/IMg9Lz1Odmf
q667E6+neuqLDlJrcS/bcispGpmRR41qL/azGNcZajE8K0ZXhlShaTu6bud+fOMfqw/c8YWpxu64
+8ij4oWmWvoEuw/JDofEdsU+KrZdcYiKx9nFb3zcGLjiC1NZrjgyfilEx9Y77v5SiIr73MYOOuaY
ikEEnsWMlWrpW/s9TySoeKGplj7BVz5jA5wS6x13P1Wi4z477v49ODrGIw/PiqefaukT7D4k58/T
3+dSy6iCggAA

--------------Boundary-00=_7JNDBN7IYG9KO9W698MQ
Content-Type: application/x-gzip;
  name="alsa-aplay-stdout-test9.txt.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="alsa-aplay-stdout-test9.txt.gz"

H4sICLxENT4AA2Fsc2EtYXBsYXktc3Rkb3V0LXRlc3Q5LnR4dAC1mLtqA0EMRXt/hVw5ATOMdvYx
m86FIUWKEENSr/FgFjZrsCfPr0/SpQh7DIp7Mbq6unrN/dB99ONenlaPa1nkdMrurXtdyI1s+v2Y
dqK1bPssd33OQ5L1uOu7cSkPXU5Sluq93H4uZZPTMR1m78eXcT6fy1WXZUjdKYt3vinl+STDYdxf
/21QttMGGqopg9Kpb8gFYYhkoIEMPGEorCBLBaI0mjGAizMM0MVkNs8JsyEMamXSN5NRqIseMWCY
CJKy+V2aRtFWJNqKKquA4vWKRBEGrE1UlIImo7e+4D3xgCADvVBjNkkP043UuwbD5GyaG0igKFAP
rEliknuU2SCYVU2C+RnO4AJ5wGxSsrCJRUoWidYHiEJZ1fRCQW0wThIVnbaUC2zmFY4DTLe5Nhvs
URRFbZ44LDkUDDYxHKzIpH0bNL9QU7IqIopqk1UdSLSoB7oOOAocByi5mqJgF+ZtENcD3Ir/Yaih
aLF4L7/sMUj79CeQLWEoULT2e5NeCOZkcRvEyYtR2Bct3MzthYOKuvBRrC7U1iWHDVqkGv8fzIc5
M4kGeCWhYMhFJB4CVhYZYLqRSZxZeNJi+XOYKBhkEgsHDxCSffzVJ1fbwzGnnXNu9gUEP1ChOhUA
AA==

--------------Boundary-00=_7JNDBN7IYG9KO9W698MQ--



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
