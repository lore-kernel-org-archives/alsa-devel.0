From: "M. Ritscher" <mr203010spam@gmx.net>
Subject: Re: libasound dies on snd_pcm_open
Date: Wed, 12 Feb 2003 18:48:12 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200302121848.23717.mr203010spam@gmx.net>
References: <200302112147.45539.mr203010spam@gmx.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200302112147.45539.mr203010spam@gmx.net>
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

Hi again,

On Tuesday 11 February 2003 21:47, M. Ritscher wrote:
> Stopped due to shared library event.
>
I've now compiled a version of libasound with debug enabled and found out t=
hat=20
it dies on me on line 61 of dlmisc.c
Stopped due to shared library event.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
void *snd_dlopen(const char *name, int mode)
{
<cut>
###>>>	return dlopen(name, mode);
}
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

name: "/usr/lib/libasound.so.2 (which correctly links to libasound.so.2.0.0)
mode: 2

I've played around with my code a bit and have tried to reduce it to a=20
minimum, still, no luck.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
int KCorrView::openNewALSADev(){
 snd_pcm_t *capture_hd;
 int err =3D 0;
=20
 if ((err =3D snd_pcm_open(&capture_hd,=20
         "hwplug:0,0", SND_PCM_STREAM_CAPTURE, 0)) < 0) {
   return err;
 }
return err;
}
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Am I missing the obvious?=20

Any help really appreciated.

Thanks,

Meinhard
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE+Sojjv2LRaMHePXMRAmGiAJ99ACyZBFcUXIJogUObV2ZxJkH2/gCeMqIu
MuESBrYRINM20GAoMx2CMH0=3D
=3DXHOX
=2D----END PGP SIGNATURE-----



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
