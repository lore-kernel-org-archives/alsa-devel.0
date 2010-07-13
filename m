From: Chris <cpollock@embarqmail.com>
Subject: Which project to choose?
Date: Tue, 13 Jul 2010 18:02:11 -0500
Message-ID: <1279062131.24837.22.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1951331328226236893=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailrelay.embarq.synacor.com (mailrelay.embarq.synacor.com
	[208.47.184.3]) by alsa0.perex.cz (Postfix) with ESMTP id CABC024142
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Jul 2010 01:02:14 +0200 (CEST)
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


--===============1951331328226236893==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-IT2zOgN4pdMo2qLkTcdJ"


--=-IT2zOgN4pdMo2qLkTcdJ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I want to submit a bug report on the below. This issue was noted in
Mandriva 2010 and is still present in 2010.1

pulseaudio[24553]: alsa-util.c: snd_pcm_delay() returned a value that is
exceptionally large: -161920 bytes (-917 ms).
localhost pulseaudio[24553]: alsa-util.c: Most likely this is a bug in
the ALSA driver 'snd_ens1371'. Please report this issue to the ALSA
developers.
localhost pulseaudio[24553]: alsa-util.c: snd_pcm_dump():
localhost pulseaudio[24553]: alsa-util.c: Hardware PCM card 0 'Ensoniq
AudioPCI' device 0 subdevice 0
localhost pulseaudio[24553]: alsa-util.c: Its setup is:
localhost pulseaudio[24553]: alsa-util.c:   stream       : PLAYBACK
localhost pulseaudio[24553]: alsa-util.c:   access       :
MMAP_INTERLEAVED
localhost pulseaudio[24553]: alsa-util.c:   format       : S16_LE
localhost pulseaudio[24553]: alsa-util.c:   subformat    : STD
localhost pulseaudio[24553]: alsa-util.c:   channels     : 2
localhost pulseaudio[24553]: alsa-util.c:   rate         : 44100
localhost pulseaudio[24553]: alsa-util.c:   exact rate   : 44101
(1445100000/32768)
localhost pulseaudio[24553]: alsa-util.c:   msbits       : 16
localhost pulseaudio[24553]: alsa-util.c:   buffer_size  : 4408
localhost pulseaudio[24553]: alsa-util.c:   period_size  : 1102
localhost pulseaudio[24553]: alsa-util.c:   period_time  : 24988
localhost pulseaudio[24553]: alsa-util.c:   tstamp_mode  : ENABLE
localhost pulseaudio[24553]: alsa-util.c:   period_step  : 1
localhost pulseaudio[24553]: alsa-util.c:   avail_min    : 1102
localhost pulseaudio[24553]: alsa-util.c:   period_event : 1
localhost pulseaudio[24553]: alsa-util.c:   start_threshold  : -1
localhost pulseaudio[24553]: alsa-util.c:   stop_threshold   :
1155530752
localhost pulseaudio[24553]: alsa-util.c:   silence_threshold: 0
localhost pulseaudio[24553]: alsa-util.c:   silence_size : 0
localhost pulseaudio[24553]: alsa-util.c:   boundary     : 1155530752
localhost pulseaudio[24553]: alsa-util.c:   appl_ptr     : 735801008
localhost pulseaudio[24553]: alsa-util.c:   hw_ptr       : 735846184
localhost pulseaudio[24553]: ratelimit.c: 280 events suppressed
localhost pulseaudio[24553]: asyncq.c: q overrun, queuing locally

Because of the constant disk access when this is happening my system
becomes almost unusable.

--=20
Chris
KeyID 0xE372A7DA98E6705C


--=-IT2zOgN4pdMo2qLkTcdJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkw88HMACgkQ43Kn2pjmcFwf3wCfW2N94eTHZbnz/4004hywVYrJ
ZhcAniwa1VA+LgvO4+V10DRl+wKMcNbN
=btMe
-----END PGP SIGNATURE-----

--=-IT2zOgN4pdMo2qLkTcdJ--


--===============1951331328226236893==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============1951331328226236893==--
