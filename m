From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] Don't check if period size is equal to
 buffer size
Date: Fri, 2 Oct 2009 10:45:31 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0910021042340.31529@eeebox2.perex-int.cz>
References: <1253026862-15411-1-git-send-email-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id B9263103901
	for <alsa-devel@alsa-project.org>;
	Fri,  2 Oct 2009 10:45:32 +0200 (CEST)
In-Reply-To: <1253026862-15411-1-git-send-email-lkundrak@v3.sk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 15 Sep 2009, Lubomir Rintel wrote:

> At least some drivers seem to allow a single period and those which
> don't would correct us anyway. Moreover, Pulseaudio with tsched sets
> this frequently.

I'm afraid, but this patch is not enough. At least chunk_size should be 
less than buffer_size otherwise you'll get underrun immediately.

 						Jaroslav

> ---
> aplay/aplay.c |    5 -----
> 1 files changed, 0 insertions(+), 5 deletions(-)
>
> diff --git a/aplay/aplay.c b/aplay/aplay.c
> index c7c82a1..4fa36cb 100644
> --- a/aplay/aplay.c
> +++ b/aplay/aplay.c
> @@ -1044,11 +1044,6 @@ static void set_params(void)
> 	}
> 	snd_pcm_hw_params_get_period_size(params, &chunk_size, 0);
> 	snd_pcm_hw_params_get_buffer_size(params, &buffer_size);
> -	if (chunk_size == buffer_size) {
> -		error(_("Can't use period equal to buffer size (%lu == %lu)"),
> -		      chunk_size, buffer_size);
> -		exit(EXIT_FAILURE);
> -	}
> 	snd_pcm_sw_params_current(handle, swparams);
> 	if (avail_min < 0)
> 		n = chunk_size;

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
