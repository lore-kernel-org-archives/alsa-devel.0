From: Forest Bond <forest@forestbond.com>
Subject: Re: snd_device_name_hint segfaults
Date: Thu, 3 Oct 2013 14:36:23 -0400
Message-ID: <20131003183623.GB29746@alittletooquiet.net>
References: <20130626183909.GI18126@alittletooquiet.net>
 <s5hvc50xe9x.wl%tiwai@suse.de>
 <20130627143050.GK18126@alittletooquiet.net>
 <s5hli5voapl.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7045360405149369524=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from storm.alittletooquiet.net (storm.alittletooquiet.net
 [67.23.28.199]) by alsa0.perex.cz (Postfix) with ESMTP id 8D3B526158B
 for <alsa-devel@alsa-project.org>; Thu,  3 Oct 2013 20:51:36 +0200 (CEST)
In-Reply-To: <s5hli5voapl.wl%tiwai@suse.de>
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


--===============7045360405149369524==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K8nIJk4ghYZn606h"
Content-Disposition: inline


--K8nIJk4ghYZn606h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

On Thu, Jun 27, 2013 at 05:05:42PM +0200, Takashi Iwai wrote:
> At Thu, 27 Jun 2013 10:30:50 -0400,
> Forest Bond wrote:
> >=20
> > Hi Takashi,
> >=20
> > Thanks for the reply.
> >=20
> > On Thu, Jun 27, 2013 at 08:23:54AM +0200, Takashi Iwai wrote:
> > > At Wed, 26 Jun 2013 14:39:09 -0400, Forest Bond wrote:
> > > > I'm seeing segfaults with VLC similar to those reported here:
> > > >=20
> > > >   http://mailman.alsa-project.org/pipermail/alsa-devel/2013-January=
/059168.html
> > > >=20
> > > > This is on Ubuntu 12.04 with the latest alsa-lib package (1.0.25-1u=
buntu10.2)
> > > > and the following patches also applied:
> > > >=20
> > > > * 2cfc8b9b44a8e493c41b3d63d5a00b306a18a5ed
> > > >   snd_pcm_direct_parse_open_conf(): use thread-safe getgrnam_r()
> > > > * 44c1a623dd1fc9e831616b663bebc54ca98df994
> > > >   Add snd_lib_error_set_local() to install a thread-local error han=
dler.
> > > > * 25dbb102810b31c02358904d70d53c960fb0a10e
> > > >   snd_device_name_hint(): do not change the global error handler.
> > > > * f49b2dc522a2564315c76d075203b15a39941e8a
> > > >   snd_device_name_hint(): do not use global snd_config.
> > > > * 7f2b2c8c1650a1883b48abfcdb455138943854f9
> > > >   conf: Fix a memory access violation resulting from improper error=
 propogation
