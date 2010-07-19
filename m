From: Chris <cpollock@embarqmail.com>
Subject: Re: Which project to choose?
Date: Sun, 18 Jul 2010 21:56:04 -0500
Message-ID: <1279508164.22741.27.camel@localhost.localdomain>
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
	<AANLkTil8Zq_uJrdT2jcVSSDW-LN0OxpnHcGnI9aBR4Zz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1730840273884717628=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailrelay.embarq.synacor.com (mailrelay.embarq.synacor.com
	[208.47.184.3]) by alsa0.perex.cz (Postfix) with ESMTP id AC26C103826
	for <alsa-devel@alsa-project.org>;
	Mon, 19 Jul 2010 04:56:07 +0200 (CEST)
In-Reply-To: <AANLkTil8Zq_uJrdT2jcVSSDW-LN0OxpnHcGnI9aBR4Zz@mail.gmail.com>
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


--===============1730840273884717628==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-O4bDM/u3XxiBKTCzngBX"


--=-O4bDM/u3XxiBKTCzngBX
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2010-07-19 at 09:44 +0800, Raymond Yau wrote:
> 2010/7/15 Colin Guthrie <gmane@colin.guthr.ie>
>=20
> > 'Twas brillig, and Chris at 15/07/10 02:38 did gyre and gimble:
> > > On Thu, 2010-07-15 at 08:08 +0800, Raymond Yau wrote:
> > >
> > >>> I posted both of those bug reports. Honestly, I just want it to wor=
k
> > >>> without all the error output to syslog and thrashing of my HD for
> > >>> minutes at a time. As I said, I've got the output of pulseaudio -vv=
vvv
> > >>> if anyone would like to look at it and tell me what I need to do to=
 fix
> > >>> the problem.
> > >>>
> > >>> Chris
> > >>>
> > >>>
> > >>>
> > >> Just upload your current pulseaudio.log and output of alsa-info.sh t=
o
> > >> mandriva 's bugzilla
> > >>
> > >> Cannot obtain any conclusion based on the log which you have posted =
last
> > >> year ( xmms)
> > >>
> > >> as Jaroslav Kysela said , need the real system time between I/O
> > operations
> > >> and you'll see if it's issue in the ALSA driver or a task scheduling
> > >> problem.
> > >
> > > Here is the bug report with the outputs uploaded.
> > >
> > > https://qa.mandriva.com/show_bug.cgi?id=3D60169
> >
> > Well seeing as my process when getting such a bug is to report it here
> > on behalf of the user, I suspect that this has reached a stalemate....
> >
> >
> >
> Refer to https://qa.mandriva.com/show_bug.cgi?id=3D56473#c10
>=20
> I have installed mandriva 2010 on virtual box
>=20
> when using xmms and libao output plugin to play system sound startup3.wav
>=20
> xmms hang at the end of the playback only when enable buffering in libao
> output plugin.(configure output plugin in xmms, unfortunately default is
> enable buffering buffer size 3000 chunk size 1000)  ,
>=20
> xmms does not hang when you disable the buffer or using liboss/libALSA
> output plugin
>=20
> The last message in the pulseaudio server is
> D: protocol-native.c  'underrun on libao[xmms] playback stream' , 0 bytes=
 in
> queue.
>=20
> The sound card seem running since hw_ptr and appl_ptr are increasing when
> cat /proc/asound/card0/pcm0p/sub0/status
>=20
> After a while , the following message appear
>=20
> E:alsa-sink.c : ALSA woke us up to write new data , but there was actuall=
y
> nothing to write!
The above is exactly what I see periodically Raymond, so, what, if any,
is the fix?

Chris

--=20
Chris
KeyID 0xE372A7DA98E6705C


--=-O4bDM/u3XxiBKTCzngBX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkxDvsQACgkQ43Kn2pjmcFymqgCbBGHNfM4gvK9uFW378D2uSRXr
+UwAn3WMDYgMxcjtmIxL04GsWwJdM5s0
=lyqY
-----END PGP SIGNATURE-----

--=-O4bDM/u3XxiBKTCzngBX--


--===============1730840273884717628==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============1730840273884717628==--
