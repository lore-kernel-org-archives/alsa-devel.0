From: Mike Frysinger <vapier@gentoo.org>
Subject: Re:
	=?iso-8859-1?q?=5Bpatch/rfc=5D_add_support_for_hosts?=
	=?iso-8859-1?q?_that_have_custom=09symbol_prefixes?=
Date: Fri, 8 Sep 2006 16:18:55 -0400
Message-ID: <200609081619.03907.vapier@gentoo.org>
References: <200609072047.01314.vapier@gentoo.org>
	<s5hhczicvms.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0696743593=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hhczicvms.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--===============0696743593==
Content-Type: multipart/signed; boundary="nextPart5407171.gAJsfJrxh0";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart5407171.gAJsfJrxh0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 08 September 2006 09:53, Takashi Iwai wrote:
> At Thu, 7 Sep 2006 20:47:00 -0400, Mike Frysinger wrote:
> > some architectures, like Blackfin, have a prefix added to all symbols (=
in
> > our case it's historical baggage)
> >
> > while normally packages shouldnt care, when code starts mixing assembler
> > with C (like symbol versioning), you need to dip down into the inner
> > details. find attached a patch which queries gcc for the prefix (all gcc
> > toolchains have a builtin define of __USER_LABEL_PREFIX__) and then
> > automatically has asm() constructs utilize this
> >
> > since most targets define __USER_LABEL_PREFIX__ to nothing, hopefully
> > this shouldnt cause any problems :)
>
> So, the current build doesn't work for such architectures with
> __USER_LABEL_PREFIX__?

correct ... on blackfin, __USER_LABEL_PREFIX__ is defined to _

so when you have a function foo() in C, the actual ELF symbol is _foo ... t=
he=20
asm() tricks to do symbol aliasing then fail as they try to manipulate the=
=20
ELF symbol foo which doesnt exist

> > diff -r 46221e609f45 include/alsa-symbols.h
> > --- a/include/alsa-symbols.h	Wed Sep 06 14:39:01 2006 +0200
> > +++ b/include/alsa-symbols.h	Thu Sep 07 20:45:45 2006 -0400
> > @@ -22,6 +22,14 @@
> >  #ifndef __ALSA_SYMBOLS_H
> >  #define __ALSA_SYMBOLS_H
> >
> > +#ifdef __USER_LABEL_PREFIX__
> > +# define __SYMBOL_PREFIX __USER_LABEL_PREFIX__
> > +#else
> > +# define __SYMBOL_PREFIX
> > +#endif
> > +
> > +#include "local.h"
>
> This inclusion looks superfluous.  This file itself is included from
> local.h.

this is my first time hacking on ALSA code so i'll of course defer to anyon=
e=20
with more experience :)  i added this as a sanity check rather than digging=
=20
through the include paths in the headers

if it isnt needed then simply disregard that hunk :)
=2Dmike

--nextPart5407171.gAJsfJrxh0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iQIVAwUARQHQN0FjO5/oN/WBAQKdABAAtIbc3uuS4QS7JaECYPmgDPgWqqiQhjP3
+YKGBkLXTY9aSwuDC7vIjtpVvMmDV9yKJo4WgGoV/f6GXDBdh9lJb5CTDd1S17fM
fCzew+RViEAQiZ0wY4rfuKNNmLWyGQjj4jE8f0oxBl9PvMdCTKZP02+iB01fwYFN
8Gx3c62D+7AoDjOADgYR6LpSRbQ8KKYjJHVl5iEV7SYHZ/lTJtS0iJtoRR6hV8R8
gBTMf19Rau0h4VtxbAc77COrzdw34aczOcVuPc2WDXPDUNd9H7y3eWfw2f5iKm73
K5YLb5GD6vDPchUtcPT3Lt+2z9iU8ic8+484JhgzRpDrzDEdlNmUG/EfyJrKmyaH
RLwhOK0NFJdF/ie0ILGJsOxFgSrZ5EmQHmLfjcx2eJZNg78DEnIoVy7D/6c1ddew
InSX3J31zvVWaUJKm62/Mlrjv9AXu0oKU+tg18gCmwoDaUaHsI5gjVv1pZKuW1hv
29Z9Zxs+pJNjwhBcW1stqKU9sGSzkfQggNmrhC5ILnMnFOGHFVBh1pYEtmFYwLDE
nWXvtHQjOOoHT+7ym46olzqn1zTwi1XcUb4m3wnv00bCsKlvlkDDvWtxPqY2rWmS
cMIpIUSz+2cmt4JXaEyEmk9hLwMofQWDsJM/yH8phcBD/L69DVg3gqukVnKmYI9e
ND253nPKY3c=
=+OoW
-----END PGP SIGNATURE-----

--nextPart5407171.gAJsfJrxh0--


--===============0696743593==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0696743593==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0696743593==--
