From: Forest Bond <forest@alittletooquiet.net>
Subject: Re: snd_device_name_hint segfaults
Date: Thu, 27 Jun 2013 10:30:50 -0400
Message-ID: <20130627143050.GK18126@alittletooquiet.net>
References: <20130626183909.GI18126@alittletooquiet.net>
 <s5hvc50xe9x.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8539467977574573678=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from storm.alittletooquiet.net (storm.alittletooquiet.net
 [67.23.28.199]) by alsa0.perex.cz (Postfix) with ESMTP id 106722655E4
 for <alsa-devel@alsa-project.org>; Thu, 27 Jun 2013 16:42:32 +0200 (CEST)
In-Reply-To: <s5hvc50xe9x.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8539467977574573678==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UBnjLfzoMQYIXCvq"
Content-Disposition: inline


--UBnjLfzoMQYIXCvq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

Thanks for the reply.

On Thu, Jun 27, 2013 at 08:23:54AM +0200, Takashi Iwai wrote:
> At Wed, 26 Jun 2013 14:39:09 -0400, Forest Bond wrote:
> > I'm seeing segfaults with VLC similar to those reported here:
> >=20
> >   http://mailman.alsa-project.org/pipermail/alsa-devel/2013-January/059=
168.html
> >=20
> > This is on Ubuntu 12.04 with the latest alsa-lib package (1.0.25-1ubunt=
u10.2)
> > and the following patches also applied:
> >=20
> > * 2cfc8b9b44a8e493c41b3d63d5a00b306a18a5ed
> >   snd_pcm_direct_parse_open_conf(): use thread-safe getgrnam_r()
> > * 44c1a623dd1fc9e831616b663bebc54ca98df994
> >   Add snd_lib_error_set_local() to install a thread-local error handler.
> > * 25dbb102810b31c02358904d70d53c960fb0a10e
> >   snd_device_name_hint(): do not change the global error handler.
> > * f49b2dc522a2564315c76d075203b15a39941e8a
> >   snd_device_name_hint(): do not use global snd_config.
> > * 7f2b2c8c1650a1883b48abfcdb455138943854f9
> >   conf: Fix a memory access violation resulting from improper error pro=
pogation
> >=20
> > So I think there are still issues when calling snd_device_name_hint(-1,=
 ...).
> >=20
> > Here is the backtrace:
> >=20
> > #0  0x003f0e78 in __strcpy_chk () from /lib/i386-linux-gnu/libc.so.6
> > #1  0x0625084b in strcpy (__src=3D0x0, __dest=3D0xb6025e80 "pcm.(null)"=
) at /usr/include/i386-li
> > nux-gnu/bits/string3.h:105
> > #2  try_config (config=3D0xaf1c4df0, list=3D0xb52fe804, base=3D0x323e96=
2 "pcm", name=3D0x0) at nameh
> > int.c:243
> > #3  0x06251bc5 in add_software_devices (list=3D0xb52fe804, config=3D0xa=
f1c4df0) at namehint.c:51
> > 2
> > #4  snd_device_name_hint (card=3D-1, iface=3D<optimized out>, hints=3D0=
xb52fe90c) at namehint.c:59
> > 1
> > #5  0x0323c9bb in GetDevices (obj=3D0xb6271700, item=3D0x0, prefs_dev=
=3D<optimized out>) at alsa.c
> > :721
> > #6  0x0323d4c0 in Probe (dev=3D0xb6011df8 "default", obj=3D0xb6271700) =
at alsa.c:161
> > #7  Open (obj=3D0xb6271700) at alsa.c:539
> > #8  0x0a6c73d0 in generic_start (func=3D0x323cd10, ap=3D0xb52fed98 "\27=
3") at modules/modules.c:422
> > #9  0x0a6c7a3a in vlc_module_load (p_this=3D0xb6271700, psz_capability=
=3D0xa70b959 "audio output", psz_name=3D<optimized out>, b_strict=3Dfalse,
> >     probe=3D0xa6c73c0 <generic_start>) at modules/modules.c:347
> > #10 0x0a6c8002 in module_need (obj=3D0xb6271700, cap=3D0xa70b959 "audio=
 output", name=3D0xa70d2bd "$aout", strict=3Dfalse) at modules/modules.c:437
