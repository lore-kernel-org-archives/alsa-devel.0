From: Chris <cpollock@embarqmail.com>
Subject: Re: alsa-util.c: snd_pcm_avail() returned a value that
 is exceptionally large: 349696 bytes (1821 ms).
Date: Wed, 23 Dec 2009 06:12:13 -0600
Message-ID: <1261570333.17575.1.camel@localhost.localdomain>
References: <1261191766.18070.10.camel@localhost.localdomain>
	<4f3252890912191547x1996cf7es190e8dac71dacaae@mail.gmail.com>
	<1261352484.18070.47.camel@localhost.localdomain>
	<4f3252890912201745j386981b6v66d2c717c16e892e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7429011244119035881=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailrelay.embarq.synacor.com (mailrelay.embarq.synacor.com
	[208.47.184.3]) by alsa0.perex.cz (Postfix) with ESMTP id B70FC2413B
	for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2009 13:12:16 +0100 (CET)
In-Reply-To: <4f3252890912201745j386981b6v66d2c717c16e892e@mail.gmail.com>
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


--===============7429011244119035881==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-hDvakRkSVAGPOPxM8j6x"


--=-hDvakRkSVAGPOPxM8j6x
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2009-12-21 at 09:45 +0800, Raymond Yau wrote:
> 2009/12/21 Chris <cpollock@embarqmail.com>
>=20
> > On Sun, 2009-12-20 at 07:47 +0800, Raymond Yau wrote:
> > > I can reproduce this bug on pulseaudio-0.9.14 by
> > >
> > > aplay -v --period-size=3D32  any_rate_not_equal_44100Hz.wav
> > >
> > >
> >
> > Anyway to stop this from happening? When it does happen it's causing my
> > drive to thrash for about 4-5 minutes or longer as shown below:
> >
> > Dec 20 14:35:50 localhost pulseaudio[4331]: ratelimit.c: 271 events
> > suppressed
> > Dec 20 14:35:50 localhost pulseaudio[4331]: asyncq.c: q overrun, queuin=
g
> > locally
> >
> > Dec 20 14:44:15 localhost pulseaudio[4331]: asyncq.c: q overrun, queuin=
g
> > locally
> >
> >
> >
> you have to provide  a test case which can reproduce this bug and a full
> pulseaudio log which recorded how this bug occur
>=20
> http://www.pulseaudio.org/wiki/Community#BugsPatchesTranslations
>=20
> If autospawning is enabled (which it now is by default) you might have to
> race against it when restarting PA, so it might be a good idea to issue
> "pulseaudio -k ; pulseaudio -vvvvv" in a single command
>=20
>=20
> In my case , I suspect the latency and watermark calculation did not get =
the
> correct watermark/sleeping time when the alsa application using small per=
iod
> size (128 bytes is the alsa-pulse-plugin 's minimum period size ) since t=
he
> error "asyncq.c: q overrun, queuing
> locally" does not occur when using the normal period_size of those
> applications (e.g. aplay , mplayer work quite well ) or rewind too much
> since snd_pcm_rewind() is a new function which is only used by PA server
>=20
>=20
I have the output of the above command, where do I post it?



--=20
KeyID 0xE372A7DA98E6705C


--=-hDvakRkSVAGPOPxM8j6x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAksyCRIACgkQ43Kn2pjmcFx5RACfQYkaH2yYQSo/lDMXzZedzq1m
dCwAn2N9ZWtte5a/gTIKxukErE006oxN
=wrb2
-----END PGP SIGNATURE-----

--=-hDvakRkSVAGPOPxM8j6x--


--===============7429011244119035881==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============7429011244119035881==--
