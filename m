From: "David E. Storey" <dave@tamos.net>
Subject: Re: dmix plugin problems -- Resend
Date: 26 May 2003 19:48:30 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1053992910.1404.7.camel@localhost>
References: <200305261528.32421.n8gray@caltech.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-IVb9tSoKs1EUDpMHpHGa"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200305261528.32421.n8gray@caltech.edu>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Nathaniel Gray <n8gray@caltech.edu>
Cc: alsa <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--=-IVb9tSoKs1EUDpMHpHGa
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

nice. Your config just helped me make it work for me. I too have an
intel8x0. (I also have some other gear, but in essence I can use
alsaplayer and xmms on my intel8x0 simultaneously.) Not being an expert
in .asound voodoo, I would say that yours is a bit more complicated than
it needs to be. Without changing your .asound file, have you tried:

aplay -D mydmix test.wav

?

The only other difference is that I don't have rate 44100. It is my
understanding that the intel8x0 is locked at 48000 for the hardware I
have. My only gripe with dmix now is normalization. All the music I have
is normalized and when I sum that up, it distorts, so I have to be
careful. Also, jack doesn't like dmix. For starters, dmix is for
playback only. Would be nice to be able to create a composite device
that had dmix and dsnoop.... wait... that's jack! ;-)

d!

On Mon, 2003-05-26 at 18:28, Nathaniel Gray wrote:
> I'm sending this again since I got no response the first time and dmix=20
> does not appear to be under heavy development, despite how incredibly=20
> useful it would be if it worked.
>=20
> [n8gray@golux alsa-lib-0.9.3]$ cat /proc/asound/version
> Advanced Linux Sound Architecture Driver Version 0.9.3a.
> Compiled on May  9 2003 for kernel 2.4.21-0.16mm-mdkcustom.
> Using alsa-libs 0.9.3.
>=20
> The dmix plugin seems to be very unreliable, or else maybe I'm not=20
> setting it up correctly.  Here's my asoundrc:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D .asoundrc =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> pcm.intel8x0 {
>    type hw
>    card 0
> }
>=20
> ctl.intel8x0 {
>    type hw
>    card 0
> }
>=20
> pcm.mydmix {
>     type dmix
>     ipc_key 12349
>     ipc_key_add_uid true
>     slave {
>         pcm "hw:0,0"
>         # Setting this rate to 44100 seems to help
>         rate 44100
>     }
> }
>=20
> ctl.mydmix {
>     type hw
>     card 0
> }
>=20
> pcm.mixed {
>     type plug
>     slave {
>        pcm mydmix
>     }
> }
>=20
> ctl.mixed {
>     type hw
>     card 0
> }
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> If I run this command nothing happens:
> [n8gray@golux sounds]$ aplay -D mixed KDE_Beep_ClockChime.wav
> Playing WAVE 'KDE_Beep_ClockChime.wav' : Unsigned 8 bit, Rate 7418 Hz,=20
> Mono
>=20
> I get no sound, no error, aplay uses no cpu time.  Here's the tail end=20
> of the same command under strace:
> open("KDE_Beep_ClockChime.wav", O_RDONLY) =3D 5
> read(5, "RIFF\256\17\0\0WAVEfmt \20\0\0\0\1\0\1\0", 24) =3D 24
> read(5, "\372\34", 2)                   =3D 2
> read(5, "\0\0\372\34\0\0\1\0\10\0", 10) =3D 10
> read(5, "data\212\17\0\0", 8)           =3D 8
> write(2, "Playing WAVE \'KDE_Beep_ClockChim"..., 41Playing WAVE=20
> 'KDE_Beep_ClockChime.wav' : ) =3D 41
> write(2, "Unsigned 8 bit, ", 16Unsigned 8 bit, )        =3D 16
> write(2, "Rate 7418 Hz, ", 14Rate 7418 Hz, )          =3D 14
> write(2, "Mono", 4Mono)                     =3D 4
> write(2, "\n", 1
> )                       =3D 1
> shmget(IPC_PRIVATE, 49152, 0x1b6|0666)  =3D 10747908
> shmat(10747908, 0, 0)                   =3D 0x40274000
> shmget(IPC_PRIVATE, 12288, 0x1b6|0666)  =3D 10780677
> shmat(10780677, 0, 0)                   =3D 0x40023000
> read(5, "G\214j\313\267hqG\234\250Yn;\206\274[e=3Dt\305\207\217FM"...,=20
> 927) =3D 927
> read(5, "\206\177U\217\214\207\211S\201\215\211\231[p\204\201\242"...,=20
> 927) =3D 927
> poll([at this point the program just hangs]
>=20
> If I run this command it completes but I get no sound output:
> [n8gray@golux sounds]$ aplay -D mixed pop.wav
> Playing WAVE 'pop.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,=20
> Mono
>=20
> The same file plays properly (with sound) if I leave out the "-D mixed"=20
> flag.  This command, however, works perfectly:
> [n8gray@golux sounds]$ aplay -D mixed info.wav
> Playing WAVE 'info.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,=20
> Mono
>=20
> If I actually try to mix two streams, though, I get xruns and cracks in=20
> the sound:
> [n8gray@golux sounds]$ aplay -D mixed info.wav & aplay -D mixed info.wav
> [1] 12952
> Playing WAVE 'info.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,=20
> Mono
> Playing WAVE 'info.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,=20
> Mono
> xrun!!! (at least 0.030 ms long)
> xrun!!! (at least 0.008 ms long)
> [1]+  Done                    aplay -D mixed info.wav
>=20
> I've tried this experiment with long sounds to try to eliminate any=20
> startup inefficiency, but the cracks last as long as the streams are=20
> being mixed.
>=20
> I'll be glad to help debug in any way I can.  I've tried using the C=20
> versions of mix_areas1 and mix_areas2 and it doesn't help any of these=20
> problems.
>=20
> Thanks,
> -Nathan

--=-IVb9tSoKs1EUDpMHpHGa
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+0qfO+5sC2muyxOMRAvfnAJ9DfslICt+cZ1Ag2kUYAzYHRIWZCwCfQVa4
BVieKEmBQP4FurYqbC6vpVw=
=dfLI
-----END PGP SIGNATURE-----

--=-IVb9tSoKs1EUDpMHpHGa--



-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