> > #11 0x0a6b1242 in aout_OutputNew (p_aout=3D0xb6271700, p_format=3D0xb52=
feeac) at audio_output/output.c:59
> > #12 0x0a6ad77f in aout_DecNew (p_aout=3D0xb6271700, p_format=3D0xb52fee=
ac, p_replay_gain=3D0xaef02a14, p_request_vout=3D0xb52feed0)
> >     at audio_output/dec.c:112
> > #13 0x0a67066e in aout_new_buffer (p_dec=3D0xaef02870, i_samples=3D1024=
) at input/decoder.c:2286
> > #14 0x0a672690 in decoder_NewAudioBuffer (p_decoder=3D0xaef02870, i_siz=
e=3D1024) at input/decoder.c:213
> > #15 0x04032f8c in DecodeBlock (p_dec=3D0xaef02870, pp_block=3D0xb52ff05=
c) at faad.c:464
> > #16 0x0a670891 in DecoderDecodeAudio (p_dec=3D0xaef02870, p_block=3D0xa=
ef03000) at input/decoder.c:1291
> > #17 0x0a6716f5 in DecoderProcessAudio (b_flush=3Dfalse, p_block=3D0xaef=
03000, p_dec=3D0xaef02870) at input/decoder.c:1936
> > #18 DecoderProcess (p_dec=3D0xaef02870, p_block=3D<optimized out>) at i=
nput/decoder.c:2059
> > #19 0x0a671959 in DecoderThread (p_data=3D0xaef02870) at input/decoder.=
c:938
> > #20 0x001fbd4c in start_thread () from /lib/i386-linux-gnu/libpthread.s=
o.0
> > #21 0x003ddace in clone () from /lib/i386-linux-gnu/libc.so.6
> >=20
> > As a work around I will probably patch VLC to not call snd_device_name_=
hint this
> > way.  I see this has been done for other applications:
> >=20
> > http://code.google.com/p/chromium/issues/detail?id=3D95797
> > http://code.mythtv.org/trac/ticket/10809
> >=20
> > But I wanted to try diagnosing the issue first.  Thoughts?
>=20
> This isn't necessarily a bug due to the race like the previous case,
> but rather more simple one.  For example, try the patch below.
>=20
> If this fixes, the question is how to trigger.  Do you have any your
> own ~/.asoundrc or /etc/asound.conf?  If yes, removing it changes the
> behavior?

Hm.  I haven't tried your patch yet although I suspect that it would in fac=
t fix
the crash.  But I don't think the problem is that simple.  I don't have a
=2Easoundrc or /etc/asound.conf configuration file.  And the crashes don't =
happen
consistently on every run.  In fact it usually takes a few hours of VLC sta=
rts
and stops to see the problem at all.

But I have a new theory.  VLC should be using PulseAudio anyway, so I start=
ed
probing to figure out why it's initializing ALSA in the first place.  Turns=
 out
it will only do this when the PulseAudio module fails to initialize.  One c=
ase
in which this happens is if PA is terminating at the same time VLC is start=
ing.
I can manually trigger this by doing "pulseaudio -k && vlc ...".

You are probably aware that PA will automatically exit after being idle for=
 some
time.  I think we are playing media files on a schedule that happens to tri=
gger
this scenario.  So VLC starts up just as PA is quitting, and then the ALSA
module tries to enumerate available devices.  What if some of the available
devices disappear during enumeration i.e. the PulseAudio ALSA plugin is
destroying its ALSA devices?  Could that lead to this segfault?

Thanks,
Forest
--=20
Forest Bond
http://www.alittletooquiet.net
http://www.rapidrollout.com

--UBnjLfzoMQYIXCvq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlHMTJoACgkQRO4fQQdv5AxeFACcCoFdu7C3H0OjcaKbLwpRGlsm
z+AAoJuy0H2itr2M4kzIVtQw0WukYj28
=ZGPJ
-----END PGP SIGNATURE-----

--UBnjLfzoMQYIXCvq--

--===============8539467977574573678==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8539467977574573678==--
