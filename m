From: "M. Ritscher" <mr203010spam@gmx.net>
Subject: libasound dies on snd_pcm_open
Date: Tue, 11 Feb 2003 21:47:37 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200302112147.45539.mr203010spam@gmx.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Description: clearsigned data
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi!

Hope, this isn't a too stupid question...

I've got a problem whilst trying to port my application to the ALSA API.

=46ollowing piece of code gives me an error when executed:

=2D ----------
if ((rc =3D snd_pcm_open (&capture_handle, sDevice.ascii(),
                          SND_PCM_STREAM_CAPTURE, SND_PCM_NONBLOCK)) < 0) {
      std::cerr << "cannot open audio device" << sDevice << snd_strerror (r=
c);
      return rc;
}

Definitions:

QString sDevice;
snd_pcm_t *capture_handle;

=2D ----------

Stopped due to library event.

The stack trace gives me the following:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
0x4000a760 in _dl_debug_state () from /lib/ld-linux.so.2=20
0x4099deb2 in _dl_open_worker () from /lib/libc.so.6=20
0x40009f96 in _dl_catch_error () from /lib/ld-linux.so.2
0x40e9elf5 in _dl_open () from /llb/lilic.so.6
0x404a4et9 in dlopen_doit () from /lib/libdl.so.2=20
0x4000ffl6 in _dl_catch_error () from /iib/Id-linux,so.2
0x404a52f4 in _dlerror_run () from /lib/libdl.so.2=20
0x404a4f44 in dlopen@@GLIBC_2.1 () from /lib/libdl.so.2=20
0x400496cd in snd_dlopen () from /usr/lib/libasound.so.2=20
0x40043764 in snd_config_hooks_call () from /usr/lib/libasound.so.2
0x400439d6 in snd_contig_hooks () from lusr/lib/libasound.so.2=20
0x40044387 in snd_config_update_r () from /usr/lib/libasound.so.2=20
0x40044918 in snd_config_update () from /usr/lib/libasound.so.2=20
0x4005d16d in snd_pcm_open() from /usr/lib/libasound.so.2=20
0x08056505 in KCorrView::openALSADevice() (this=3DOx80e5f1 0) at=20
kconview.cpp:579
0x0805585c in KCorrView::openDevice () (this=3DOx6095f1 0) at kcorrview.cpp=
:334=20
0x080564c9 in KCoaView::resume () (thls=3DOx80e5f1 0) at kcorrview.cpp:571=
=20
0x0805a301 in KCorrMeter (this=3DOx80d1328, parent=3DOx0, name--0x0) at=20
kcorrmeter.cpp:39
0x0805abec in main (argc=3Dl, argv=3DOxbfff1414) at main.cpp:49=20
0x40dbf4a2 in __libc_start_main () from /lib/libc.so.6
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D

(SuSE 8.1, kernel 2.4.19, alsa 0.9 rc7)

I don't really know where to start looking.=20

Even more strange, it was working but failed later with a broken pipe
=2D ---------------------------------------------------------
long rc =3D snd_pcm_readi (capture_handle, sBuf, 128);
=2D ---------------------------------------------------------
And I havn't touched the  openALSADevice(), honestly!=20

Any pointers welcome.

Cheers,

Meinhard
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE+SWFpv2LRaMHePXMRAgRiAKCAbxpz4QjHBIpxboreEgddJhR/qACg6cPX
GjMDuYFio5VXtgkQKB/jMF8=3D
=3DALyd
=2D----END PGP SIGNATURE-----



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
