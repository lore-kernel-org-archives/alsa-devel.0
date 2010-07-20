From: Chris <cpollock@embarqmail.com>
Subject: Re: Which project to choose?
Date: Tue, 20 Jul 2010 17:19:48 -0500
Message-ID: <1279664388.18063.51.camel@localhost.localdomain>
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
	<1279508164.22741.27.camel@localhost.localdomain>
	<AANLkTilHj1RR50u0kN7cedIuV72qxqvTX1YDriT6ajqi@mail.gmail.com>
	<i210af$6gi$1@dough.gmane.org>
	<1279579946.18063.26.camel@localhost.localdomain>
	<AANLkTinIcGY_OwOftiZwICap7r_4VviWKqE-2zOZrgQM@mail.gmail.com>
	<1279592026.18063.44.camel@localhost.localdomain>
	<AANLkTimcx0Z1pkLJmCrpmBfo2xLA_Dtt-RG4L6V-JTGf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2979161731282560493=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailrelay.embarq.synacor.com (mailrelay.embarq.synacor.com
	[208.47.184.3]) by alsa0.perex.cz (Postfix) with ESMTP id D672824150
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Jul 2010 00:19:53 +0200 (CEST)
In-Reply-To: <AANLkTimcx0Z1pkLJmCrpmBfo2xLA_Dtt-RG4L6V-JTGf@mail.gmail.com>
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


--===============2979161731282560493==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-5h88t4/8Bvac9aIlaRQ7"


--=-5h88t4/8Bvac9aIlaRQ7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2010-07-20 at 19:41 +0800, Raymond Yau wrote:
> 2010/7/20 Chris <cpollock@embarqmail.com>
>=20

> >
> >
> AFAIK , mplayer does not support CD playback ? ( seem only VCD or DVD )
>=20
> most likely mandriva had patched the shortcut of gmplayer to use padsp an=
d
> that 's why you can see "OSS Emulation[mplayer]" in the pulseaudio log
>=20
> How about using ALSA OSS emulation instead of padsp ?
>=20
> mplayer -v -ao oss any.wav
>=20
>=20
> Trying preferred audio driver 'oss', options '[none]'
> ao2: 44100 Hz  2 chans  s16le
> audio_setup: using '/dev/dsp' dsp device
> audio_setup: using '/dev/mixer' mixer device
> audio_setup: using 'pcm' mixer device
> audio_setup: sample format: s16le (requested: s16le)
> audio_setup: using 2 channels (requested: 2)
> audio_setup: using 44100 Hz samplerate (requested: 44100)
> audio_setup: frags:  16/16  (4096 bytes/frag)  free:  65536
>=20
>=20
> This force mplayer to use power two period size (4096 bytes) and this may
> meet the requirement of ens1371 if PCI data transfer are 8 Long bytes bru=
st
> transfer
>=20
> 5.5 PCI Data transfer
>=20
> Only brust read/write transfers are allowed. All data transfer are 8 Long
> Word brust transfers
>=20
> As your PA server using period size 1102  which is not multiple of 8 ( 32
> bytes )
>=20
> It seem that you have customised the deamon.conf since PA server using
> maximum buffer size
>=20
> The sound quality seem ok when playing audio using mplayer inside the
> virtualbox
>=20
> The following messages sometime come up at the beginning of the playback
> only when watching videos using mplayer -ao alsa:device=3Dpulse
>=20
> ao_alsa: write error: Broken pipe
> ao_alsa: trying to *reset* *soundcard*
> ao_alsa: write error: Broken pipe
> ao_alsa: trying to *reset* *soundcard*
>=20
> The sound quality is still fine when watching video using
>=20
> mplayer -v -ao alsa:device=3Dpulse
> mplayer -v -ao alsa:device=3Dhw=3D0
> mplayer -v -ao pulse
> mplayer -v ao oss
> _______________________________________________

Before I try the above Raymond, what would cause the below when the
system is sitting here basically idle? I'm not even home to do anything
when this happened?

