From: Chris <cpollock@embarqmail.com>
Subject: Re: alsa-util.c: snd_pcm_avail() returned a value that
 is exceptionally large: 349696 bytes (1821 ms).
Date: Sun, 20 Dec 2009 17:41:24 -0600
Message-ID: <1261352484.18070.47.camel@localhost.localdomain>
References: <1261191766.18070.10.camel@localhost.localdomain>
	<4f3252890912191547x1996cf7es190e8dac71dacaae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7212794680239115972=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailrelay.embarq.synacor.com (mailrelay.embarq.synacor.com
	[208.47.184.3]) by alsa0.perex.cz (Postfix) with ESMTP id E2A46245B3
	for <alsa-devel@alsa-project.org>; Mon, 21 Dec 2009 00:41:29 +0100 (CET)
In-Reply-To: <4f3252890912191547x1996cf7es190e8dac71dacaae@mail.gmail.com>
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


--===============7212794680239115972==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-u43Rq1GWF7+qvRNyliNP"


--=-u43Rq1GWF7+qvRNyliNP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2009-12-20 at 07:47 +0800, Raymond Yau wrote:
> I can reproduce this bug on pulseaudio-0.9.14 by
>=20
> aplay -v --period-size=3D32  any_rate_not_equal_44100Hz.wav
>=20
>=20
> y-application-name:ALSA plug-in [aplay], because already set.
> I: module-alsa-sink.c: Trying resume...
> D: alsa-util.c: Maximum hw buffer size is 371 ms
> D: module-alsa-sink.c: hwbuf_unused_frames=3D0
> D: module-alsa-sink.c: setting avail_min=3D4661
> I: module-alsa-sink.c: Resumed successfully...
> D: module-suspend-on-idle.c: Sink
> alsa_output.pci_12eb_2_sound_card_0_alsa_playback_0 becomes idle.
> D: module-suspend-on-idle.c: Sink
> alsa_output.pci_12eb_2_sound_card_0_alsa_playback_0 becomes busy.
> D: resampler.c: Channel matrix:
> D: resampler.c:        I00
> D: resampler.c:     +------
> D: resampler.c: O00 | 1.000
> D: resampler.c: O01 | 1.000
> I: resampler.c: Using resampler 'speex-float-3'
> I: resampler.c: Using float32le as working format.
> I: resampler.c: Choosing speex quality setting 3.
> D: memblockq.c: memblockq requested: maxlength=3D33554432, tlength=3D0, b=
ase=3D4,
> prebuf=3D0, minreq=3D1 maxrewind=3D0
> D: memblockq.c: memblockq sanitized: maxlength=3D33554432, tlength=3D3355=
4432,
> base=3D4, prebuf=3D0, minreq=3D4 maxrewind=3D0
> I: sink-input.c: Created input 0 "ALSA Playback" on
> alsa_output.pci_12eb_2_sound_card_0_alsa_playback_0 with sample spec u8 1=
ch
> 48000Hz and channel map mono
> I: protocol-native.c: Requested tlength=3D501.33 ms, minreq=3D2.67 ms
> D: protocol-native.c: Early requests mode enabled, configuring sink laten=
cy
> to minreq.
> D: memblockq.c: memblockq requested: maxlength=3D4194304, tlength=3D24064=
,
> base=3D1, prebuf=3D23936, minreq=3D128 maxrewind=3D0
> D: memblockq.c: memblockq sanitized: maxlength=3D4194304, tlength=3D24064=
,
> base=3D1, prebuf=3D23936, minreq=3D128 maxrewind=3D0
> I: protocol-native.c: Final latency 504.00 ms =3D 496.00 ms + 2*2.67 ms +=
 2.67
