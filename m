From: Abramo Bagnara <abramo.bagnara@libero.it>
Subject: Re: [alsa-cvslog] CVS: alsa-kernel/core pcm_lib.c,1.20,1.21
Date: Wed, 30 Oct 2002 20:45:11 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DC036C7.79DB33E6@libero.it>
References: <E186xKi-0003hi-00@usw-pr-cvs1.sourceforge.net>
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
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> 
> Update of /cvsroot/alsa/alsa-kernel/core
> In directory usw-pr-cvs1:/tmp/cvs-serv13506
> 
> Modified Files:
>         pcm_lib.c
> Log Message:
> fixed the infinite loop at capture-draining on oss-emulation.
> 
> Index: pcm_lib.c
> ===================================================================
> RCS file: /cvsroot/alsa/alsa-kernel/core/pcm_lib.c,v
> retrieving revision 1.20
> retrieving revision 1.21
> diff -u -r1.20 -r1.21
> --- pcm_lib.c   12 Oct 2002 14:38:42 -0000      1.20
> +++ pcm_lib.c   30 Oct 2002 18:12:46 -0000      1.21
> @@ -2138,7 +2138,7 @@
>                 snd_pcm_uframes_t frames, appl_ptr, appl_ofs;
>                 snd_pcm_uframes_t avail;
>                 snd_pcm_uframes_t cont;
> -               if (runtime->sleep_min == 0 && runtime->status->state == SNDRV_PCM_STATE_RUNNING)
> +               if (runtime->sleep_min == 0 && (runtime->status->state == SNDRV_PCM_STATE_RUNNING || runtime->status->state == SNDRV_PCM_STATE_DRAINING))
>                         snd_pcm_update_hw_ptr(substream);
>                 avail = snd_pcm_capture_avail(runtime);
>                 if (runtime->status->state == SNDRV_PCM_STATE_DRAINING) {

What are you trying to do here?

What's the reason to call snd_pcm_update_hw_ptr when PCM is not running?


-- 
Abramo Bagnara                       mailto:abramo.bagnara@libero.it

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy


-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0004en
