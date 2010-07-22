From: John Lindgren <john.lindgren@tds.net>
Subject: Re: Small memory leak in snd_pcm_ladspa_init()
Date: Wed, 21 Jul 2010 22:32:51 -0400
Message-ID: <4C47ADD3.6070205@tds.net>
References: <4C4716D5.8080501@tds.net>
	<alpine.LNX.2.00.1007220013050.9258@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 15B17243E9
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Jul 2010 04:32:56 +0200 (CEST)
Received: by yxm8 with SMTP id 8so2345620yxm.38
	for <alsa-devel@alsa-project.org>; Wed, 21 Jul 2010 19:32:55 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1007220013050.9258@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Yes, that fixes it.  Thank you.

-- John

On 07/21/2010 06:13 PM, Jaroslav Kysela wrote:
> Does this patch help?
>
> diff --git a/src/pcm/pcm_ladspa.c b/src/pcm/pcm_ladspa.c
> index 5161820..c413c10 100644
> --- a/src/pcm/pcm_ladspa.c
> +++ b/src/pcm/pcm_ladspa.c
> @@ -341,6 +341,8 @@ static void snd_pcm_ladspa_free_instances(snd_pcm_t *pcm, snd_pcm_ladspa_t *lads
>   						free(instance->output.m_data[idx]);
>   					free(instance->output.m_data);
>                                   }
> +                                free(instance->input.data);
> +                                free(instance->output.data);
>   				list_del(&(instance->list));
>   				snd_pcm_ladspa_free_eps(&instance->input);
>   				snd_pcm_ladspa_free_eps(&instance->output);
>
> -----
> Jaroslav Kysela <perex@perex.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, Red Hat, Inc.
>   
