From: Johannes Berg <johannes@sipsolutions.net>
Subject: exporting static inline functions...
Date: Fri, 19 May 2006 21:40:23 +0200
Message-ID: <1148067623.6228.40.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-qHCWXEYUR11LlT8lOtqv"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-qHCWXEYUR11LlT8lOtqv
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

alsa currently seems to EXPORT_SYMBOL() at least
snd_pcm_lib_period_bytes which doesn't make sense at all since it's
declared static inline in the header files.

Maybe someone should go through and check these? I'd have to check the
hg source so I didn't yet.

johannes

--=-qHCWXEYUR11LlT8lOtqv
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARG4fJKVg1VMiehFYAQKfNBAAvxnLHXSgScYuugiNb/cGDegrZ/sS2kjR
TmGSG8dhzjCCY97P20TWFYJRe6EKhE4vBqQalZ4gcTb7PoitDnKUlUuYLQFtONVf
GpW/Cuc12dgblvxjWeU1X/ptVJQl+Oxpfqjk+nkCtgdPFjBXEiMKSDtT7Z8pnwTD
tEUvh7EmGLQC/RhAnmjWUE3FebdEioqKWOi4xxNAWXPzHHTZ5jDecjuGEwtzG5Py
afz30JeWVtwUCfaPVzX7MsBZVQImPjMwZLpHToOV6+sgF1U2WXft9Fguy7MRUFc5
Y0k937G6V8q+kySe8LCxt2doDS3ZlOEuAU2YBZ6212/lijHXpt//XoZVp70GZXRM
m3HfBNE094RuGEbhOJ00YgdyS9pHpiM+Qq7PmABC2hVhFuC2NmpD+yoCyAPm3wgt
NGt+oh3TCsHeeYfrisaPMXVsXr73v8GR2vPPOfSvb3+lnctaiX93JLrzuKt9hcdy
XVegamSjxT1iAUgUCwgMHNRSShQD4g8PhgpjQopn9sCyDQ1uKOTLLZiHhbNAGE6x
yD5/f6QJgQjin2RLelGz58uRWFXUMkpM6ZZSJD6UceE2nHZxbWB8eC873imxUdEq
MVDovnAwiDIfPf/fF+FMlhiICOAJhhMBhF/Gokip7JwbXl7rn5kdFJxHZeYmB9e9
b6odUfPAQFY=
=h4Dg
-----END PGP SIGNATURE-----

--=-qHCWXEYUR11LlT8lOtqv--



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
