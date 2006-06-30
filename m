From: Johannes Berg <johannes@sipsolutions.net>
Subject: sound connector detection
Date: Fri, 30 Jun 2006 14:49:46 +0200
Message-ID: <1151671786.13412.6.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1355773022=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
Cc: linux-input <linux-input@atrey.karlin.mff.cuni.cz>, linuxppc-dev list <linuxppc-dev@ozlabs.org>, Richard Purdie <rpurdie@rpsys.net>, Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--===============1355773022==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-40N0pjsu+KkSc2WFXDhS"


--=-40N0pjsu+KkSc2WFXDhS
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

One Apple machines I have with snd-aoa the situation that the alsa
driver can detect changes in in/output connector state ("is headphone
plugged in" etc.) and currently surfaces it through a read-only alsa
mixer element. That isn't really ideal since nothing is prepared to
handle such events, hence I provide an additional control that allows an
in-kernel toggle from speakers to headphone on headphone plug (and vice
versa).

I'd really like to see this handled in userspace (additionally or
possibly event instead), since there are complications especially with
input (line-in) detection and user preferences of what should happen
then. The number of cases can become large, especially when throwing in
digital and combo connectors that aren't handled yet.

Now, is it appropriate to create an input device for the state of these
things and add new constants like SW_LINEIN_INSERTED,
SW_LINEOUT_INSERTED, SW_OPTICALOUT_INSERTED, SW_OPTICALIN_INSERTED and
if so, how do I reflect the fact that on some machines optical and
analog input/output is mutually exclusive, while on others it isn't?
That would probably require another SW_COMBO_IN/OUT set...

Or should I simply stick with (a) read-only mixer control(s), and for
the mutually exclusive case create a tristate (none, optical, analog)
one? But SW_HEADPHONE_INSERT already exists, so we may want to do this
identically on different machines.

Comments appreciated.

johannes

--=-40N0pjsu+KkSc2WFXDhS
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARKUd56Vg1VMiehFYAQJSrhAAoYwqB9k9CMHPuh1uXNbhYxdQCFdTlo48
RwS5UV4lQzag78s0/uB9eJ1gOjWVTMsX1fSoLg6kmkN5WT4jKZUCJ2z2FpqGIodl
kiNdlDUq3A/NLFP2d6BoiI0u4IRrEuVHQlOcSUXi+wNZVMLMitgkAA1BuWE5XxbA
y2WyrUrJnkqO3YZEXRDL70RggduXtJIt5auU9a1ov4mXhf5huHPKi9BP8j/+M25G
rlOuPh6hnD/PBE1jbS9m/v7et0f3HTrSzM71ZAwvTosfxrUKQg7UuZpbxWIR46ef
yyvGb3T8cQKYNUrQ9QJGOy+WGCPBezheYNsPgA2WbFPH0dMQsu/K5HxZ0Jbhzgma
iWykA0WwmMy1xj6D7IjzLgxiBxtVuiLOmi79QS9GjqT5h/ZvrfxCIomlLIleoIgN
rrztcnMTgKDq4fvdbgk38uqjhkBt4PNychogXo7gdSQ1xukwrlYL4deO37+ydfNL
jBIVk7Y/rwZEc7Z9BzUsOn+aB0mNoITsU2vn6CoW6Sbwmm5Cx2zPjVYr0S01vdN3
ho3cw3/RUt3mgSsG2rKFsq2KJOt43ZoZR35CO7aAmZCbYlTce5ZYLD03FAssBoGq
MIXAVaHVD1Z3+6DjYhVrj4S00UodfS7BGvtjSZvec/JfbUOjR8P9IREP6omp28iV
5q/CIqbFcqk=
=apAP
-----END PGP SIGNATURE-----

--=-40N0pjsu+KkSc2WFXDhS--



--===============1355773022==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1355773022==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1355773022==--
