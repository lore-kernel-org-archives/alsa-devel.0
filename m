From: "Sutar, Mounesh" <Mounesh_Sutar@mentor.com>
Subject: Re: [PATCH] alsa-lib: update linked hw_ptr and appl_ptr
Date: Thu, 8 Dec 2016 10:56:12 +0000
Message-ID: <a3e36d70c04349d79c2aa36a2f384aff@SVR-IES-MBX-04.mgc.mentorg.com>
References: <1480069505-16668-1-git-send-email-sutar.mounesh@gmail.com>
 <s5hpolf5saf.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
 by alsa0.perex.cz (Postfix) with ESMTP id 099DA2673E2
 for <alsa-devel@alsa-project.org>; Thu,  8 Dec 2016 11:56:17 +0100 (CET)
In-Reply-To: <s5hpolf5saf.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "sutar.mounesh@gmail.com" <sutar.mounesh@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Andreas Pape <apape@de.adit-jv.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,
This is the update I got from Andreas:

"This is not a generic problem, but can be observed in plugins which use manual linking method.
The plugins such as PLUG, FILE, METER, MULTI and HOOK use manual linkage.
PLUG is the 'bad guy' which might change the linking in hw_param operation.
METER and MULTI might need to be fixed as well.
HOOKS does not use transfer/processing of frames, so seems harmless (but not 100% sure- linkage should be updated for completeness) 

The current fix is provided for FILE plugin ONLY"

Regards,
Mounesh


-----Original Message-----
From: Takashi Iwai [mailto:tiwai@suse.de] 
Sent: 29 November 2016 00:46
To: sutar.mounesh@gmail.com
Cc: alsa-devel@alsa-project.org; Sutar, Mounesh <Mounesh_Sutar@mentor.com>; Andreas Pape <apape@de.adit-jv.com>
Subject: Re: [PATCH] alsa-lib: update linked hw_ptr and appl_ptr

On Fri, 25 Nov 2016 11:25:05 +0100,
sutar.mounesh@gmail.com wrote:
> 
> From: Andreas Pape <apape@de.adit-jv.com>
> 
> Plugin file provides no private hw_ptr and appl_ptr but instead links them to the slave pcm.
> If the slave pcm itself changes its hw_ptr or app_prt this needs to be done in file plugin, too.
> Plugin 'plug' is such a candidate changing the hw_ptr and app_ptr in hw_params call dependent on the automatically inserted plugins.
> ALSA unfortunately has no support for automatically updating chained pointers.
> A notification on pointer change seems to be prepared inside the 
> snd_pcm_set_ptr() routine via
> rbptr->changed(), but it is not (yet) implemented so that we need to care for it manually.
> 
> Signed-off-by: Andreas Pape <apape@de.adit-jv.com>

Judging from the description, isn't it a generic problem, not specific to file plugin?


thanks,

Takashi

> ---
>  src/pcm/pcm_file.c |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/src/pcm/pcm_file.c b/src/pcm/pcm_file.c index 
> fec76eb..1e3d35b 100644
> --- a/src/pcm/pcm_file.c
> +++ b/src/pcm/pcm_file.c
> @@ -634,6 +634,14 @@ static int snd_pcm_file_hw_params(snd_pcm_t *pcm, snd_pcm_hw_params_t * params)
>  			return err;
>  		}
>  	}
> +
> +	/* pointer may have changed - e.g if plug is used. */
> +	snd_pcm_unlink_hw_ptr(pcm, file->gen.slave);
> +	snd_pcm_unlink_appl_ptr(pcm, file->gen.slave);
> +
> +	snd_pcm_link_hw_ptr(pcm, file->gen.slave);
> +	snd_pcm_link_appl_ptr(pcm, file->gen.slave);
> +
>  	return 0;
>  }
>  
> --
> 1.7.9.5
> 
