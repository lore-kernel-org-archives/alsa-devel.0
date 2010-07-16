From: Chris <cpollock@embarqmail.com>
Subject: Re: Which project to choose?
Date: Thu, 15 Jul 2010 19:24:11 -0500
Message-ID: <1279239851.12171.1.camel@localhost.localdomain>
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
	<1279234479.2668.3.camel@localhost.localdomain>
	<AANLkTilDzdT6X3N2vIBBe-4Br1OJmoefTTutP542DxtJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5503360588408594502=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailrelay.embarq.synacor.com (mailrelay.embarq.synacor.com
	[208.47.184.3]) by alsa0.perex.cz (Postfix) with ESMTP id 89E8E2414B
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Jul 2010 02:24:32 +0200 (CEST)
In-Reply-To: <AANLkTilDzdT6X3N2vIBBe-4Br1OJmoefTTutP542DxtJ@mail.gmail.com>
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


--===============5503360588408594502==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-muf7+oPnovquscB+0C6F"


--=-muf7+oPnovquscB+0C6F
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2010-07-16 at 07:15 +0800, Raymond Yau wrote:
> 2010/7/16 Chris <cpollock@embarqmail.com>
>=20
> > On Thu, 2010-07-15 at 16:07 +0200, Jaroslav Kysela wrote:
> > > On Thu, 15 Jul 2010, Colin Guthrie wrote:
> > >
> > > > 'Twas brillig, and Chris at 15/07/10 02:38 did gyre and gimble:
> > > >> On Thu, 2010-07-15 at 08:08 +0800, Raymond Yau wrote:
> > > >>
> > > >>>> I posted both of those bug reports. Honestly, I just want it to =
work
> > > >>>> without all the error output to syslog and thrashing of my HD fo=
r
> > > >>>> minutes at a time. As I said, I've got the output of pulseaudio
> > -vvvvv
> > > >>>> if anyone would like to look at it and tell me what I need to do=
 to
> > fix
> > > >>>> the problem.
> > > >>>>
> > > >>>> Chris
> > > >>>>
> > > >>>>
> > > >>>>
> > > >>> Just upload your current pulseaudio.log and output of alsa-info.s=
h to
> > > >>> mandriva 's bugzilla
> > > >>>
> > > >>> Cannot obtain any conclusion based on the log which you have post=
ed
> > last
> > > >>> year ( xmms)
> > > >>>
> > > >>> as Jaroslav Kysela said , need the real system time between I/O
> > operations
> > > >>> and you'll see if it's issue in the ALSA driver or a task schedul=
ing
> > > >>> problem.
> > > >>
> > > >> Here is the bug report with the outputs uploaded.
> > > >>
> > > >> https://qa.mandriva.com/show_bug.cgi?id=3D60169
> > > >
> > > > Well seeing as my process when getting such a bug is to report it h=
ere
> > > > on behalf of the user, I suspect that this has reached a stalemate.=
...
> > >
> > > Please, provide also /var/log/messages output for xrun_debug=3D11 - s=
ee
> > > http://www.alsa-project.org/main/index.php/XRUN_Debug for more detail=
s.
> > We
> > > can detect the ALSA ring buffer issues in this way, too.
> > >
> > >                                               Jaroslav
> > >
> > See pastebin file http://pastebin.com/MdENbSNd
> > Hopefully I did this correctly.
> >
> >
> You have to provide the  PA server log since we just want to know how PA
> server handle the underrun condition  when the PA client use small buffer
> size
>=20
> Did "aplay -Dhw:0,0 --buffer-size=3D128 any.wav" get underrun=20

I'll check, how the heck to I stop xrun_debug from running???

--=20
Chris
KeyID 0xE372A7DA98E6705C


--=-muf7+oPnovquscB+0C6F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkw/ppwACgkQ43Kn2pjmcFyCZACePgzfCgsF81R6JSd6nBHjT+zq
FKsAn2XdsntEPGJapltelfnOJqi3ohZd
=rpaZ
-----END PGP SIGNATURE-----

--=-muf7+oPnovquscB+0C6F--


--===============5503360588408594502==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============5503360588408594502==--
