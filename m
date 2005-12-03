From: Nicolas Mailhot <nicolas.mailhot@laposte.net>
Subject: Re: Revo 7.1 setup ?
Date: Sat, 03 Dec 2005 20:41:29 +0100
Message-ID: <1133638892.5025.10.camel@rousalka.dyndns.org>
References: <1133636889.4274.7.camel@rousalka.dyndns.org>
	 <1133638082.16836.16.camel@mindpipe>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-GG3xuOnSZri6HQtogxS8"
Return-path: <alsa-user-admin@lists.sourceforge.net>
In-Reply-To: <1133638082.16836.16.camel@mindpipe>
Sender: alsa-user-admin@lists.sourceforge.net
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-user@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-GG3xuOnSZri6HQtogxS8
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Le samedi 03 d=C3=A9cembre 2005 =C3=A0 14:28 -0500, Lee Revell a =C3=A9crit=
 :
> On Sat, 2005-12-03 at 20:08 +0100, Nicolas Mailhot wrote:
> > Hi,
> >=20
> > I'm trying to setup a revo 7.1 in digital out mode (will do 5.1 analog
> > whenever I receive Y cables).
> >=20
> > After much googling the best asoundrc setting I found is :
> >=20
> > pcm.!default {
> >         type plug
> >         slave.pcm "spdif"
> > }
>=20
> That .asoundrc does nothing that you could not do by setting the app to
> use the "spdif" PCM - it's useless.

I don't want to set up apps; I want the default output to be spdif for
all the system and all apps, regardless of the sound system they use
(oss, alsa, gstreamer or whatever).

without an .asoundrc I get no sound, I suppose it's routed to the analog
outputs but since they're not cabled yet it does me no good (yes I tried
toggling IEC958 Output in alsamixer).

I created this setup after seing an old message from Takashi stating
aplay -d plug:spdif should work with this card (no idea where spdif is
defined). And then googling half an hour more on how to make a plug the
default. This after trying all the revo asoundrc examples I could find
on the net, none of which did me much good.

> If you get no sound at all without an .asoundrc it's a bug, please file
> a bug report:
>=20
> https://bugtrack.alsa-project.org/alsa-bug/main_page.php

I'm more than ready to file a bug once I have a working spdif output
setup. I don't really see the point of tracking it's broken without any
more info. In my experience bugs get fixed when a solution is provided
(with developers arguing afterwards whether it's the best one or not,
but at least they have a reference to work from)

Regards,

--=20
Nicolas Mailhot

--=-GG3xuOnSZri6HQtogxS8
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iEYEABECAAYFAkOR9OcACgkQI2bVKDsp8g356wCfSY0gfA1x+iKjipMcLxCfWUGo
7qcAoMnM9nIeJu45LmkV4D89Ck3Nx7MW
=rrd8
-----END PGP SIGNATURE-----

--=-GG3xuOnSZri6HQtogxS8--



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
