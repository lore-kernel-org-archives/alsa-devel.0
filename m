From: Chris <cpollock@embarqmail.com>
Subject: Re: [Fwd: Re: [pulseaudio-discuss] pulseaudio debug
 mode]
Date: Mon, 26 Jul 2010 06:22:41 -0500
Message-ID: <1280143361.19933.14.camel@localhost.localdomain>
References: <1280097015.29696.8.camel@localhost.localdomain>
	<AANLkTimj3W_tgi-+Qqgz-J31u-daOqJ8a2E74qEUzy8U@mail.gmail.com>
	<1280107804.29411.1.camel@localhost.localdomain>
	<AANLkTimoBu3baCYdDWoBQkATrXhG2R2ExYvWybKy1WK_@mail.gmail.com>
	<1280113577.19933.2.camel@localhost.localdomain>
	<AANLkTinc+yEo-xDpPHC1eoxEmmuSXfrhkK50zD75QwKR@mail.gmail.com>
	<AANLkTin4S-S-xKkx41ZVZKVJVJ+T8ppuHsi033J8ZT=3@mail.gmail.com>
	<i2jkgq$c2o$2@dough.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8380036569556579105=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailrelay.embarq.synacor.com (mailrelay.embarq.synacor.com
	[208.47.184.3]) by alsa0.perex.cz (Postfix) with ESMTP id 46564103891
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Jul 2010 13:22:44 +0200 (CEST)
In-Reply-To: <i2jkgq$c2o$2@dough.gmane.org>
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


--===============8380036569556579105==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-9NYnr4iFkyOfMzSM9kxK"


--=-9NYnr4iFkyOfMzSM9kxK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2010-07-26 at 10:29 +0100, Colin Guthrie wrote:
> 'Twas brillig, and Raymond Yau at 26/07/10 05:21 did gyre and gimble:
> > 2010/7/26 Raymond Yau <superquad.vortex2@gmail.com>

> >     if (flush_postq(l, FALSE))
> >         if (pa_asyncq_push(l, p, FALSE) >=3D 0)
> >             return;
>=20
>=20
> I can add this kind of debug to a package for you Chris if you like. I'm
> not 100% sure what info it will find out though....
>=20
> What arch are you using i586 or x86_64?
>=20
> Col
>=20

Using i586 Colin, however, it wouldn't do any good for me since to be
honest I have no idea what I'm looking at anyway. And Raymond, for your
question about did PA get stopped during it's update, PA did not get
updated, all that was happening was that the Mandriva update applet was
checking to see if there were any software updates. Just a small snip
below of what was going on when MSEC was running this morning.


Jul 26 04:07:31 localhost postfix/qmgr[5447]: 9792932E8FF: removed
Jul 26 04:08:57 localhost pulseaudio[26721]: (30240.557| 945.629)
ratelimit.c: 59 events suppressed
Jul 26 04:08:57 localhost pulseaudio[26721]: (30240.674|   0.116)
alsa-sink.c: Underrun!
Jul 26 04:08:57 localhost pulseaudio[26721]: (30240.675|   0.001)
alsa-sink.c: Increasing wakeup watermark to 110.02 ms
Jul 26 04:08:58 localhost pulseaudio[26721]: (30241.305|   0.629)
alsa-sink.c: Underrun!
Jul 26 04:08:58 localhost pulseaudio[26721]: (30241.305|   0.000)
alsa-sink.c: Increasing wakeup watermark to 120.02 ms
Jul 26 04:09:00 localhost pulseaudio[26721]: (30243.974|   2.668)
alsa-sink.c: Underrun!
Jul 26 04:09:00 localhost pulseaudio[26721]: (30243.974|   0.000)
alsa-sink.c: Increasing wakeup watermark to 130.02 ms
Jul 26 04:09:03 localhost pulseaudio[26721]: (30246.449|   2.475)
asyncq.c: q overrun, queuing locally

Jul 26 04:09:03 localhost pulseaudio[26721]: (30246.549|   0.000)
asyncq.c: q overrun, queuing locally
Jul 26 04:09:08 localhost pulseaudio[26721]: (30251.453|   4.903)
ratelimit.c: 506 events suppressed
Jul 26 04:09:08 localhost pulseaudio[26721]: (30251.453|   0.000)
asyncq.c: q overrun, queuing locally

