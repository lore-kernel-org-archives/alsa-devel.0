From: Chris <cpollock@embarqmail.com>
Subject: Re: Which project to choose?
Date: Thu, 15 Jul 2010 17:54:39 -0500
Message-ID: <1279234479.2668.3.camel@localhost.localdomain>
References: <1279062131.24837.22.camel@localhost.localdomain>
	<AANLkTikEf4gf-oeQf4hNGUEvNi0YVrvutnSMCbxGwtJ8@mail.gmail.com>
	<1279065709.24837.29.camel@localhost.localdomain>
	<AANLkTimdM5__SzYFxrQqwsbOrxdit2uWOvkazPvZ4PND@mail.gmail.com>
	<1279071115.29042.0.camel@localhost.localdomain>
	<AANLkTimNSRELBq7i1Ypi9K2tmFu9NKLvQAOOqPwuU13x@mail.gmail.com>
	<1279074303.29042.3.camel@localhost.localdomain>
	<AANLkTimNYxIm9M6Mglrzh3YtJRiq1C8wdZwx-JUhLk9d@mail.gmail.com>
	<1279145758.29042.11.camel@localhost.localdomain>
	<AANLkTinN15BWNC2cn78rc5xCSXNo79SDE2_WkBNEg5I2@mail.gmail.com>
	<1279157921.2668.1.camel@localhost.localdomain>
	<i1n0mf$87c$1@dough.gmane.org>
	<alpine.LNX.2.00.1007151603320.4208@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1142451992163994029=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailrelay.embarq.synacor.com (mailrelay.embarq.synacor.com
	[208.47.184.3]) by alsa0.perex.cz (Postfix) with ESMTP id 0687F103929
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Jul 2010 00:54:42 +0200 (CEST)
In-Reply-To: <alpine.LNX.2.00.1007151603320.4208@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============1142451992163994029==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-KeEQ+07VwDaBTBb5FyuP"


--=-KeEQ+07VwDaBTBb5FyuP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2010-07-15 at 16:07 +0200, Jaroslav Kysela wrote:
> On Thu, 15 Jul 2010, Colin Guthrie wrote:
>=20
> > 'Twas brillig, and Chris at 15/07/10 02:38 did gyre and gimble:
> >> On Thu, 2010-07-15 at 08:08 +0800, Raymond Yau wrote:
> >>
> >>>> I posted both of those bug reports. Honestly, I just want it to work
> >>>> without all the error output to syslog and thrashing of my HD for
> >>>> minutes at a time. As I said, I've got the output of pulseaudio -vvv=
vv
> >>>> if anyone would like to look at it and tell me what I need to do to =
fix
> >>>> the problem.
> >>>>
> >>>> Chris
> >>>>
> >>>>
> >>>>
> >>> Just upload your current pulseaudio.log and output of alsa-info.sh to
> >>> mandriva 's bugzilla
> >>>
> >>> Cannot obtain any conclusion based on the log which you have posted l=
ast
> >>> year ( xmms)
> >>>
> >>> as Jaroslav Kysela said , need the real system time between I/O opera=
tions
> >>> and you'll see if it's issue in the ALSA driver or a task scheduling
> >>> problem.
> >>
> >> Here is the bug report with the outputs uploaded.
> >>
> >> https://qa.mandriva.com/show_bug.cgi?id=3D60169
> >
> > Well seeing as my process when getting such a bug is to report it here
> > on behalf of the user, I suspect that this has reached a stalemate....
>=20
> Please, provide also /var/log/messages output for xrun_debug=3D11 - see=
=20
> http://www.alsa-project.org/main/index.php/XRUN_Debug for more details. W=
e=20
> can detect the ALSA ring buffer issues in this way, too.
>=20
>  						Jaroslav
>=20
See pastebin file http://pastebin.com/MdENbSNd
Hopefully I did this correctly.

--=20
Chris
KeyID 0xE372A7DA98E6705C


--=-KeEQ+07VwDaBTBb5FyuP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkw/ka8ACgkQ43Kn2pjmcFxkhgCePB95iuU+oI5g7AOuIBbhzvz7
V40An2qlg1v/6BYkBmHGvoK7joKarSXY
=vgA5
-----END PGP SIGNATURE-----

--=-KeEQ+07VwDaBTBb5FyuP--


--===============1142451992163994029==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============1142451992163994029==--
