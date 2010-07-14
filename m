From: Chris <cpollock@embarqmail.com>
Subject: Re: Which project to choose?
Date: Wed, 14 Jul 2010 17:58:12 -0500
Message-ID: <1279148292.29042.19.camel@localhost.localdomain>
References: <1279062131.24837.22.camel@localhost.localdomain>
	<AANLkTikEf4gf-oeQf4hNGUEvNi0YVrvutnSMCbxGwtJ8@mail.gmail.com>
	<1279065709.24837.29.camel@localhost.localdomain>
	<AANLkTilT1F0hUp2m5C-9PbY_Ef7oaiAxftwJvU_w6i0y@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5171894828332668580=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailrelay.embarq.synacor.com (mailrelay.embarq.synacor.com
	[208.47.184.3]) by alsa0.perex.cz (Postfix) with ESMTP id 3AEA8103894
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Jul 2010 00:58:14 +0200 (CEST)
In-Reply-To: <AANLkTilT1F0hUp2m5C-9PbY_Ef7oaiAxftwJvU_w6i0y@mail.gmail.com>
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


--===============5171894828332668580==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-h44WnFaR3kYm9ov4s/fr"


--=-h44WnFaR3kYm9ov4s/fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2010-07-15 at 06:32 +0800, Raymond Yau wrote:
> 2010/7/14 Chris <cpollock@embarqmail.com>
>=20
> > On Wed, 2010-07-14 at 07:26 +0800, Raymond Yau wrote:
> > > 2010/7/14 Chris <cpollock@embarqmail.com>
> > >
> >
> >
> > Then Raymond, tell me, how do I stop this from happening? It just
> > happens, I'm not playing any audio when it does. For instance
> >
> > Jul 13 17:29:39 localhost pulseaudio[24553]: ratelimit.c: 466 events
> > suppressed
> > Jul 13 17:29:39 localhost pulseaudio[24553]: asyncq.c: q overrun,
> > queuing locally
> > Jul 13 17:29:39 localhost pulseaudio[24553]: asyncq.c: q overrun,
> > queuing locally
> > Jul 13 17:29:39 localhost pulseaudio[24553]: asyncq.c: q overrun,
> > queuing locally
> >
>=20
>=20
> > Jul 13 17:29:39 localhost pulseaudio[24553]: asyncq.c: q overrun,
> > queuing locally
> > Jul 13 17:29:44 localhost pulseaudio[24553]: ratelimit.c: 497 events
> > suppressed
> >
> > So, is this a pulseaudio issue or an Alsa issue?
> >
> >
>=20
> You have to ask PA developer about "asyncq.c: q overrun,
> queuing locally" , this seem to be asyncq_push() cannot be called twice a=
nd
> I have no idea about this operation has any direct relationship with alsa
Raymond, can I send you the output log to look at? It's only 9k bzipp'd.
Maybe you can give me an idea of what I should do and whom I should
contact.

Thanks
Chris


--=20
Chris
KeyID 0xE372A7DA98E6705C


--=-h44WnFaR3kYm9ov4s/fr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkw+QQMACgkQ43Kn2pjmcFy1BgCff/C8ReO4wutDBNYfsk0RONAG
h9cAn0BYrCL/zUuOFWFqDhSoFQLQ9QXy
=9stA
-----END PGP SIGNATURE-----

--=-h44WnFaR3kYm9ov4s/fr--


--===============5171894828332668580==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============5171894828332668580==--
