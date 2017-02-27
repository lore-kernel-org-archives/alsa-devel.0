From: "Sutar, Mounesh" <Mounesh_Sutar@mentor.com>
Subject: Re: [PATCH 6/6] pcm:plug: save converter config
Date: Mon, 27 Feb 2017 07:31:17 +0000
Message-ID: <d42899e842814fd5b769b90f6418466c@SVR-IES-MBX-04.mgc.mentorg.com>
References: <1487315882-9160-1-git-send-email-sutar.mounesh@gmail.com>
 <s5ho9y0soe9.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
 by alsa0.perex.cz (Postfix) with ESMTP id DDD0F2669AF
 for <alsa-devel@alsa-project.org>; Mon, 27 Feb 2017 08:31:21 +0100 (CET)
In-Reply-To: <s5ho9y0soe9.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>, "sutar.mounesh@gmail.com" <sutar.mounesh@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Andreas Pape <apape@de.adit-jv.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

Yes, it is redundant to delete plug->rate_converter.
The patch has been fixed and submitted.

Regards,
Mounesh


-----Original Message-----
From: Takashi Iwai [mailto:tiwai@suse.de] 
Sent: 17 February 2017 23:15
To: sutar.mounesh@gmail.com
Cc: alsa-devel@alsa-project.org; Sutar, Mounesh <Mounesh_Sutar@mentor.com>; Andreas Pape <apape@de.adit-jv.com>
Subject: Re: [PATCH 6/6] pcm:plug: save converter config

On Fri, 17 Feb 2017 08:18:02 +0100,
sutar.mounesh@gmail.com wrote:
> 
> From: Andreas Pape <apape@de.adit-jv.com>
> 
> Passed config is freed after call to open, thus it is invalid when 
> trying to extract the converter name. So config entry is saved for 
> later usage.
> 
> Signed-off-by: Andreas Pape <apape@de.adit-jv.com>
> Signed-off-by: Mounesh Sutar <sutar.mounesh@gmail.com>
> 
> diff --git a/src/pcm/pcm_plug.c b/src/pcm/pcm_plug.c index 
> 266707b..6d0c03d 100644
> --- a/src/pcm/pcm_plug.c
> +++ b/src/pcm/pcm_plug.c
> @@ -64,6 +64,8 @@ static int snd_pcm_plug_close(snd_pcm_t *pcm)
>  	snd_pcm_plug_t *plug = pcm->private_data;
>  	int err, result = 0;
>  	free(plug->ttable);
> +	if (plug->rate_converter)
> +		snd_config_delete((snd_config_t*)plug->rate_converter);
>  	assert(plug->gen.slave == plug->req_slave);
>  	if (plug->gen.close_slave) {
>  		snd_pcm_unlink_hw_ptr(pcm, plug->req_slave); @@ -1108,7 +1110,15 @@ 
> int snd_pcm_plug_open(snd_pcm_t **pcmp,
>  	plug->sformat = sformat;
>  	plug->schannels = schannels;
>  	plug->srate = srate;
> -	plug->rate_converter = rate_converter;
> +	if (rate_converter) {
> +		if ((err = snd_config_copy((snd_config_t**)&plug->rate_converter,
> +					   (snd_config_t *)rate_converter)) < 0)
> +			free(plug);
> +			return err;
> +	}
> +	else
> +		snd_config_delete((snd_config_t*)plug->rate_converter);

Why do we need to delete plug->rate_converter here...?
It's nowhere assigned after the patch?


thanks,

Takashi
