From: Forest Bond <forest@alittletooquiet.net>
Subject: snd_device_name_hint segfaults
Date: Wed, 26 Jun 2013 14:39:09 -0400
Message-ID: <20130626183909.GI18126@alittletooquiet.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4250579076951112840=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from storm.alittletooquiet.net (storm.alittletooquiet.net
 [67.23.28.199]) by alsa0.perex.cz (Postfix) with ESMTP id 8C62626163B
 for <alsa-devel@alsa-project.org>; Wed, 26 Jun 2013 20:50:48 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============4250579076951112840==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RpqchZ26BWispMcB"
Content-Disposition: inline


--RpqchZ26BWispMcB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I'm seeing segfaults with VLC similar to those reported here:

  http://mailman.alsa-project.org/pipermail/alsa-devel/2013-January/059168.=
html

This is on Ubuntu 12.04 with the latest alsa-lib package (1.0.25-1ubuntu10.=
2)
and the following patches also applied:

* 2cfc8b9b44a8e493c41b3d63d5a00b306a18a5ed
  snd_pcm_direct_parse_open_conf(): use thread-safe getgrnam_r()
* 44c1a623dd1fc9e831616b663bebc54ca98df994
  Add snd_lib_error_set_local() to install a thread-local error handler.
* 25dbb102810b31c02358904d70d53c960fb0a10e
  snd_device_name_hint(): do not change the global error handler.
* f49b2dc522a2564315c76d075203b15a39941e8a
  snd_device_name_hint(): do not use global snd_config.
* 7f2b2c8c1650a1883b48abfcdb455138943854f9
  conf: Fix a memory access violation resulting from improper error propoga=
tion

So I think there are still issues when calling snd_device_name_hint(-1, ...=
).

Here is the backtrace:

#0  0x003f0e78 in __strcpy_chk () from /lib/i386-linux-gnu/libc.so.6
#1  0x0625084b in strcpy (__src=3D0x0, __dest=3D0xb6025e80 "pcm.(null)") at=
 /usr/include/i386-li
nux-gnu/bits/string3.h:105
#2  try_config (config=3D0xaf1c4df0, list=3D0xb52fe804, base=3D0x323e962 "p=
cm", name=3D0x0) at nameh
int.c:243
#3  0x06251bc5 in add_software_devices (list=3D0xb52fe804, config=3D0xaf1c4=
df0) at namehint.c:51
2
#4  snd_device_name_hint (card=3D-1, iface=3D<optimized out>, hints=3D0xb52=
fe90c) at namehint.c:59
1
#5  0x0323c9bb in GetDevices (obj=3D0xb6271700, item=3D0x0, prefs_dev=3D<op=
timized out>) at alsa.c
:721
#6  0x0323d4c0 in Probe (dev=3D0xb6011df8 "default", obj=3D0xb6271700) at a=
lsa.c:161
#7  Open (obj=3D0xb6271700) at alsa.c:539
#8  0x0a6c73d0 in generic_start (func=3D0x323cd10, ap=3D0xb52fed98 "\273") =
at modules/modules.c:422
#9  0x0a6c7a3a in vlc_module_load (p_this=3D0xb6271700, psz_capability=3D0x=
a70b959 "audio output", psz_name=3D<optimized out>, b_strict=3Dfalse,
    probe=3D0xa6c73c0 <generic_start>) at modules/modules.c:347
#10 0x0a6c8002 in module_need (obj=3D0xb6271700, cap=3D0xa70b959 "audio out=
put", name=3D0xa70d2bd "$aout", strict=3Dfalse) at modules/modules.c:437
#11 0x0a6b1242 in aout_OutputNew (p_aout=3D0xb6271700, p_format=3D0xb52feea=
c) at audio_output/output.c:59
#12 0x0a6ad77f in aout_DecNew (p_aout=3D0xb6271700, p_format=3D0xb52feeac, =
p_replay_gain=3D0xaef02a14, p_request_vout=3D0xb52feed0)
    at audio_output/dec.c:112
#13 0x0a67066e in aout_new_buffer (p_dec=3D0xaef02870, i_samples=3D1024) at=
 input/decoder.c:2286
#14 0x0a672690 in decoder_NewAudioBuffer (p_decoder=3D0xaef02870, i_size=3D=
1024) at input/decoder.c:213
#15 0x04032f8c in DecodeBlock (p_dec=3D0xaef02870, pp_block=3D0xb52ff05c) a=
t faad.c:464
#16 0x0a670891 in DecoderDecodeAudio (p_dec=3D0xaef02870, p_block=3D0xaef03=
000) at input/decoder.c:1291
#17 0x0a6716f5 in DecoderProcessAudio (b_flush=3Dfalse, p_block=3D0xaef0300=
0, p_dec=3D0xaef02870) at input/decoder.c:1936
#18 DecoderProcess (p_dec=3D0xaef02870, p_block=3D<optimized out>) at input=
/decoder.c:2059
#19 0x0a671959 in DecoderThread (p_data=3D0xaef02870) at input/decoder.c:938
#20 0x001fbd4c in start_thread () from /lib/i386-linux-gnu/libpthread.so.0
#21 0x003ddace in clone () from /lib/i386-linux-gnu/libc.so.6

As a work around I will probably patch VLC to not call snd_device_name_hint=
 this
way.  I see this has been done for other applications:

http://code.google.com/p/chromium/issues/detail?id=3D95797
http://code.mythtv.org/trac/ticket/10809

But I wanted to try diagnosing the issue first.  Thoughts?

Thanks,
Forest
--=20
Forest Bond
http://www.alittletooquiet.net
http://www.rapidrollout.com

--RpqchZ26BWispMcB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlHLNU0ACgkQRO4fQQdv5AxMJwCeJiFE4ge8x085PCrDoRZDXEl6
D10AoNG2cG0Pt6ESAR63Zm/5xsClHV2b
=qIFB
-----END PGP SIGNATURE-----

--RpqchZ26BWispMcB--

--===============4250579076951112840==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4250579076951112840==--
