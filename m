From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [PATCH] GUS PCM fixes
Date: Fri, 10 May 2002 10:07:01 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0205101005490.1149-100000@pnote.perex-int.cz>
References: <20020510042042.A8147@sci.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20020510042042.A8147@sci.fi>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: =?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 10 May 2002, [iso-8859-1] Ville Syrj=E4l=E4 wrote:

> Here's a fix for gus pcm rate limits and interwave pcm name.
>=20
> Index: alsa-kernel/isa/gus/gus_pcm.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> RCS file: /cvsroot/alsa/alsa-kernel/isa/gus/gus_pcm.c,v
> retrieving revision 1.8
> diff -u -r1.8 gus_pcm.c
> --- alsa-kernel/isa/gus/gus_pcm.c=0918 Feb 2002 13:21:15 -0000
> 1.8
> +++ alsa-kernel/isa/gus/gus_pcm.c=0910 May 2002 01:13:43 -0000
> @@ -38,7 +38,7 @@
> =20
>  /* maximum rate */
> =20
> -#define SNDRV_GF1_PCM_RATE=09=0948000
> +#define SNDRV_GF1_PCM_RATE=09=0944100

There is no reason to limit playback to 44100Hz. Hardware can do frequency=
=20
shift and interleaving, so although DAC operates at 44100Hz, the 48kHz=20
sound can be played.

=09=09=09=09=09=09Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com


_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
