From: "Sutar, Mounesh" <Mounesh_Sutar@mentor.com>
Subject: Re: [PATCH v2 6/6] pcm:plug: save converter config
Date: Fri, 3 Mar 2017 10:11:00 +0000
Message-ID: <5ce06463f97c40938a10c014557c8c1f@SVR-IES-MBX-04.mgc.mentorg.com>
References: <1488180992-9180-1-git-send-email-sutar.mounesh@gmail.com>
 <s5hwpccnj88.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <s5hwpccnj88.wl-tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patch@alsa-project.org" <patch@alsa-project.org>, Andreas Pape <apape@de.adit-jv.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

This is being used from 1.0.29 version.
I had to do some coding style fixes. Have resubmitted the changes now.

Regards,
Mounesh

 -----Original Message-----
From: Takashi Iwai [mailto:tiwai@suse.de] 
Sent: 27 February 2017 13:45
To: sutar.mounesh@gmail.com
Cc: patch@alsa-project.org; alsa-devel@alsa-project.org; Sutar, Mounesh <Mounesh_Sutar@mentor.com>; Andreas Pape <apape@de.adit-jv.com>
Subject: Re: [PATCH v2 6/6] pcm:plug: save converter config

On Mon, 27 Feb 2017 08:36:32 +0100,
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
> 266707b..ad0e99e 100644
> --- a/src/pcm/pcm_plug.c
> +++ b/src/pcm/pcm_plug.c
> @@ -64,6 +64,8 @@ static int snd_pcm_plug_close(snd_pcm_t *pcm)
>  	snd_pcm_plug_t *plug = pcm->private_data;
>  	int err, result = 0;
>  	free(plug->ttable);
> +	if (plug->rate_converter)
> +		snd_config_delete((snd_config_t*)plug->rate_converter);

Set NULL after calling snd_config_delete(), so that it won't double-free.

>  	assert(plug->gen.slave == plug->req_slave);
>  	if (plug->gen.close_slave) {
>  		snd_pcm_unlink_hw_ptr(pcm, plug->req_slave); @@ -1108,7 +1110,13 @@ 
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

Missing braces.  It'll go out unconditionally.
Did you really try this patch and confirm to work...?


thanks,

Takashi
