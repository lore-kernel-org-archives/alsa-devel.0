From: Thierry Vignaud <tvignaud@mandriva.com>
Subject: Re: [alsa-cvslog] alsa-lib: Fix the state in
	snd_pcm_ioplug_pause()
Date: Mon, 25 Feb 2008 16:29:51 +0100
Message-ID: <m2ablpyryo.fsf@vador.mandriva.com>
References: <ALOGGER1203948542.59@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.mandriva.com (mx1.mandriva.com [212.85.150.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 05C0424371
	for <alsa-devel@alsa-project.org>; Mon, 25 Feb 2008 16:30:00 +0100 (CET)
In-Reply-To: <ALOGGER1203948542.59@alsa-project.org> (Takashi Iwai's message
	of "Mon\, 25 Feb 2008 15\:09\:02 +0100 \(CET\)")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai@suse.de> writes:

> changeset:   2423:7388ad3d21ea
> tag:         tip
> user:        tiwai
> date:        Mon Feb 25 15:11:46 2008 +0100
> files:       src/pcm/pcm_ioplug.c
> description:
> Fix the state in snd_pcm_ioplug_pause()
> 
> The states[] in snd_pcm_ioplug_pause() has wrong values.  They should be
> swapped.  ALSA bug#3796:
> 	https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3796

Aren't some bits missing from this bug report? (s/o->data->state =
states[enable]/io->data->state = states[prev])
 
> diff -r 6d83f965a9d9 -r 7388ad3d21ea src/pcm/pcm_ioplug.c
> --- a/src/pcm/pcm_ioplug.c	Mon Feb 25 14:58:45 2008 +0100
> +++ b/src/pcm/pcm_ioplug.c	Mon Feb 25 15:11:46 2008 +0100
> @@ -484,7 +484,7 @@ static int snd_pcm_ioplug_pause(snd_pcm_
>  {
>  	ioplug_priv_t *io = pcm->private_data;
>  	static snd_pcm_state_t states[2] = {
> -		SND_PCM_STATE_PAUSED, SND_PCM_STATE_RUNNING
> +		SND_PCM_STATE_RUNNING, SND_PCM_STATE_PAUSED
>  	};
>  	int prev, err;
>  
> 
> 
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2008.
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> _______________________________________________
> Alsa-cvslog mailing list
> Alsa-cvslog@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-cvslog
