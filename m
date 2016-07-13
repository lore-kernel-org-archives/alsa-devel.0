From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [patch] ALSA: mixart: don't print an unintialized variable on
 error
Date: Wed, 13 Jul 2016 19:18:39 +0900
Message-ID: <5786157F.40908@sakamocchi.jp>
References: <20160713095953.GA29468@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20160713095953.GA29468@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>, Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On Jul 13 2016 18:59, Dan Carpenter wrote:
> My static checker complains that "resp" could be unitialized on error
> when we print its value.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> diff --git a/sound/pci/mixart/mixart_mixer.c b/sound/pci/mixart/mixart_mixer.c
> index 58fd79eb..51e5349 100644
> --- a/sound/pci/mixart/mixart_mixer.c
> +++ b/sound/pci/mixart/mixart_mixer.c
> @@ -965,7 +965,7 @@ static int mixart_update_monitoring(struct snd_mixart* chip, int channel)
>   	int err;
>   	struct mixart_msg request;
>   	struct mixart_set_out_audio_level audio_level;
> -	u32 resp;
> +	u32 resp = 0;
>
>   	if(chip->pipe_out_ana.status == PIPE_UNDEFINED)
>   		return -EINVAL; /* no pipe defined */

The 'resp' variable is firstly given to snd_mixart_send_msg().

static int mixart_update_monitoring(struct snd_mixart* chip,
                                     int channel)
{
     ...
     err = snd_mixart_send_msg(chip->mgr, &request, sizeof(resp), &resp);
     if((err<0) || resp) {
         dev_dbg(chip->card->dev,
                 "error MSG_CONNECTOR_SET_OUT_AUDIO_LEVEL card(%d) 
resp(%x)\n",
                 chip->chip_idx, resp);
         return -EINVAL;
     }
     return 0;
}

When the function, snd_mixart_send_msg(), assigns nothing to the 
variable in error cases, dev_dbg() prints uninitialized value.

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>


Regards

Takashi Sakamoto