> ms
> I: module-alsa-sink.c: Starting playback.
> D: module-alsa-sink.c: latency set to 4.00ms
> D: module-alsa-sink.c: hwbuf_unused_frames=3D1872
> D: module-alsa-sink.c: setting avail_min=3D2225
> D: module-alsa-sink.c: Requesting rewind due to latency change.
> D: module-alsa-sink.c: Requested to rewind 8192 bytes.
> D: module-alsa-sink.c: Limited to 7608 bytes.
> D: module-alsa-sink.c: before: 1902
> D: module-alsa-sink.c: after: 1902
> D: module-alsa-sink.c: Rewound 7608 bytes.
> D: sink.c: Processing rewind...
> D: sink-input.c: Have to rewind 7608 bytes on render memblockq.
> D: protocol-native.c: Requesting rewind due to end of underrun.
> D: protocol-native.c: Requesting rewind due to end of underrun.
> D: protocol-native.c: Requesting rewind due to end of underrun.
> D: sink-input.c: Requesting rewind due to corking
> D: module-suspend-on-idle.c: Sink
> alsa_output.pci_12eb_2_sound_card_0_alsa_playback_0 becomes idle.
> D: module-alsa-sink.c: hwbuf_unused_frames=3D0
> D: module-alsa-sink.c: setting avail_min=3D7661
> D: module-alsa-sink.c: Requested to rewind 8192 bytes.
> D: module-alsa-sink.c: Limited to 140 bytes.
> D: module-alsa-sink.c: before: 35
> D: module-alsa-sink.c: after: 35
> D: module-alsa-sink.c: Rewound 140 bytes.
> D: sink.c: Processing rewind...
> D: module-suspend-on-idle.c: Sink
> alsa_output.pci_12eb_2_sound_card_0_alsa_playback_0 becomes idle.
> I: sink-input.c: Freeing input 0 "ALSA Playback"
> I: client.c: Freed 1 "ALSA plug-in [aplay]"
> I: protocol-native.c: Connection died.
> I: client.c: Created 2 "Native client (UNIX socket client)"
> D: protocol-native.c: Protocol version: remote 14, local 14
> I: protocol-native.c: Got credentials: uid=3D500 gid=3D500 success=3D1
> D: protocol-native.c: SHM possible: yes
> D: protocol-native.c: Negotiated SHM: yes
> I: module-stream-restore.c: Restoring device for stream
> sink-input-by-application-name:ALSA plug-in [aplay].
> I: module-stream-restore.c: Restoring volume for sink input
> sink-input-by-application-name:ALSA plug-in [aplay].
> D: module-stream-restore.c: Not restoring mute state for sink input
> sink-input-by-application-name:ALSA plug-in [aplay], because already set.
> D: module-suspend-on-idle.c: Sink
> alsa_output.pci_12eb_2_sound_card_0_alsa_playback_0 becomes busy.
> I: resampler.c: Using resampler 'speex-float-3'
> I: resampler.c: Using float32le as working format.
> I: resampler.c: Choosing speex quality setting 3.
> D: memblockq.c: memblockq requested: maxlength=3D33554432, tlength=3D0, b=
ase=3D4,
> prebuf=3D0, minreq=3D1 maxrewind=3D0
> D: memblockq.c: memblockq sanitized: maxlength=3D33554432, tlength=3D3355=
4432,
> base=3D4, prebuf=3D0, minreq=3D4 maxrewind=3D0
> I: sink-input.c: Created input 1 "ALSA Playback" on
> alsa_output.pci_12eb_2_sound_card_0_alsa_playback_0 with sample spec s16l=
e
> 2ch 22050Hz and channel map front-left,front-right
> I: protocol-native.c: Requested tlength=3D500.68 ms, minreq=3D1.45 ms
> D: protocol-native.c: Early requests mode enabled, configuring sink laten=
cy
> to minreq.
> D: memblockq.c: memblockq requested: maxlength=3D4194304, tlength=3D44160=
,
> base=3D4, prebuf=3D44032, minreq=3D128 maxrewind=3D0
> D: memblockq.c: memblockq sanitized: maxlength=3D4194304, tlength=3D44160=
,
> base=3D4, prebuf=3D44032, minreq=3D128 maxrewind=3D0
> I: protocol-native.c: Final latency 502.13 ms =3D 497.78 ms + 2*1.45 ms +=
 1.45