Jul 20 11:32:43 localhost pulseaudio[28711]: asyncq.c: q overrun,
queuing locally
Jul 20 11:32:43 localhost pulseaudio[28711]: asyncq.c: q overrun,
queuing locally
Jul 20 11:32:43 localhost pulseaudio[28711]: asyncq.c: q overrun,
queuing locally
Jul 20 11:32:43 localhost pulseaudio[28711]: asyncq.c: q overrun,
queuing locally
Jul 20 11:32:43 localhost pulseaudio[28711]: asyncq.c: q overrun,
queuing locally
Jul 20 11:32:43 localhost pulseaudio[28711]: asyncq.c: q overrun,
queuing locally
Jul 20 11:32:43 localhost pulseaudio[28711]: asyncq.c: q overrun,
queuing locally
Jul 20 11:32:43 localhost pulseaudio[28711]: asyncq.c: q overrun,
queuing locally
Jul 20 11:32:43 localhost pulseaudio[28711]: asyncq.c: q overrun,
queuing locally
Jul 20 11:32:43 localhost pulseaudio[28711]: asyncq.c: q overrun,
queuing locally
Jul 20 11:32:45 localhost pulseaudio[28711]: ratelimit.c: 240 events
suppressed
Jul 20 11:32:45 localhost pulseaudio[28711]: asyncq.c: q overrun,
queuing locally
Jul 20 11:32:45 localhost pulseaudio[28711]: asyncq.c: q overrun,
queuing locally
Jul 20 11:32:45 localhost pulseaudio[28711]: asyncq.c: q overrun,
queuing locally
Jul 20 11:32:45 localhost pulseaudio[28711]: asyncq.c: q overrun,
queuing locally
Jul 20 11:32:45 localhost pulseaudio[28711]: asyncq.c: q overrun,
queuing locally
Jul 20 11:32:45 localhost pulseaudio[28711]: asyncq.c: q overrun,
queuing locally
Jul 20 11:32:45 localhost pulseaudio[28711]: asyncq.c: q overrun,
queuing locally
Jul 20 11:32:45 localhost pulseaudio[28711]: asyncq.c: q overrun,
queuing locally
Jul 20 11:32:45 localhost pulseaudio[28711]: asyncq.c: q overrun,
queuing locally
Jul 20 11:32:45 localhost pulseaudio[28711]: asyncq.c: q overrun,
queuing locally
Jul 20 11:32:45 localhost pulseaudio[28711]: asyncq.c: q overrun,
queuing locally

The only thing that is going on just prior this is:

Jul 20 11:32:02 localhost mdkapplet[17869]: Computing new updates...
Jul 20 11:32:04 localhost mdkapplet[17869]: running: urpmi.update
--update
Jul 20 11:32:10 localhost mdkapplet[17869]: updating inactive backport
media Main Backports (Official2010.1-4), Contrib Backports
(Official2010.1-12), Non-free Backports (Official2010.1-20), PLF Free
backports, PLF Non-free backports
Jul 20 11:32:10 localhost mdkapplet[17869]: running: urpmi.update Main
Backports (Official2010.1-4)
Jul 20 11:32:12 localhost mdkapplet[17869]: running: urpmi.update
Contrib Backports (Official2010.1-12)
Jul 20 11:32:14 localhost mdkapplet[17869]: running: urpmi.update
Non-free Backports (Official2010.1-20)
Jul 20 11:32:16 localhost mdkapplet[17869]: running: urpmi.update PLF
Free backports
Jul 20 11:32:17 localhost mdkapplet[17869]: running: urpmi.update PLF
Non-free backports


--=20
Chris
KeyID 0xE372A7DA98E6705C


--=-5h88t4/8Bvac9aIlaRQ7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkxGIQQACgkQ43Kn2pjmcFxQxACffFw+ZXUqZoMZ6leEvJ2y3c4D
XwEAn2FJ2pjXlY1v6XcIsL02+2JzAVfp
=j493
-----END PGP SIGNATURE-----

--=-5h88t4/8Bvac9aIlaRQ7--


--===============2979161731282560493==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============2979161731282560493==--