> > > >=20
> > > > So I think there are still issues when calling snd_device_name_hint=
(-1, ...).
> > > >=20
> > > > Here is the backtrace:
> > > >=20
> > > > #0  0x003f0e78 in __strcpy_chk () from /lib/i386-linux-gnu/libc.so.6
> > > > #1  0x0625084b in strcpy (__src=3D0x0, __dest=3D0xb6025e80 "pcm.(nu=
ll)") at /usr/include/i386-li
> > > > nux-gnu/bits/string3.h:105
> > > > #2  try_config (config=3D0xaf1c4df0, list=3D0xb52fe804, base=3D0x32=
3e962 "pcm", name=3D0x0) at nameh
> > > > int.c:243
> > > > #3  0x06251bc5 in add_software_devices (list=3D0xb52fe804, config=
=3D0xaf1c4df0) at namehint.c:51
> > > > 2
> > > > #4  snd_device_name_hint (card=3D-1, iface=3D<optimized out>, hints=
=3D0xb52fe90c) at namehint.c:59
> > > > 1
> > > > #5  0x0323c9bb in GetDevices (obj=3D0xb6271700, item=3D0x0, prefs_d=
ev=3D<optimized out>) at alsa.c
> > > > :721
> > > > #6  0x0323d4c0 in Probe (dev=3D0xb6011df8 "default", obj=3D0xb62717=
00) at alsa.c:161
> > > > #7  Open (obj=3D0xb6271700) at alsa.c:539
> > > > #8  0x0a6c73d0 in generic_start (func=3D0x323cd10, ap=3D0xb52fed98 =
"\273") at modules/modules.c:422
> > > > #9  0x0a6c7a3a in vlc_module_load (p_this=3D0xb6271700, psz_capabil=
ity=3D0xa70b959 "audio output", psz_name=3D<optimized out>, b_strict=3Dfals=
e,
> > > >     probe=3D0xa6c73c0 <generic_start>) at modules/modules.c:347
> > > > #10 0x0a6c8002 in module_need (obj=3D0xb6271700, cap=3D0xa70b959 "a=
udio output", name=3D0xa70d2bd "$aout", strict=3Dfalse) at modules/modules.=
c:437
> > > > #11 0x0a6b1242 in aout_OutputNew (p_aout=3D0xb6271700, p_format=3D0=
xb52feeac) at audio_output/output.c:59
> > > > #12 0x0a6ad77f in aout_DecNew (p_aout=3D0xb6271700, p_format=3D0xb5=
2feeac, p_replay_gain=3D0xaef02a14, p_request_vout=3D0xb52feed0)
> > > >     at audio_output/dec.c:112
> > > > #13 0x0a67066e in aout_new_buffer (p_dec=3D0xaef02870, i_samples=3D=
1024) at input/decoder.c:2286
> > > > #14 0x0a672690 in decoder_NewAudioBuffer (p_decoder=3D0xaef02870, i=
_size=3D1024) at input/decoder.c:213
> > > > #15 0x04032f8c in DecodeBlock (p_dec=3D0xaef02870, pp_block=3D0xb52=
ff05c) at faad.c:464
> > > > #16 0x0a670891 in DecoderDecodeAudio (p_dec=3D0xaef02870, p_block=
=3D0xaef03000) at input/decoder.c:1291
> > > > #17 0x0a6716f5 in DecoderProcessAudio (b_flush=3Dfalse, p_block=3D0=
xaef03000, p_dec=3D0xaef02870) at input/decoder.c:1936
> > > > #18 DecoderProcess (p_dec=3D0xaef02870, p_block=3D<optimized out>) =
at input/decoder.c:2059
> > > > #19 0x0a671959 in DecoderThread (p_data=3D0xaef02870) at input/deco=
der.c:938
> > > > #20 0x001fbd4c in start_thread () from /lib/i386-linux-gnu/libpthre=
ad.so.0
> > > > #21 0x003ddace in clone () from /lib/i386-linux-gnu/libc.so.6
> > > >=20
> > > > As a work around I will probably patch VLC to not call snd_device_n=
ame_hint this
> > > > way.  I see this has been done for other applications:
> > > >=20
> > > > http://code.google.com/p/chromium/issues/detail?id=3D95797
> > > > http://code.mythtv.org/trac/ticket/10809
> > > >=20
> > > > But I wanted to try diagnosing the issue first.  Thoughts?
> > >=20
> > > This isn't necessarily a bug due to the race like the previous case,
> > > but rather more simple one.  For example, try the patch below.
> > >=20
> > > If this fixes, the question is how to trigger.  Do you have any your
> > > own ~/.asoundrc or /etc/asound.conf?  If yes, removing it changes the
> > > behavior?
> >=20
> > Hm.  I haven't tried your patch yet although I suspect that it would in=
 fact fix
> > the crash.  But I don't think the problem is that simple.  I don't have=
 a
> > .asoundrc or /etc/asound.conf configuration file.  And the crashes don'=
t happen
> > consistently on every run.  In fact it usually takes a few hours of VLC=
 starts
> > and stops to see the problem at all.
>=20
> Ah, OK, this information was missing.
> In anyway, it'd be good if you can see how the whole config tree in
> memory looks when the segfault occurs.  The NULL pointer alone doesn't
> mean a memory corruption like the previous case.  We need a bit more
> overview.
>=20
> > But I have a new theory.  VLC should be using PulseAudio anyway, so I s=
tarted
> > probing to figure out why it's initializing ALSA in the first place.  T=
urns out
> > it will only do this when the PulseAudio module fails to initialize.  O=
ne case
> > in which this happens is if PA is terminating at the same time VLC is s=
tarting.
> > I can manually trigger this by doing "pulseaudio -k && vlc ...".
> >=20
> > You are probably aware that PA will automatically exit after being idle=
 for some
> > time.  I think we are playing media files on a schedule that happens to=
 trigger
> > this scenario.  So VLC starts up just as PA is quitting, and then the A=
LSA
> > module tries to enumerate available devices.  What if some of the avail=
able
> > devices disappear during enumeration i.e. the PulseAudio ALSA plugin is
> > destroying its ALSA devices?  Could that lead to this segfault?
>=20
> In general, the configuration space itself should be static,
> determined at the loading time.

I've been meaning to follow up on this issue for a while.  Sorry for the de=
layed
report.  We disabled PulseAudio idle exit and the problem went away, so it =
does
appear to be related somehow.

Thanks,
Forest
--=20
Forest Bond
http://www.forestbond.com
http://www.rapidrollout.com

--K8nIJk4ghYZn606h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlJNuScACgkQRO4fQQdv5Az/aACg0DmcvpGMWosI+nwkxhPsbbFC
wg8An0vPOj2PKLFjafKHDljM4MlKPsfw
=LDFK
-----END PGP SIGNATURE-----

--K8nIJk4ghYZn606h--

--===============7045360405149369524==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7045360405149369524==--