> ms
> D: module-alsa-sink.c: latency set to 4.00ms
> D: module-alsa-sink.c: hwbuf_unused_frames=3D1872
> D: module-alsa-sink.c: setting avail_min=3D2225
> D: module-alsa-sink.c: Requesting rewind due to latency change.
> D: module-alsa-sink.c: Requested to rewind 8192 bytes.
> D: module-alsa-sink.c: Limited to 7804 bytes.
> D: module-alsa-sink.c: before: 1951
> D: module-alsa-sink.c: after: 1951
> D: module-alsa-sink.c: Rewound 7804 bytes.
> D: sink.c: Processing rewind...
> D: sink-input.c: Have to rewind 7804 bytes on render memblockq.
> E: asyncq.c: q overrun, queuing locally
> E: asyncq.c: q overrun, queuing locally
> E: asyncq.c: q overrun, queuing locally
> E: asyncq.c: q overrun, queuing locally
> I: module-alsa-sink.c: Underrun!
> E: asyncq.c: q overrun, queuing locally
> E: asyncq.c: q overrun, queuing locally
> E: asyncq.c: q overrun, queuing locally
> D: protocol-native.c: Requesting rewind due to end of underrun.
> D: protocol-native.c: Requesting rewind due to end of underrun.
> D: protocol-native.c: Requesting rewind due to end of underrun.
> I: module-alsa-sink.c: Underrun!
> I: module-alsa-sink.c: Underrun!
> I: module-alsa-sink.c: Underrun!
> I: module-alsa-sink.c: Underrun!
> D: sink-input.c: Requesting rewind due to corking
> D: module-suspend-on-idle.c: Sink
> alsa_output.pci_12eb_2_sound_card_0_alsa_playback_0 becomes idle.
> D: module-alsa-sink.c: hwbuf_unused_frames=3D0
> D: module-alsa-sink.c: setting avail_min=3D7661
> D: module-alsa-sink.c: Requested to rewind 8192 bytes.
> D: module-suspend-on-idle.c: Sink
> alsa_output.pci_12eb_2_sound_card_0_alsa_playback_0 becomes idle.
> D: module-alsa-sink.c: Limited to 68 bytes.
> D: module-alsa-sink.c: before: 17
> D: module-alsa-sink.c: after: 17
> D: module-alsa-sink.c: Rewound 68 bytes.
> D: sink.c: Processing rewind...
> I: sink-input.c: Freeing input 1 "ALSA Playback"
> I: client.c: Freed 2 "ALSA plug-in [aplay]"
> I: protocol-native.c: Connection died.
> I: module-suspend-on-idle.c: Sink
> alsa_output.pci_12eb_2_sound_card_0_alsa_playback_0 idle for too long,
> suspending ...
> I: module-alsa-sink.c: Device suspended...
> I: client.c: Created 3 "Native client (UNIX socket client)"
> D: protocol-native.c: Protocol version: remote 14, local 14
> I: protocol-native.c: Got credentials: uid=3D500 gid=3D500 success=3D1
> D: protocol-native.c: SHM possible: yes
> D: protocol-native.c: Negotiated SHM: yes
> I: module-stream-restore.c: Restoring device for stream
> sink-input-by-application-name:ALSA plug-in [aplay].
> I: module-stream-restore.c: Restoring volume for sink input
> sink-input-by-application-name:ALSA plug-in [aplay].
> D: module-stream-restore.c: Not restoring mute state for sink input
> sink-input-by-application-name:ALSA plug-in [aplay], because already set.
> I: module-alsa-sink.c: Trying resume...
> D: alsa-util.c: Maximum hw buffer size is 371 ms
> D: module-alsa-sink.c: hwbuf_unused_frames=3D0
> D: module-alsa-sink.c: setting avail_min=3D7661
> I: module-alsa-sink.c: Resumed successfully...
> I: module-alsa-sink.c: Starting playback.
> D: module-suspend-on-idle.c: Sink
> alsa_output.pci_12eb_2_sound_card_0_alsa_playback_0 becomes idle.
> D: module-suspend-on-idle.c: Sink
> alsa_output.pci_12eb_2_sound_card_0_alsa_playback_0 becomes busy.
> I: resampler.c: Using resampler 'speex-float-3'
> I: resampler.c: Using float32le as working format.
> I: resampler.c: Choosing speex quality setting 3.
> D: memblockq.c: memblockq requested: maxlength=3D33554432, tlength=3D0, b=
ase=3D4,
> prebuf=3D0, minreq=3D1 maxrewind=3D0
> D: memblockq.c: memblockq sanitized: maxlength=3D33554432, tlength=3D3355=
4432,
> base=3D4, prebuf=3D0, minreq=3D4 maxrewind=3D0
> I: sink-input.c: Created input 2 "ALSA Playback" on
> alsa_output.pci_12eb_2_sound_card_0_alsa_playback_0 with sample spec s16l=
e
> 2ch 22050Hz and channel map front-left,front-right
> I: protocol-native.c: Requested tlength=3D500.68 ms, minreq=3D1.45 ms
> D: protocol-native.c: Early requests mode enabled, configuring sink laten=
cy
> to minreq.
> D: memblockq.c: memblockq requested: maxlength=3D4194304, tlength=3D44160=
,
> base=3D4, prebuf=3D44032, minreq=3D128 maxrewind=3D0
> D: memblockq.c: memblockq sanitized: maxlength=3D4194304, tlength=3D44160=
,
> base=3D4, prebuf=3D44032, minreq=3D128 maxrewind=3D0
> I: protocol-native.c: Final latency 502.13 ms =3D 497.78 ms + 2*1.45 ms +=
 1.45
