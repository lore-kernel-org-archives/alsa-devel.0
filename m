From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: [alsa-cvslog] alsa-lib: Add struct timeval
	and	timespec definition when _POSIX_C_SOURCE is not defined
Date: Mon, 25 Jun 2007 19:24:56 +0400
Message-ID: <20070625152456.GC24551@newmaster.mivlgu.local>
References: <ALOGGER1160125304.48@alsa-project.org>
	<20070624133525.GA24739@procyon.home>
	<s5hsl8ggop0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3058300136679538998=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from newmaster.mivlgu.local (mivlgu.ru [81.18.140.87])
	by alsa0.perex.cz (Postfix) with ESMTP id AA07A2434B
	for <alsa-devel@alsa-project.org>;
	Mon, 25 Jun 2007 17:24:57 +0200 (CEST)
In-Reply-To: <s5hsl8ggop0.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org


--===============3058300136679538998==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XWOWbaMNXpFDWE00"
Content-Disposition: inline


--XWOWbaMNXpFDWE00
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 25, 2007 at 03:15:39PM +0200, Takashi Iwai wrote:
[...]
> > #include <sys/select.h>
> > #include <alsa/global.h>
> >=20
> > $ gcc -c --std=3Dc99 x.c
> > In file included from x.c:2:
> > /usr/include/alsa/global.h:134: error: redefinition of 'struct timeval'
> > /usr/include/alsa/global.h:139: error: redefinition of 'struct timespec'
> >=20
> > (Without #include <sys/select.h> only 'struct timespec' is redefined.)
> >=20
> > IMHO attempts to define structures which should be defined by system
> > headers are too dangerous - if someone is using preprocessor flags
> > which hide required parts of system headers, it is their problem, and
> > the risk of mismatch is too high.
>=20
> I agree.
>=20
> Jaroslav, which system has no definition of these types?  Maybe it'd
> be better to check it in configure script, rather than the simple
> ifdef.

This won't help here - the above problem happens when alsa-lib headers
are used by other programs, not when alsa-lib is built itself.

> > BTW, <time.h> does not provide 'struct timeval' at all, even with
> > _GNU_SOURCE - it defines only 'struct timespec'; however, this does
> > not cause problems, because ALSA headers currently use only pointers
> > to snd_timestamp_t, which works even without a complete definition of
> > 'struct timeval'.  We can try to include <sys/time.h> to get 'struct
> > timeval', or even <sys/select.h> (which currently seems to provide
> > both 'struct timeval' and 'struct timespec' even with -ansi, and
> > http://www.opengroup.org/onlinepubs/009695399/basedefs/sys/select.h.html
> > tells that it should always provide their definitions).
>=20
> A patch is welcome :)

Just not sure which one...

The situation on my system (with glibc-2.5) is as follows:

 - <time.h> defines 'struct timespec', unless -ansi (or -std=3Dc99)
   option is used; it never defines 'struct timeval', even with
   -D_GNU_SOURCE (which should enable everything).  This means that if
   only <time.h> is used, alsa/timer.h will not compile with -ansi due
   to the 'snd_htimestamp_t tstamp' member in snd_timer_tread_t,
   unless the program includes some other header which defines 'struct
   timespec' before alsa/timer.h.

 - <sys/time.h> defines both 'struct timeval' and 'struct timespec',
   even with -ansi; however, according to the current Open Group spec
   (http://www.opengroup.org/onlinepubs/009695399/basedefs/sys/time.h.html),
   <sys/time.h> must provide only 'struct timeval' and is not required
   to provide 'struct timespec', so the behavior may change in a
   future glibc release - again, a missing 'struct timespec'
   definition is fatal for alsa/timer.h.

 - <sys/select.h> defines both 'struct timeval' and 'struct timespec'
   even with -ansi.  In the Open Group spec <sys/select.h> is
   specified to define 'struct timeval', and also define 'struct
   timespec' "as described in <time.h>" (where it is described as
   optional), so it should be not worse than <time.h>.

Would it be OK to include <sys/select.h> instead of <time.h> and
remove attempt to define system structs from alsa/global.h?  Another
option is to include both <time.h> and <sys/time.h>.

--XWOWbaMNXpFDWE00
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGf95IW82GfkQfsqIRAtyqAJ0bcuarAaW3MUxjlfhFk1L0rIOOyACdFDe5
Bp8mZtGR5Q2ONCCxMoLtPCA=
=euve
-----END PGP SIGNATURE-----

--XWOWbaMNXpFDWE00--

--===============3058300136679538998==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============3058300136679538998==--
