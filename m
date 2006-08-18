From: Jason Chu <jchu@xentac.net>,
	(by way of Jason Chu <jchu@xentac.net>)
Subject: Tested patch for "No sound with ALC260 chip"
Date: Fri, 18 Aug 2006 07:44:37 -0700
Message-ID: <20060818074437.3c8e0408@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0326500757=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Resent-Message-ID: <20060818075436.6f9f407f@localhost.localdomain>
Resent-To: alsa-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--===============0326500757==
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg=PGP-SHA1; boundary="=_mercury-25851-1155912860-0001-2"

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_mercury-25851-1155912860-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

I just tested Takashi's patch in the No sound with ALC260 chip thread
(and just added myself to the mailing list so I can't reply to it).

It seems to fix the headphone problems I've been having with my Dell
640m.  Previously plugging in my headphones either made them work, made
them work and didn't mute the speakers, or didn't make them work and
did mute the speakers.  In either of the last two cases the state of
headphones/speakers would never change until I unloaded the
snd-hda-intel module.

Last night I applied the polling patch and took almost a minute
unplugging and plugging in my headphones.  Apparently the patch
fixed the headphone problem I was having.

Jason

--=_mercury-25851-1155912860-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFE5dJZN9ETwWhv0TwRAk7NAJ97jXV/VfK6DXrREzcHIB0N+jD+YgCguEvu
N+tvUIhoDWKY/vhra5+fbGw=
=exnm
-----END PGP SIGNATURE-----

--=_mercury-25851-1155912860-0001-2--


--===============0326500757==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0326500757==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0326500757==--
