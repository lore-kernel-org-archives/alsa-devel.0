From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: [alsa-cvslog] alsa-lib: Add struct timeval and
	timespec definition when _POSIX_C_SOURCE is not defined
Date: Sun, 24 Jun 2007 17:35:25 +0400
Message-ID: <20070624133525.GA24739@procyon.home>
References: <ALOGGER1160125304.48@alsa-project.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6590851569139813341=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from master.altlinux.org (master.altlinux.org [62.118.250.235])
	by alsa0.perex.cz (Postfix) with ESMTP id 1B41A24358
	for <alsa-devel@alsa-project.org>;
	Sun, 24 Jun 2007 15:36:00 +0200 (CEST)
In-Reply-To: <ALOGGER1160125304.48@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============6590851569139813341==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 06, 2006 at 11:01:44AM +0200, Jaroslav Kysela wrote:
> changeset:   2218:603411fd0c77712cab43cdd5afcf0ff4ebe51a7f
> tag:         tip
> user:        perex
> date:        Fri Oct 06 11:01:40 2006 +0200
> files:       include/global.h
> description:
> Add struct timeval and timespec definition when _POSIX_C_SOURCE is not de=
fined
>=20
> FIXME: It might cause problems on some platforms when tv_usec is not long=
 type.

And now it also breaks compilation of the following code (at least
with glibc 2.5):

#include <sys/select.h>
#include <alsa/global.h>

$ gcc -c --std=3Dc99 x.c
In file included from x.c:2:
/usr/include/alsa/global.h:134: error: redefinition of 'struct timeval'
/usr/include/alsa/global.h:139: error: redefinition of 'struct timespec'

(Without #include <sys/select.h> only 'struct timespec' is redefined.)

IMHO attempts to define structures which should be defined by system
headers are too dangerous - if someone is using preprocessor flags
which hide required parts of system headers, it is their problem, and
the risk of mismatch is too high.

BTW, <time.h> does not provide 'struct timeval' at all, even with
_GNU_SOURCE - it defines only 'struct timespec'; however, this does
not cause problems, because ALSA headers currently use only pointers
to snd_timestamp_t, which works even without a complete definition of
'struct timeval'.  We can try to include <sys/time.h> to get 'struct
timeval', or even <sys/select.h> (which currently seems to provide
both 'struct timeval' and 'struct timespec' even with -ansi, and
http://www.opengroup.org/onlinepubs/009695399/basedefs/sys/select.h.html
tells that it should always provide their definitions).


>=20
>=20
> diff -r 7bc021fb4bf1027b23aa5429ceda1e1e35c7d126 -r 603411fd0c77712cab43c=
dd5afcf0ff4ebe51a7f include/global.h
> --- a/include/global.h	Fri Oct 06 10:38:39 2006 +0200
> +++ b/include/global.h	Fri Oct 06 11:01:40 2006 +0200
> @@ -130,6 +130,18 @@ int snd_shm_area_destroy(struct snd_shm_
> =20
>  int snd_user_file(const char *file, char **result);
> =20
> +#ifndef _POSIC_C_SOURCE
> +struct timeval {
> +	time_t		tv_sec;		/* seconds */
> +	long		tv_usec;	/* microseconds */
> +};
> +
> +struct timespec {
> +	time_t		tv_sec;		/* seconds */
> +	long		tv_nsec;	/* nanoseconds */
> +};
> +#endif
> +
>  /** Timestamp */
>  typedef struct timeval snd_timestamp_t;
>  /** Hi-res timestamp */

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGfnMdW82GfkQfsqIRAuUtAJ4omMr3AyFHiZMVkbd56jftrziDFACggi49
wj0dE2A4vgNDSZwVuA7GPp0=
=auc1
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--

--===============6590851569139813341==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============6590851569139813341==--