> ms
> D: module-alsa-sink.c: latency set to 4.00ms
> D: module-alsa-sink.c: hwbuf_unused_frames=3D1872
> D: module-alsa-sink.c: setting avail_min=3D2225
> D: module-alsa-sink.c: Requesting rewind due to latency change.
> D: module-alsa-sink.c: Requested to rewind 8192 bytes.
> D: module-alsa-sink.c: Limited to 7680 bytes.
> D: module-alsa-sink.c: before: 1920
> D: module-alsa-sink.c: after: 1920
> D: module-alsa-sink.c: Rewound 7680 bytes.
> D: sink.c: Processing rewind...
> D: sink-input.c: Have to rewind 7680 bytes on render memblockq.
> D: module-alsa-sink.c: Wakeup from ALSA! OUTPUT
> I: module-alsa-sink.c: Underrun!
> D: module-alsa-sink.c: Wakeup from ALSA! OUTPUT
> E: module-alsa-sink.c: ALSA woke us up to write new data to the device, b=
ut
> there was actually nothing to write! Most likely this is an ALSA driver b=
ug.
> Please report this issue to the PulseAudio developers.
> D: module-alsa-sink.c: Wakeup from ALSA! OUTPUT
> D: module-alsa-sink.c: Wakeup from ALSA! OUTPUT
>=20
>=20
> 2009/12/19 Chris <cpollock@embarqmail.com>
>=20
> > Mandriva 2010.0, Gnome 2.28, pulseaudio
> > 0.9.19-7mdv2010.0. With pulseaudio enabled in MCC periodically the hd
> > light will constantly be on for a period of 4 or 5 minutes and system w=
ill
> > slow
> > down to a crawl. Also these comments will be in syslog:
> >
> > pulseaudio[4331]: alsa-util.c: snd_pcm_avail() returned a value that is
> > exceptionally large: 349696 bytes (1821 ms).
> > Dec 14 20:26:29 localhost pulseaudio[4331]: alsa-util.c: Most likely th=
is
> > is a
> > bug in the ALSA driver 'snd_via82xx'. Please report this issue to the A=
LSA
> > developers.
> > Dec 14 20:26:29 localhost pulseaudio[4331]: alsa-util.c: snd_pcm_dump()=
:
> > Dec 14 20:26:29 localhost pulseaudio[4331]: alsa-util.c: Hardware PCM c=
ard
> > 1
> > 'VIA 8237' device 0 subdevice 0
> > Dec 14 20:26:29 localhost pulseaudio[4331]: alsa-util.c: Its setup is:
> > Dec 14 20:26:29 localhost pulseaudio[4331]: alsa-util.c:   stream      =
 :
