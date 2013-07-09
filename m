From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] firewire-speakers: remove not-reused
	member from structure
Date: Tue, 09 Jul 2013 18:00:55 +0200
Message-ID: <51DC33B7.8000507@ladisch.de>
References: <1373383366-14340-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id B218A26559A
 for <alsa-devel@alsa-project.org>; Tue,  9 Jul 2013 18:00:09 +0200 (CEST)
In-Reply-To: <1373383366-14340-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> "pcm" member in struct fwspk is used to set pcm operations but is not used
> again. This commit remove this member and set pcm operations with
> snd_pcm_set_ops().
>
> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

Acked-by: Clemens Ladisch <clemens@ladisch.de>

> ---
>  sound/firewire/speakers.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/sound/firewire/speakers.c b/sound/firewire/speakers.c
> index 2c63865..fe9e6e2 100644
> --- a/sound/firewire/speakers.c
> +++ b/sound/firewire/speakers.c
> @@ -49,7 +49,6 @@ struct fwspk {
>  	struct snd_card *card;
>  	struct fw_unit *unit;
>  	const struct device_info *device_info;
> -	struct snd_pcm_substream *pcm;
>  	struct mutex mutex;
>  	struct cmp_connection connection;
>  	struct amdtp_out_stream stream;
> @@ -363,8 +362,7 @@ static int fwspk_create_pcm(struct fwspk *fwspk)
>  		return err;
>  	pcm->private_data = fwspk;
>  	strcpy(pcm->name, fwspk->device_info->short_name);
> -	fwspk->pcm = pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream;
> -	fwspk->pcm->ops = &ops;
> +	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &ops);
>  	return 0;
>  }
>
