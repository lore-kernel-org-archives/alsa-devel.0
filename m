From: Abramo Bagnara <abramo.bagnara@libero.it>
Subject: Re: [alsa-cvslog] CVS: alsa-lib/src/pcm pcm.c,1.222,1.223
Date: Wed, 09 Oct 2002 09:06:42 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DA3D582.4161E6F3@libero.it>
References: <E17zA6Z-00073b-00@usw-pr-cvs1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> 
> Update of /cvsroot/alsa/alsa-lib/src/pcm
> In directory usw-pr-cvs1:/tmp/cvs-serv27101
> 
> Modified Files:
>         pcm.c
> Log Message:
> Fixes in documentation for fast status
> 
> Index: pcm.c
> ===================================================================
> RCS file: /cvsroot/alsa/alsa-lib/src/pcm/pcm.c,v
> retrieving revision 1.222
> retrieving revision 1.223
> diff -u -r1.222 -r1.223
> --- pcm.c       21 Sep 2002 19:01:24 -0000      1.222
> +++ pcm.c       9 Oct 2002 06:13:57 -0000       1.223
> @@ -373,16 +373,21 @@
>  parameters - avail_max and overrange are reset to zero after the status
>  call.
> 
> -\subsection pcm_status_fast Obtaining fast device status
> +\subsection pcm_status_fast Obtaining device status fast
> 
>  The function \link ::snd_pcm_avail_update \endlink updates the current
>  available count of samples for writing (playback) or filled samples for
> -reading (capture).
> +reading (capture). It is a light version of
> +\link ::snd_pcm_status_get_avail \endlink, because it does not require
> +the user <-> kernel context switch, but the value is less accurate,
> +because ring buffer pointers are updated in kernel drivers only when
> +an interrupt occurs.
>  <p>

Wrong here:
1) snd_pcm_status_get_avail is only an accessor method
2) snd_pcm_avail_update call is *needed* for chained PCM (to call
snd_pcm_status does not do the needed things).

-- 
Abramo Bagnara                       mailto:abramo.bagnara@libero.it

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