> > PLAYBACK
> > Dec 14 20:26:29 localhost pulseaudio[4331]: alsa-util.c:   access      =
 :
> > MMAP_INTERLEAVED
> > Dec 14 20:26:29 localhost pulseaudio[4331]: alsa-util.c:   format      =
 :
> > S16_LE
> > Dec 14 20:26:29 localhost pulseaudio[4331]: alsa-util.c:   subformat   =
 :
> > STD
> > Dec 14 20:26:29 localhost pulseaudio[4331]: alsa-util.c:   channels    =
 : 2
> > Dec 14 20:26:29 localhost pulseaudio[4331]: alsa-util.c:   rate        =
 :
> > 48000
> > Dec 14 20:26:29 localhost pulseaudio[4331]: alsa-util.c:   exact rate  =
 :
> > 48000
> > (48000/1)
> > Dec 14 20:26:29 localhost pulseaudio[4331]: alsa-util.c:   msbits      =
 :
> > 16
> > Dec 14 20:26:29 localhost pulseaudio[4331]: alsa-util.c:   buffer_size =
 :
> > 16384
> > Dec 14 20:26:29 localhost pulseaudio[4331]: alsa-util.c:   period_size =
 :
> > 8192
> > Dec 14 20:26:29 localhost pulseaudio[4331]: alsa-util.c:   period_time =
 :
> > 170666
> > Dec 14 20:26:29 localhost pulseaudio[4331]: alsa-util.c:   tstamp_mode =
 :
> > ENABLE
> > Dec 14 20:26:29 localhost pulseaudio[4331]: alsa-util.c:   period_step =
 : 1
> > Dec 14 20:26:29 localhost pulseaudio[4331]: alsa-util.c:   avail_min   =
 :
> > 9665
> > Dec 14 20:26:29 localhost pulseaudio[4331]: alsa-util.c:   period_event=
 : 0
> > Dec 14 20:26:29 localhost pulseaudio[4331]: alsa-util.c:   start_thresh=
old
> >  :
> > -1
> > Dec 14 20:26:29 localhost pulseaudio[4331]: alsa-util.c:   stop_thresho=
ld
> > :
> > 1073741824
> > Dec 14 20:26:29 localhost pulseaudio[4331]: alsa-util.c:
> > silence_threshold: 0
> > Dec 14 20:26:29 localhost pulseaudio[4331]: alsa-util.c:   silence_size=
 : 0
> > Dec 14 20:26:29 localhost pulseaudio[4331]: alsa-util.c:   boundary    =
 :
> > 1073741824
> > Dec 14 20:26:29 localhost pulseaudio[4331]: alsa-util.c:   appl_ptr    =
 :
> > 767919576
> > Dec 14 20:26:29 localhost pulseaudio[4331]: alsa-util.c:   hw_ptr      =
 :
