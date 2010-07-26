From: Chris <cpollock@embarqmail.com>
Subject: Re: [Fwd: Re: [pulseaudio-discuss] pulseaudio debug
 mode]
Date: Sun, 25 Jul 2010 20:30:04 -0500
Message-ID: <1280107804.29411.1.camel@localhost.localdomain>
References: <1280097015.29696.8.camel@localhost.localdomain>
	<AANLkTimj3W_tgi-+Qqgz-J31u-daOqJ8a2E74qEUzy8U@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1410845534601526784=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailrelay.embarq.synacor.com (mailrelay.embarq.synacor.com
	[208.47.184.3]) by alsa0.perex.cz (Postfix) with ESMTP id AF37D245AC
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Jul 2010 03:30:07 +0200 (CEST)
In-Reply-To: <AANLkTimj3W_tgi-+Qqgz-J31u-daOqJ8a2E74qEUzy8U@mail.gmail.com>
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


--===============1410845534601526784==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-EhHaHukkdPIMcMmlCxwD"


--=-EhHaHukkdPIMcMmlCxwD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2010-07-26 at 07:31 +0800, Raymond Yau wrote:
> 2010/7/26 Chris <cpollock@embarqmail.com>
>=20
> > Raymond, attached is a post I made today to the pulseaudio list.
> >
> > From: Chris <cpollock@embarqmail.com>
> > To: pulseaudio-discuss@mail.0pointer.de
> > Date: Sun, 25 Jul 2010 12:15:02 -0500
> > Subject: Re: [pulseaudio-discuss] pulseaudio debug mode
> > On Fri, 2010-07-23 at 08:58 +0100, Colin Guthrie wrote:
> > > 'Twas brillig, and Chris at 23/07/10 02:04 did gyre and gimble:
> > > > What is the best way to start PA for debugging and still have all t=
he
> > > > usual clients running?
> > >
> > > If you mean having all the clients connect (e.g. applications with
> > > libcanberra support or similar for sound events), then there are
> > > basically two ways.
> > >
> > > The first is as Luke suggests. These clients will automatically
> > > reconnect to PA if they need to (provided you have a vaguely recent
> > > libcanberra), after it is restarted and run in debug mode.
> > >
> > > Alternatively you can simply set debug-level to "debug" in daemon.con=
f
> > > (in /etc/pulse or ~/.pulse), and then "grep pulseaudio /var/log/messa=
ges"
> > >
> > > Col
> > >
> >
> > Colin, link below is for debug output also some other output. Anything
> > look out of place that would cause the overruns?
> >
> > http://pastebin.com/ZWSWmXZt
> > --
> >
>=20
> Most likely you will need to set debug-level to "debug" in daemon.conf
> logout and login , and check the /var/log/messages
>=20
> I suspect it occur after PA server abort and auto spawn , so please don't
> just post the PA log starting from "asyncq overrun" , you need to post fr=
om
> the last two PA startup sequence before the error occur since we need to
> know why PA auto spawn

Is this what you mean Raymond:
http://pastebin.com/4RT7YaG6



--=20
Chris
KeyID 0xE372A7DA98E6705C


--=-EhHaHukkdPIMcMmlCxwD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkxM5RsACgkQ43Kn2pjmcFwymwCfRzLmZAwWH9nFrlFJO52EDwxf
JisAoIRezpNxvAOZEMfIUCUDV03Ai3ap
=y2al
-----END PGP SIGNATURE-----

--=-EhHaHukkdPIMcMmlCxwD--


--===============1410845534601526784==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============1410845534601526784==--