Jul 26 04:09:20 localhost pulseaudio[26721]: (30264.021|   2.463)
alsa-sink.c: Decreasing wakeup watermark to 125.03 ms
Jul 26 04:09:23 localhost pulseaudio[26721]: (30266.494|   2.472)
ratelimit.c: 465 events suppressed
Jul 26 04:09:23 localhost pulseaudio[26721]: (30266.494|   0.000)
asyncq.c: q overrun, queuing locally
Jul 26 04:09:23 localhost pulseaudio[26721]: (30266.494|   0.000)
asyncq.c: q overrun, queuing locally
Jul 26 04:09:23 localhost pulseaudio[26721]: (30266.494|   0.000)
memblock.c: Pool full

Jul 26 04:10:02 localhost pulseaudio[26721]: (30305.200|   3.552)
alsa-sink.c: Decreasing wakeup watermark to 120.05 ms
Jul 26 04:10:03 localhost pulseaudio[26721]: (30306.577|   1.376)
ratelimit.c: 593 events suppressed
Jul 26 04:10:03 localhost pulseaudio[26721]: (30306.577|   0.000)
asyncq.c: q overrun, queuing locally

Jul 26 04:10:07 localhost pulseaudio[26721]: (30311.019|   4.382)
alsa-sink.c: Increasing wakeup watermark to 130.05 ms
Jul 26 04:10:11 localhost pulseaudio[26721]: (30314.446|   3.426)
ratelimit.c: 368 events suppressed
Jul 26 04:10:11 localhost pulseaudio[26721]: (30314.446|   0.000)
asyncq.c: q overrun, queuing locally

Jul 26 04:10:13 localhost pulseaudio[26721]: (30316.718|   2.172)
alsa-sink.c: Increasing wakeup watermark to 140.00 ms
Jul 26 04:10:15 localhost clamd[21295]: Reading databases
from /var/lib/clamav
Jul 26 04:10:15 localhost pulseaudio[26721]: (30318.448|   1.729)
alsa-sink.c: Increasing minimal latency to 1.00 ms

Jul 26 04:10:35 localhost pulseaudio[26721]: (30338.504|  20.014)
alsa-sink.c: Decreasing wakeup watermark to 135.01 ms
Jul 26 04:10:40 localhost clamd[21295]: Database correctly reloaded
(1136734 signatures)
Jul 26 04:10:55 localhost pulseaudio[26721]: (30358.517|  20.013)
alsa-sink.c: Decreasing wakeup watermark to 130.02 ms
Jul 26 04:11:15 localhost pulseaudio[26721]: (30378.535|  20.017)
alsa-sink.c: Decreasing wakeup watermark to 125.03 ms
Jul 26 04:11:16 localhost pulseaudio[26721]: (30379.598|   1.063)
ratelimit.c: 76 events suppressed
Jul 26 04:11:16 localhost pulseaudio[26721]: (30379.598|   0.000)
alsa-sink.c: Underrun!
Jul 26 04:11:16 localhost pulseaudio[26721]: (30379.598|   0.000)
alsa-sink.c: Increasing wakeup watermark to 135.03 ms
Jul 26 04:11:37 localhost pulseaudio[26721]: (30400.820|  21.222)
alsa-sink.c: Decreasing wakeup watermark to 130.05 ms
Jul 26 04:11:57 localhost pulseaudio[26721]: (30420.826|  20.005)
alsa-sink.c: Decreasing wakeup watermark to 125.06 ms
Jul 26 04:12:17 localhost pulseaudio[26721]: (30440.826|  20.000)
alsa-sink.c: Decreasing wakeup watermark to 120.07 ms
Jul 26 04:12:37 localhost pulseaudio[26721]: (30460.845|  20.019)
alsa-sink.c: Decreasing wakeup watermark to 115.08 ms
Jul 26 04:12:57 localhost pulseaudio[26721]: (30480.879|  20.033)
alsa-sink.c: Decreasing wakeup watermark to 110.09 ms
Jul 26 04:13:17 localhost pulseaudio[26721]: (30500.909|  20.030)
alsa-sink.c: Decreasing wakeup watermark to 105.10 ms
Jul 26 04:13:17 localhost pulseaudio[26721]: (30501.130|   0.220)
asyncq.c: q overrun, queuing locally


--=20
Chris
KeyID 0xE372A7DA98E6705C


--=-9NYnr4iFkyOfMzSM9kxK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkxNcAEACgkQ43Kn2pjmcFxvoQCghWDKKX4WHQjjSVdWu1jWaLzG
5aQAnAzXI1zgX7o50oSllgRlcciJECDN
=GL4H
-----END PGP SIGNATURE-----

--=-9NYnr4iFkyOfMzSM9kxK--


--===============8380036569556579105==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============8380036569556579105==--