> > 767990616
> > Dec 14 20:26:29 localhost pulseaudio[4331]: ratelimit.c: 7 events
> > suppressed
> > Dec 14 20:26:31 localhost pulseaudio[4331]: asyncq.c: q overrun, queuin=
g
> > locally
> >
> > I also see this quite frequently:
> >
> > Dec 14 20:15:29 localhost pulseaudio[4331]: asyncq.c: q overrun, queuin=
g
> > locally
> > Dec 14 20:15:34 localhost pulseaudio[4331]: ratelimit.c: 657 events
> > suppressed
> > Dec 14 20:15:34 localhost pulseaudio[4331]: asyncq.c: q overrun, queuin=
g
> > locally
> > Dec 14 20:15:39 localhost pulseaudio[4331]: ratelimit.c: 2508 events
> > suppressed
> > Dec 14 20:15:39 localhost pulseaudio[4331]: asyncq.c: q overrun, queuin=
g
> > locally
> > Dec 14 20:15:44 localhost pulseaudio[4331]: ratelimit.c: 3530 events
> > suppressed
> > Dec 14 20:15:44 localhost pulseaudio[4331]: asyncq.c: q overrun, queuin=
g
> > locally
> > Dec 14 20:15:44 localhost pulseaudio[4331]: asyncq.c: q overrun, queuin=
g
> > locally
> > Dec 14 20:15:49 localhost pulseaudio[4331]: ratelimit.c: 2672 events
> > suppressed
> > Dec 14 20:15:49 localhost pulseaudio[4331]: asyncq.c: q overrun, queuin=
g
> > locally
> > Dec 14 20:16:05 localhost pulseaudio[4331]: ratelimit.c: 2244 events
> > suppressed
> > Dec 14 20:16:18 localhost pulseaudio[4331]: ratelimit.c: 1 events
> > suppressed
> > Dec 14 20:16:23 localhost pulseaudio[4331]: ratelimit.c: 1 events
> > suppressed
> > Dec 14 20:16:34 localhost pulseaudio[4331]: ratelimit.c: 5 events
> > suppressed
> > Dec 14 20:16:39 localhost pulseaudio[4331]: ratelimit.c: 9 events
> > suppressed
> > Dec 14 20:16:45 localhost pulseaudio[4331]: ratelimit.c: 11 events
> > suppressed
> > Dec 14 20:16:50 localhost pulseaudio[4331]: ratelimit.c: 13 events
> > suppressed
> > Dec 14 20:16:55 localhost pulseaudio[4331]: ratelimit.c: 16 events
> > suppressed
> > Dec 14 20:17:01 localhost pulseaudio[4331]: ratelimit.c: 17 events
> > suppressed
> > Dec 14 20:17:06 localhost pulseaudio[4331]: ratelimit.c: 23 events
> > suppressed
> > Dec 14 20:17:11 localhost pulseaudio[4331]: ratelimit.c: 19 events
> > suppressed
> > Dec 14 20:17:31 localhost pulseaudio[4331]: ratelimit.c: 23 events
> > suppressed
> > Dec 14 20:17:36 localhost pulseaudio[4331]: ratelimit.c: 19 events
> > suppressed
> > Dec 14 20:17:42 localhost pulseaudio[4331]: ratelimit.c: 21 events
> > suppressed
> > Dec 14 20:17:47 localhost pulseaudio[4331]: ratelimit.c: 19 events
> > suppressed
> >
> > I have pulseaudio enabled but have glitch-free mode disabled. Any
> > assistance
> > in troubleshooting this would be appreciated.
> >
> > Chris
> >
Anyway to stop this from happening? When it does happen it's causing my
drive to thrash for about 4-5 minutes or longer as shown below:

Dec 20 14:35:50 localhost pulseaudio[4331]: ratelimit.c: 271 events
suppressed
Dec 20 14:35:50 localhost pulseaudio[4331]: asyncq.c: q overrun, queuing
locally

Dec 20 14:44:15 localhost pulseaudio[4331]: asyncq.c: q overrun, queuing
locally


--=20
KeyID 0xE372A7DA98E6705C


--=-u43Rq1GWF7+qvRNyliNP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAksutiQACgkQ43Kn2pjmcFyGDwCffamDEppiL6411uTHFfg45WLL
noQAnjfqxEX4//pYIwFOoq1CLQHFJZqF
=C1JN
-----END PGP SIGNATURE-----

--=-u43Rq1GWF7+qvRNyliNP--


--===============7212794680239115972==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============7212794680239115972==--
