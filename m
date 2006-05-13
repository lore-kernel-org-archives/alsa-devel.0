From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Multiple reports of hard lockups with alsa MPU in
Date: Sat, 13 May 2006 23:45:31 +0200
Message-ID: <1147556731.25313.10.camel@johannes.berg>
References: <1147554990.6535.317.camel@mindpipe>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-2YisexIeahn3nfxRjT46"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1147554990.6535.317.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--=-2YisexIeahn3nfxRjT46
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2006-05-13 at 17:16 -0400, Lee Revell wrote:

> Two independent reports in a month - there definitely seems to be
> something weird going on.  What can these users do to debug it?

=46rom experience with softmac lockups I'd say enable serial console
logging or at least switch to a real vc before doing whatever locks up
the machine.

This usually means some weird hardware problem or a kernel fault in an
interrupt handler or something similar.

johannes

--=-2YisexIeahn3nfxRjT46
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARGZTeaVg1VMiehFYAQLDng//T/fdNvajgzVW6TqLo02yL6/mEIhIu7GK
3Mp5Epe6lj5oDHKdC/THmwRhXPxCkmOt+Nfwu8WCc6WFflzTsXbsmYEMjzo66r3M
VF9iigFJkQz/GE9NgrjsY14upzLcJsEmsaT2kXMePIR4wvXmItXi8UFxIad3stv2
JQtBKQS+8DN55HtrGrBH6bzCMn/XB20l39yaMhOts136iB0/VX39eDT7pskJHDim
9BWrhu49++SI5PX1bWwmvL6E3xxM89Lj7IVol6UwL0R7hIlBNfLZc/h4vdhxu577
DiBrSN23eH35O0z9RoW9mHhid5Own1m0Pqr3HPF5A9pduIVEBxannQ6Qg5EYdE7e
Lp0MKPpH2hZtg4RtdmdNhAtGpgmlcM7rYLr3GuR6TBl2I+dcnlHS07OLNhMV2Uy/
2IN4JF78axbj5D7tQqPkhLG8iHlNwKTEYSwn+APLCO020MmnL4mfrQPG2R9PFC05
t+YK+vk956iHSAPxKrHPVwSI6rlURpJx9W4LMIhjrcRyPqcevhCpw6QbEpWXNxvt
yq/yMhl2GoqkO6SXNLlHq5HaBb+1EDgLJzjhjFGuO2db/yJ5Blrgb7PQHUZ4LD2A
7EsLM2BopK1hEqyT3kc9PRYqfxXP8ABz6aBEEORxwMMa1arzvb7OAVAkXMFwQhr3
oE5cv8+7Rsw=
=bQVj
-----END PGP SIGNATURE-----

--=-2YisexIeahn3nfxRjT46--



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
