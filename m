From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH][next] ALSA: xen-front: fix unsigned error
 check on return from to_sndif_format
Date: Mon, 28 May 2018 07:49:03 +0900
Message-ID: <e1312bb5-35c6-7954-c87d-2d72b15d99c5@sakamocchi.jp>
References: <20180527213219.24182-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 05340267255
 for <alsa-devel@alsa-project.org>; Mon, 28 May 2018 00:49:06 +0200 (CEST)
In-Reply-To: <20180527213219.24182-1-colin.king@canonical.com>
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
To: Colin King <colin.king@canonical.com>, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, xen-devel@lists.xenproject.org, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi,

On May 28 2018 06:32, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The negative error return from the call to to_sndif_format is being
> assigned to an unsigned 8 bit integer and hence the check for a negative
> value is always going to be false.  Fix this by using ret as the error
> return and hence the negative error can be detected and assign
> the u8 sndif_format to ret if there is no error.
> 
> Detected by CoverityScan, CID#1469385 ("Unsigned compared against 0")
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   sound/xen/xen_snd_front_alsa.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/xen/xen_snd_front_alsa.c b/sound/xen/xen_snd_front_alsa.c
> index 5041f83e98d2..5a2bd70a2fa1 100644
> --- a/sound/xen/xen_snd_front_alsa.c
> +++ b/sound/xen/xen_snd_front_alsa.c
> @@ -466,13 +466,14 @@ static int alsa_prepare(struct snd_pcm_substream *substream)
>   		u8 sndif_format;
>   		int ret;
>   
> -		sndif_format = to_sndif_format(runtime->format);
> -		if (sndif_format < 0) {
> +		ret = to_sndif_format(runtime->format);
> +		if (ret < 0) {
>   			dev_err(&stream->front_info->xb_dev->dev,
>   				"Unsupported sample format: %d\n",
>   				runtime->format);
> -			return sndif_format;
> +			return ret;
>   		}
> +		sndif_format = ret;
>   
>   		ret = xen_snd_front_stream_prepare(&stream->evt_pair->req,
>   						   &stream->sh_buf,

Indeed. A typical assignment mistake. Instead, we could change the type 
of 'sndif_format' to signed int, however in this case it's not the same 
as the third argument of xen_snd_front_stream_prepare() because it is 
'u8'. This patch looks good to me.

Reviewed-by: Takashi Sakamoto <o-takashi@sakamoccchi.jp>


Regards

Takashi Sakamoto
