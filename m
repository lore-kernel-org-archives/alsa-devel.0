From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: configuration space never flattened? Bug?
Date: Fri, 30 Apr 2004 11:41:09 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0404301138460.5787-100000@studcom.urz.uni-halle.de>
References: <Pine.LNX.4.56-Maildir.0404292133320.7156@yme.midgardsormen.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <Pine.LNX.4.56-Maildir.0404292133320.7156@yme.midgardsormen.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: =?ISO-8859-1?Q?Erik_Inge_Bols=F8?= <knan@mo.himolde.no>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Erik Inge Bols=F8 wrote:
> I'm having trouble doing snd_pcm_hw_params_can_pause() on a certain=
 pcm,
> even though it has already (hopefully?) been fixed to one config by
> snd_pcm_hw_params()... snd_pcm_hw_params has been called, at least.=
 How
> can I check?
>
> fileja {
>         type file
>         file /tmp/alsa
>         slave.pcm null
> }
>
> xine: pcm.c:2604: snd_pcm_hw_params_can_pause: Assertion `params &&=
 params->info !=3D ~0U' failed.

Apparently, the null pcm doesn't initialize params->info.

The patch below should help.


HTH
Clemens

--=20
Index: alsa-lib/src/pcm/pcm_null.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
RCS file: /cvsroot/alsa/alsa-lib/src/pcm/pcm_null.c,v
retrieving revision 1.50
diff -u -r1.50 pcm_null.c
--- alsa-lib/src/pcm/pcm_null.c=0917 Mar 2004 11:48:15 -0000=091.50
+++ alsa-lib/src/pcm/pcm_null.c=0930 Apr 2004 09:38:09 -0000
@@ -276,6 +276,9 @@
 {
 =09int err =3D snd_pcm_hw_refine_soft(pcm, params);
 =09params->fifo_size =3D 0;
+=09params->info =3D SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID =
|
+=09=09       SNDRV_PCM_INFO_INTERLEAVED |
+=09=09       SNDRV_PCM_INFO_RESUME | SNDRV_PCM_INFO_PAUSE;
 =09return err;
 }






-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
